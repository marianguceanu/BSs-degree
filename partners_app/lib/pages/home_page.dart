import 'package:flutter/material.dart';
import 'package:partners_app/custom/chat_with_partner.dart';
import 'package:partners_app/pages/start_chat_page.dart';
import 'package:partners_app/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _partnerId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Chat Page')),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(child: Consumer<ChatProvider>(
                  builder: (context, chatProvider, child) {
                chatProvider.initChats();
                _partnerId = chatProvider.partnerId;
                return ListView.builder(
                    itemCount: chatProvider.chats.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(chatProvider.chats[index].chatName),
                              ChatWithPartner(
                                chat: chatProvider.chats[index],
                                partnerId: chatProvider.partnerId,
                              )
                            ],
                          ));
                    });
              })),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            isExtended: true,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StartChatPage(
                    partnerId: _partnerId,
                  ),
                ),
              );
            }));
  }
}
