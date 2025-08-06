import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatService {
  final String _apiKey = 'YOUR_OPENAI_API_KEY';
  final String _endpoint = 'https://api.openai.com/v1/chat/completions';

  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': message},
        ],
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].toString().trim();
    } else {
      return 'Error: ${response.statusCode}';
    }
  }
}
