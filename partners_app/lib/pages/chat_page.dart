import 'package:flutter/material.dart';
import 'package:partners_app/custom/messages_list.dart';
import 'package:partners_app/custom/send_message_text_field.dart';
import 'package:partners_app/models/chat.dart';
import 'package:partners_app/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.chat, required this.partnerId});
  final Chat chat;
  final int partnerId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatService, child) {
      return Scaffold(
          appBar: AppBar(title: Text(widget.chat.chatName)),
          body: Column(children: [
            MessagesList(chatId: widget.chat.id),
            SendMessageTextField(
              controller: _messageController,
              chatId: widget.chat.id,
              senderId: widget.partnerId,
            )
          ]));
    });
  }
}
