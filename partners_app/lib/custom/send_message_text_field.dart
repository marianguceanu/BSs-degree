import 'package:flutter/material.dart';
import 'package:partners_app/models/message.dart';
import 'package:partners_app/providers/messages_provider.dart';
import 'package:provider/provider.dart';

class SendMessageTextField extends StatefulWidget {
  const SendMessageTextField({
    super.key,
    required this.controller,
    required this.chatId,
    required this.senderId,
  });

  final TextEditingController controller;
  final int chatId;
  final int senderId;

  @override
  State<SendMessageTextField> createState() => _SendMessageTextFieldState();
}

class _SendMessageTextFieldState extends State<SendMessageTextField> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MessagesProvider>(
        builder: (context, messagesProvider, child) {
      return TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(10),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          hintText: 'Enter your message',
          suffixIcon: IconButton(
              onPressed: () {
                messagesProvider.addMessage(Message(
                  messageId: 0,
                  chatId: widget.chatId,
                  senderId: widget.senderId,
                  text: widget.controller.text,
                  isRead: false,
                  dateSent: DateTime.now(),
                ));
                widget.controller.clear();
              },
              icon: const Icon(Icons.send)),
        ),
        controller: widget.controller,
      );
    });
  }
}
