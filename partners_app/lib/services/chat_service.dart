import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:partners_app/constants/api_urls.dart';
import 'package:partners_app/models/chat.dart';
import 'package:partners_app/services/storage_service.dart';

class ChatService {
  Future<List<Chat>?> getChats() async {
    // Building the get chats URL
    const String url =
        "${UrlConstants.base}${UrlConstants.user}/get${UrlConstants.chats}";

    // Getting the token from storage
    String? cookie = await storageService.read(cookieKey);

    // Making the GET request
    http.Response response = await http.get(Uri.parse(url), headers: {
      'cookie': cookie ?? '',
    });

    if (response.statusCode == 200) {
      List<dynamic>? body = jsonDecode(response.body);
      if (body == null) return null;
      List<Chat> chats = body.map((chat) => Chat.fromJson(chat)).toList();
      return chats;
    } else {
      throw 'Failed to load chats';
    }
  }

  Future<int> addChat(int partner1Id, int partner2Id, String chatName) async {
    String url =
        "${UrlConstants.base}${UrlConstants.chats}/partner1_id=$partner1Id/partner2_id=$partner2Id";

    String? cookie = await storageService.read(cookieKey);

    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'cookie': cookie ?? '',
        },
        body: jsonEncode(Chat(id: 0, chatName: chatName).toJson()));

    Chat chat = Chat.fromJson(jsonDecode(response.body));

    return chat.id;
  }

  Future<int> getPartnerId() async {
    const String url =
        UrlConstants.base + UrlConstants.user + UrlConstants.getId;
    // Getting the token from storage
    String? cookie = await storageService.read(cookieKey);

    // Making the GET request
    http.Response response = await http.get(Uri.parse(url), headers: {
      'cookie': cookie ?? '',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body);
      await storageService.write(partnerIdKey, resp['partner_id'].toString());
      return resp['partner_id']!;
    } else {
      return 0;
    }
  }
}

final chatService = ChatService();
