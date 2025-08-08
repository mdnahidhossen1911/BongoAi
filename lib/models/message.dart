// Model for a chat message
class Message {
  final String content;
  late final String role;
  Message({required this.role, required this.content});

  Map<String, dynamic> toJson() => {'role': role, 'content': content};

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(role: json['role'] as String, content: json['content'] as String);
}
