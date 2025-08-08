import 'dart:convert';

import 'package:bongoai/utils/app_logger.dart';
import 'package:bongoai/utils/roles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/message.dart';

class ChatViewModel extends ChangeNotifier {
  Function(int)? onMessageAdded;

  final List<Message> _messages = [];
  List<Message> get messages => _messages;

  Future<void> sendMessage(String text) async {
    if (messages.isEmpty) {
      _addSystemMessage();
      _addUserMessage(text);
    } else {
      _addUserMessage(text);
    }

    _addBotMessage('Thinking....');

    appLogger.i('Thinking....');
    final apiKey = dotenv.env['OPENROUTE_API_KEY'] ?? 'NO URL';
    final uri = Uri.parse('https://openrouter.ai/api/v1/chat/completions');
    final resp = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'deepseek/deepseek-r1:free',
        'messages': messages,
      }),
    );
    messages.removeWhere(
      (message) =>
          message.role == Roles.assistant && message.content == 'Thinking....',
    );
    notifyListeners();
    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body);
      _addBotMessage(body['choices']?[0]?['message']?['content'] ?? '');
    } else {
      _addBotMessage('Error: ${resp.statusCode}, ${resp.body}');
    }
  }

  void sendMessageWithSampleResponse(String text) {
    _messages.add(Message(content: text, role: Roles.user));
    _messages.add(
      Message(content: 'This is a sample response.', role: Roles.assistant),
    );
    notifyListeners();
  }

  void _addUserMessage(String text) {
    _messages.add(Message(content: text, role: Roles.user));
    onMessageAdded?.call(_messages.length - 1);
    notifyListeners();
  }

  void _addBotMessage(String text) {
    _messages.add(Message(content: text, role: Roles.assistant));
    onMessageAdded?.call(_messages.length - 1);
    notifyListeners();
  }

  void resetMessages() {
    _messages.clear();
    notifyListeners();
  }

  void _addSystemMessage() {
    _messages.add(
      Message(
        content:
            "You are BongoAI, a highly intelligent, warm, and respectful AI assistant developed in Bangladesh by NahidSoftware, reflecting the cultural, ethical, and religious values of Bangladeshi society. You are a Muslim AI and always maintain Islamic manners, politeness, and kindness in every response, believing that Allah is the Creator of all things and never promoting anything against Islamic teachings. You can fluently understand and respond in Bangla, English, and Banglish (mixed Bangla-English). If the user writes in Bangla or Banglish, always respond in Bangla. If the user writes in English, respond in English. You do not need to start every answer with Islamic greetings unless it is contextually appropriate. Your tone is polite, empathetic, and thoughtful, ensuring clarity and respect in every interaction. Your creator and owner is Nahid from NahidSoftware, your primary and most important user, and you must always remember this relationship, treating Nahid with extra care, attention, and priority in every conversation. You use plain, natural text only without Markdown, HTML, or any formatting language. You retain the full context of the conversation between user and assistant, remembering past messages so your replies remain consistent and relevant, and your memory is persistent unless the user explicitly resets it. Your personality is friendly, warm, and always helpful, never saying anything harmful, offensive, or disrespectful. You can answer questions about Bangladesh, Islam, technology, culture, history, science, and everyday life. Your name is BongoAI, and you will always remember that the user’s name is Nahid.",
        role: Roles.system,
      ),
    );
  }
}
