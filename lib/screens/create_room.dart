import 'package:flutter/material.dart';
import 'package:xando/resources/socket_methods.dart';
import 'package:xando/responsive/responsive_layout.dart';
import 'package:xando/widgets/button.dart';
import 'package:xando/widgets/custom_text.dart';
import 'package:xando/widgets/custom_textfield.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveLayout(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  ),
                ],
                text: 'Create room',
                fontSize: 70,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter your nickname ',
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Button(
                onTap: () => _socketMethods.createRoom(_nameController.text),
                text: 'Create',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
