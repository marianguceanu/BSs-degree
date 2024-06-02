import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:partners_app/constants/api_urls.dart';
import 'package:partners_app/models/message.dart';
import 'package:partners_app/services/storage_service.dart';

class MessagesApiService {
  Future<List<Message>> getMessages(int chatId) async {
    // Building the get messages URL
    String url = "${UrlConstants.base}${UrlConstants.messages}/chat_id=$chatId";

    // Getting the token from storage
    String? cookie = await storageService.read(cookieKey);

    // Making the GET request
    http.Response response = await http.get(Uri.parse(url), headers: {
      'cookie': cookie ?? '',
    });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Message> messages =
          body.map((message) => Message.fromJson(message)).toList();
      return messages;
    } else {
      throw 'Failed to load messages';
    }
  }

  Future<int> addMessage(Message message) async {
    // Building the add message URL
    String url = "${UrlConstants.base}${UrlConstants.messages}";
    // Getting the token from storage
    String? cookie = await storageService.read(cookieKey);

    // Making the POST request
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'cookie': cookie ?? '',
        },
        body: jsonEncode(message.toJson()));

    Message newMessage = Message.fromJson(jsonDecode(response.body));

    return newMessage.messageId;
  }
}

final messagesApiService = MessagesApiService();
