import 'package:flutter/material.dart';
import 'package:partners_app/custom/chat_text.dart';
import 'package:partners_app/providers/messages_provider.dart';
import 'package:partners_app/services/partner_service.dart';
import 'package:provider/provider.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({
    super.key,
    required this.chatId,
    required this.scrollController,
  });
  final int chatId;
  final ScrollController scrollController;

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList>
    with WidgetsBindingObserver {
  int partnerId = 0;

  Future<void> _initPartnerId() async {
    partnerService.getPartnerId().then((value) {
      setState(() {
        partnerId = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initPartnerId();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use the Consumer widget to get the messages from the MessagesProvider
    // We'll also use the consumer widget to add messages
    return Expanded(child: Consumer<MessagesProvider>(
      builder: (context, messagesProvider, child) {
        messagesProvider.initMessages(widget.chatId);
        return ListView.builder(
          controller: widget.scrollController,
          itemCount: messagesProvider.messages.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(2),
              alignment: messagesProvider.messages[index].senderId == partnerId
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: ChatText(
                text: messagesProvider.messages[index].text,
                isSentByUser:
                    messagesProvider.messages[index].senderId == partnerId,
              ),
            );
          },
        );
      },
    ));
  }
}
