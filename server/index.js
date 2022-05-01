//! IMPORTING MODULES
const express = require('express');
const http = require('http');
const mongoose = require('mongoose');

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);

var io = require("socket.io")(server);

//! middle ware - data from the client would pass through to the server
app.use(express.json());

const DB = 'mongodb+srv://kiishi:myGmail100@cluster0.zrazn.mongodb.net/myFirstDatabase?retryWrites=true&w=majority';

io.on("connection", (socket) => {
    console.log('connected!');
    socket.on('createRoom', ({ nickname }) => {
        console.log(nickname);
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