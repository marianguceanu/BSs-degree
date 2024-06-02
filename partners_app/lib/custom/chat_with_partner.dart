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
        onPressed: () => {_goToChatPage(context)},
        child: Text(widget.chat.chatName));
  }
}
