import 'package:flutter/material.dart';
import 'package:partners_app/providers/chat_provider.dart';
import 'package:partners_app/providers/messages_provider.dart';
import 'package:partners_app/providers/partners_provider.dart';
import 'package:partners_app/services/chat_service.dart';
import 'package:partners_app/services/messages_service.dart';
import 'package:partners_app/services/partner_service.dart';
import 'package:provider/provider.dart';

import 'pages/login_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => ChatProvider(chatService: ChatService())),
      ChangeNotifierProvider(
          create: (_) =>
              MessagesProvider(messagesApiService: MessagesApiService())),
      ChangeNotifierProvider(
          create: (_) =>
              PartnersProivders(partnersApiService: PartnerApiService()))
    ],
    child: const PartnersApp(),
  ));
}

class PartnersApp extends StatelessWidget {
  const PartnersApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
