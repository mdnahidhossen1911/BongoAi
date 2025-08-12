class Message {
  final String uuid;
  final String content;
  late final String role;

  Message({required this.role, required this.content, required this.uuid});

  Map<String, dynamic> toJson() => {
    'role': role,
    'content': content,
    'uuid': uuid,
  };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    role: json['role'] as String,
    content: json['content'] as String,
    uuid: json['id'] as String,
  );
}
