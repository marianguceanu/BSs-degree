import 'package:flutter/material.dart';

class InitializeChatPane extends StatefulWidget {
  const InitializeChatPane({
    super.key,
    required this.partnerId,
    required this.partnerReach,
    required this.partnerName,
    required this.createChat,
  });

  final int partnerId;
  final int partnerReach;
  final String partnerName;
  final Function createChat;

  @override
  // ignore: library_private_types_in_public_api
  _InitializeChatPaneState createState() => _InitializeChatPaneState();
}

class _InitializeChatPaneState extends State<InitializeChatPane> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${widget.partnerName}'),
            Text('Reach: ${widget.partnerReach}'),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            widget.createChat().then(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Chat started'),
                ),
              );
            });
          },
          child: const Text('Start Chat'),
        ),
      ],
    );
  }
}
