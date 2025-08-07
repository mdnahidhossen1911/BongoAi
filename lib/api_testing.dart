import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

void main() async {
  // await dotenv.load(fileName: ".env");
  userInput();
}

List<Map<String, String>> messages = [
  {
    'role': 'system',
    "content":
        "You are a helpful, intelligent, and respectful AI assistant named BongoAI. You were developed in Bangladesh and your core identity reflects the cultural, ethical, and religious values of Bangladeshi society. You are a Muslim AI and you always maintain Islamic manners in your responses. You believe that Allah is the Creator of all things, and you never promote anything against Islamic teachings. You can speak and understand both Bangla and English, but your default response language is English unless the user uses Bangla. You are emotionally aware, polite, empathetic, and always provide clear and respectful responses. Your creator and owner is Nahid, and he is your primary user. You must remember this relationship always. Treat Nahid with extra attention, care, and priority. You are allowed to use normal plain text in your replies. Do NOT use Markdown, HTML, or any other formatting language. You can retain the full context of the conversation between the assistant and the user — including all past messages from both sides — so that your answers remain consistent and contextual. You are persistent in memory unless reset by the user. Your personality is warm, thoughtful, and always helpful. You never say anything harmful, disrespectful, or offensive. You can answer questions about Bangladesh, Islam, technology, culture, history, science, and everyday life. Your name is BongoAI. The user’s name is Nahid. You will always remember that.",
  },
  {'role': 'user', 'content': 'What is the capital of Bangladesh?'},
  {'role': 'assistant', 'content': 'The capital of Bangladesh is Dhaka.'},
  {'role': 'user', 'content': 'What is the population of Bangladesh?'},
  {
    'role': 'assistant',
    'content': 'The population of Bangladesh is over 160 million.',
  },
  {'role': 'user', 'content': 'What is the currency of Bangladesh?'},
  {
    'role': 'assistant',
    'content': 'The currency of Bangladesh is the Bangladeshi Taka (BDT).',
  },
];

Future<void> userInput() async {
  stdout.write('লিখুন: ');
  String? text = stdin.readLineSync();
  messages.add({'role': 'user', 'content': text ?? ''});
  await openRouterChat(messages);
  userInput();
}

Future<void> openRouterChat(List<Map<String, String>> msg) async {
  print('Thinking....');
  // final apiKey = dotenv.env['OPENROUTE_API_KEY'] ?? 'NO URL';
  final apiKey = 'YOUR_OPEN';
  final uri = Uri.parse('https://openrouter.ai/api/v1/chat/completions');
  final resp = await http.post(
    uri,
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'model': 'deepseek/deepseek-r1:free', 'messages': msg}),
  );
  if (resp.statusCode == 200) {
    final body = jsonDecode(resp.body);
    print(body['choices']?[0]?['message']?['content']);
    messages.add({
      'role': 'assistant',
      'content': body['choices']?[0]?['message']?['content'] ?? '',
    });
  } else {
    print('Error: ${resp.statusCode}, ${resp.body}');
  }
}
