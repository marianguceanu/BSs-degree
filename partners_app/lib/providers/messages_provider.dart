import 'package:flutter/material.dart';
import 'package:partners_app/models/message.dart';
import 'package:partners_app/services/messages_service.dart';

class MessagesProvider extends ChangeNotifier {
  MessagesProvider({required this.messagesApiService});

  List<Message> _messages = [];
  final MessagesApiService messagesApiService;

  List<Message> get messages => _messages;

  Future<void> initMessages(int chatId) async {
    _messages = await messagesApiService.getMessages(chatId);
    notifyListeners();
  }

  Future<void> addMessage(Message message) async {
    int id = await messagesApiService.addMessage(message);
    if (id != 0) {
      // We have to unpack all of this because the param is final and we can't change it's id
      _messages.add(Message(
        messageId: id,
        chatId: message.chatId,
        senderId: message.senderId,
        text: message.text,
        isRead: message.isRead,
        dateSent: message.dateSent,
      ));
      notifyListeners();
    }
  }
}
