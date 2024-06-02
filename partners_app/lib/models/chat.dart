class Chat {
  int id;
  String chatName;

  Chat({
    required this.id,
    required this.chatName,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['chat_id'],
      chatName: json['chat_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'chat_id': id, 'chat_name': chatName};
  }
}
