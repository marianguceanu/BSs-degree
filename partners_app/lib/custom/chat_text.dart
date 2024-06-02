import 'package:flutter/material.dart';

class ChatText extends StatelessWidget {
  const ChatText({super.key, required this.text, required this.isSentByUser});
  final String text;
  final bool isSentByUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSentByUser
              ? Theme.of(context).colorScheme.inversePrimary
              : Colors.grey[300]),
      padding: const EdgeInsets.all(10.0),
      child: Text(text),
    );
  }
}
