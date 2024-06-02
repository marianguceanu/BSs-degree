class Message {
  final int messageId;
  final int chatId;
  final int senderId;
  final String text;
  final DateTime dateSent;
  final bool isRead;

  Message({
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.dateSent,
    required this.isRead,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['message_id'],
      chatId: json['chat_id'],
      senderId: json['sender_id'],
      text: json['text'],
      dateSent: DateTime.parse(json['date_sent']),
      isRead: json['is_read'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'chat_id': chatId,
      'sender_id': senderId,
      'text': text,
      'date_sent': dateSent.toIso8601String(),
      'is_read': isRead,
    };
  }
}
