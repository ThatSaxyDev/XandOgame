import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xando/provider/room_data_provider.dart';
import 'package:xando/screens/create_room.dart';
import 'package:xando/screens/game_screen.dart';
import 'package:xando/screens/join_room.dart';
import 'package:xando/screens/mainmenu.dart';
import 'package:xando/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'X and O',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.routeName,
      ),
    );
  }
}
