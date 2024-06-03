import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:partners_app/models/chat.dart';
import 'package:partners_app/services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final ChatService chatService;
  int _partnerId = 0;

  ChatProvider({required this.chatService});

  List<Chat> chats = [];
  UnmodifiableListView<Chat> get chatsList => UnmodifiableListView(chats);
  int get partnerId => _partnerId;

  Future<void> initChats() async {
    chats = await chatService.getChats() ?? [];
    _partnerId = await chatService.getPartnerId();
    notifyListeners();
  }

  Future<void> addChat(int partner1Id, int partner2Id, String chatName) async {
    int id = await chatService.addChat(partner1Id, partner2Id, chatName);
    chats.add(Chat(id: id, chatName: chatName));
    notifyListeners();
  }
}
