import 'package:flutter/material.dart';

class EnterChatNamePopup extends StatefulWidget {
  const EnterChatNamePopup(
      {super.key, required this.controller, required this.createChatCallback});

  final TextEditingController controller;
  final Function createChatCallback;

  @override
  // ignore: library_private_types_in_public_api
  _EnterChatNamePopupState createState() => _EnterChatNamePopupState();
}

class _EnterChatNamePopupState extends State<EnterChatNamePopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Chat Name'),
      content: TextField(
        controller: widget.controller,
        decoration: const InputDecoration(
          hintText: 'Chat Name',
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.createChatCallback();
            Navigator.of(context).pop();
          },
          child: const Text('Create Chat'),
        ),
      ],
    );
  }
}
