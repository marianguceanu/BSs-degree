import 'package:flutter/material.dart';
import 'package:partners_app/models/chat.dart';
import 'package:partners_app/pages/chat_page.dart';

class ChatWithPartner extends StatefulWidget {
  const ChatWithPartner({
    super.key,
    required this.chat,
    required this.partnerId,
  });

  final Chat chat;
  final int partnerId;

  @override
  State<ChatWithPartner> createState() => _ChatWithPartnerState();
}

class _ChatWithPartnerState extends State<ChatWithPartner> {
  void _goToChatPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatPage(
                chat: widget.chat,
                partnerId: widget.partnerId,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
          backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
          minimumSize: MaterialStateProperty.all(const Size(50, 20)),
        ),
        onPressed: () => {_goToChatPage(context)},
        child: const Text('Go'));
  }
}
