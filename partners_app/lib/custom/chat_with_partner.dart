import 'package:flutter/material.dart';
import 'package:partners_app/models/chat.dart';
import 'package:partners_app/pages/chat_page.dart';

class ChatWithPartner extends StatefulWidget {
  const ChatWithPartner({
    super.key,
    required this.chat,
    required this.partnerId,
    required this.chatName,
  });

  final Chat chat;
  final int partnerId;
  final String chatName;

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
    return IconButton(
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
        ),
        onPressed: () => {_goToChatPage(context)},
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            const SizedBox(width: 10),
            const Icon(Icons.chat),
            const SizedBox(width: 20),
            Text(widget.chatName),
          ],
        ));
    // child:
  }
}
