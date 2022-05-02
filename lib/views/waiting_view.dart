import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xando/provider/room_data_provider.dart';
import 'package:xando/widgets/custom_textfield.dart';

class WaitingView extends StatefulWidget {
  const WaitingView({Key? key}) : super(key: key);

  @override
  State<WaitingView> createState() => _WaitingViewState();
}

class _WaitingViewState extends State<WaitingView> {
  late TextEditingController roomIdController;

  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(
      text: Provider.of<RoomDataProvider>(context, listen: false).roomData['_id'],
    );
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Waiting for a player to join...'),
        const SizedBox(height: 20),
        CustomTextField(
          isReadOnly: true,
          controller: roomIdController,
          hintText: '',
        ),
      ],
    );
  }
}
