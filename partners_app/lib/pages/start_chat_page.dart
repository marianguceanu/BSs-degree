import 'package:flutter/material.dart';
import 'package:partners_app/custom/enter_chat_name_popup.dart';
import 'package:partners_app/custom/initialize_chat_pane.dart';
import 'package:partners_app/providers/chat_provider.dart';
import 'package:partners_app/providers/partners_provider.dart';
import 'package:provider/provider.dart';

class StartChatPage extends StatefulWidget {
  const StartChatPage({
    super.key,
    required this.partnerId,
  });

  final int partnerId;

  @override
  // ignore: library_private_types_in_public_api
  _StartChatPageState createState() => _StartChatPageState();
}

class _StartChatPageState extends State<StartChatPage> {
  final TextEditingController _chatNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Chat'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            // Start chat
            child: Consumer<PartnersProivders>(
              builder: (context, partnersProvider, child) {
                partnersProvider.initPartners();
                return ListView.builder(
                    itemCount: partnersProvider.partners.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Consumer<ChatProvider>(
                              builder: (context, chatProvider, child) {
                            return InitializeChatPane(
                              partnerName:
                                  partnersProvider.partners[index].businessName,
                              partnerReach:
                                  partnersProvider.partners[index].reach,
                              partnerId: widget.partnerId,
                              createChat: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EnterChatNamePopup(
                                              controller: _chatNameController,
                                              createChatCallback: () {
                                                chatProvider.addChat(
                                                    widget.partnerId,
                                                    partnersProvider
                                                        .partners[index].id,
                                                    _chatNameController
                                                        .value.text);
                                              },
                                            )));
                                // Start chat
                                _chatNameController.clear();
                              },
                            );
                          }),
                          const SizedBox(height: 15),
                        ],
                      );
                    });
              },
            )),
      ),
    );
  }
}
