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

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollToBottom();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = View.of(context).viewInsets.bottom;
    if (bottomInset > 0) {
      // Keyboard is shown
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatService, child) {
      return Scaffold(
          appBar: AppBar(title: Text(widget.chat.chatName)),
          body: Column(children: [
            MessagesList(
              chatId: widget.chat.id,
              scrollController: _scrollController,
            ),
            SendMessageTextField(
              controller: _messageController,
              chatId: widget.chat.id,
              senderId: widget.partnerId,
              onTap: _scrollToBottom,
            )
          ]));
    });
  }
}
