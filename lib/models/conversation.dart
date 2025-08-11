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
}
