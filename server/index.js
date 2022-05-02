//! IMPORTING MODULES
const express = require('express');
const http = require('http');
const mongoose = require('mongoose');

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const Room = require('./models/room');

var io = require("socket.io")(server);

//! middle ware - data from the client would pass through to the server
app.use(express.json());

const DB = 'mongodb+srv://kiishi:myGmail100@cluster0.zrazn.mongodb.net/myFirstDatabase?retryWrites=true&w=majority';

io.on("connection", (socket) => {
    console.log('connected!');
    socket.on('createRoom', async ({ nickname }) => {
        console.log(nickname);
        try {
            //room is created
            let room = new Room();
            //player is stored in the room
            let player = {
                socketID: socket.id,
                nickname,
                playerType: 'X',
            };
            room.players.push(player);
            room.turn = player;
            room = await room.save();
            console.log(room);

            const roomId = room._id.toString();
            socket.join(roomId);

            //player is taken to the next screen
            io.to(roomId).emit('createRoomSuccess', room);
        } catch (e) {
            console.log(e);
        }
    });

    socket.on('joinRoom', async ({ nickname, roomId }) => {
        try {
            if (!roomId.match(/^[0-9A-fA-F]{24}$/)) {
                socket.emit('errorOccurred', 'Please enter a valid game ID.');
                return;
            }
            let room = await Room.findById(roomId);

            if (room.isJoin) {
                let player = {
                    nickname,
                    socketID: socket.id,
                    playerType: 'O',
                }
                socket.join(roomId);
                room.players.push(player);
                room.isJoin = false;
                room = await room.save();
                io.to(roomId).emit('joinRoomSuccess', room);
                io.to(roomId).emit('updatePlayers', room.players);
                io.to(roomId).emit('updateRoom', room);
            } else {
                socket.emit('errorOccurred', 'The game is in progress, try again later');
            }
        } catch (e) {
            console.log(e);
        }
    });

    socket.on('tap', async ({ index, roomId }) => {
        try {
            let room = await Room.findById(roomId);
            let choice = room.turn.playerType; //! x OR 0
            if (room.turnIndex == 0) {
                room.turn = room.players[1];
                room.turnIndex = 1;
            } else {
                room.turn = room.players[0];
                room.turnIndex = 0;
            }
            room = await room.save();

            io.to(roomId).emit('tapped', {
                index,
                choice,
                room,
            })
        } catch (e) {
            console.log(e);
        }
    });

    socket.on('winner', async ({ winnerSocketId, roomId }) => {
        try {
            let room = await Room.findById(roomId);
            let player = room.players.find((playerr) => playerr.socketID == winnerSocketId);
            player.points += 1; 
            room = await room.save();

            if (player.point >= room.maxRounds) {
                io.to(roomId).emit('endGame', player);
            } else {
                io.to(roomId).emit('pointIncrease', player);
            }
        } catch (e) {
            console.log(e);
        }
    });
});

mongoose.connect(DB).then(() => {
    console.log('Connection successful!');
}).catch((e) => {
    console.log(e);
});

server.listen(port, '0.0.0.0', () => {
    console.log(`Server started and running on port ${port}`);
});