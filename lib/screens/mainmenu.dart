import 'package:flutter/material.dart';
import 'package:xando/responsive/responsive_layout.dart';
import 'package:xando/screens/create_room.dart';
import 'package:xando/screens/join_room.dart';
import 'package:xando/widgets/button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({Key? key}) : super(key: key);

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Center(
                child: Text(
                  'X',
                  style: TextStyle(fontSize: 150),
                ),
              ),
              Column(
                children: [
                  Button(
                    onTap: () => createRoom(context),
                    text: 'Create room',
                  ),
                  const SizedBox(height: 20),
                  Button(
                    onTap: () => joinRoom(context),
                    text: 'Join room',
                  ),
                ],
              ),
              const Center(
                child: Text(
                  'O',
                  style: TextStyle(fontSize: 150),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
