import 'message.dart';

class Conversation {
  final String uuid;
  final String title;
  final List<Message> messages;

  Conversation({
    required this.title,
    required this.messages,
    required this.uuid,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'title': title,
      'messages': messages.map((msg) => msg.toJson()).toList(),
    };
  }

  factory Conversation.fromJson(item) {
    return Conversation(
      uuid: item['id'] as String,
      title: item['title'] as String,
      messages:
          (item['messages'] as List)
              .map((msg) => Message.fromJson(msg))
              .toList(),
    );
  }
}
