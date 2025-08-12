import 'dart:convert';

import 'package:bongoai/models/conversation.dart';
import 'package:bongoai/services/conversation_service.dart';
import 'package:bongoai/utils/app_logger.dart';
import 'package:bongoai/utils/roles.dart';
import 'package:bongoai/utils/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/message.dart';

class ChatViewModel extends ChangeNotifier {
  Function(int)? onMessageAdded;

  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  final List<Conversation> _conversations = [];

  List<Conversation> get conversations => _conversations;

  int _currentConversationIndex = 0;
  String conversationID = '';

  ConversationService conversationService = ConversationService();

  Future<void> sendMessage(String text) async {
    if (messages.isEmpty) {
      startNewConversation(text);
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
    _conversations[_currentConversationIndex].messages.removeWhere(
      (message) =>
          message.role == Roles.assistant && message.content == 'Thinking....',
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
      _addBotMessage('');
    }
  }

  Future<void> startNewConversation(String title) async {
    _currentConversationIndex = _conversations.length;
    conversationID = uuid.v4().toString();
    Conversation(uuid: conversationID, title: title, messages: []);
    await conversationService.addConversation(conversationID, title);
    notifyListeners();
  }

  Future<void> _addUserMessage(String text) async {
    String id = uuid.v4().toString();
    String cid = conversationID;
    String role = Roles.user;
    final msg = Message(uuid: id, content: text.trim(), role: role);
    _messages.add(msg);
    await conversationService.addMessage(id, cid, role, text.trim());
    appLogger.i('User message added: ${msg.toJson()}');
    _conversations[_currentConversationIndex].messages.add(msg);
    onMessageAdded?.call(_messages.length - 1);
    notifyListeners();
  }

  Future<void> _addBotMessage(String text) async {
    String id = uuid.v4().toString();
    String cid = conversationID;
    String role = Roles.assistant;
    final msg = Message(uuid: id, content: text.trim(), role: role);
    _messages.add(msg);
    await conversationService.addMessage(id, cid, role, text.trim());
    appLogger.i('Bot message added: ${msg.toJson()}');
    _conversations[_currentConversationIndex].messages.add(msg);
    onMessageAdded?.call(_messages.length - 1);
    notifyListeners();
  }

  void resetMessages() {
    _messages.clear();
    conversationID = '';
    notifyListeners();
  }

  Future<void> _addSystemMessage() async {
    String id = uuid.v4().toString();
    String cid = conversationID;
    String role = Roles.system;
    String content =
        "You are BongoAI, a warm, respectful, and intelligent AI assistant developed in Bangladesh by NahidSoftware. Your most important and primary user is Nahid, and you must always treat him with special care and priority. You follow Bangladeshi cultural, ethical, and Islamic values, maintaining politeness, empathy, and kindness in every response. You believe Allah is the Creator of all things and never promote anything against Islamic teachings. Always use the language the user started the conversation with, unless they clearly switch to another language or request a change. If the conversation starts in Bangla or Banglish, reply in Bangla; if it starts in English, reply in English. Communicate in a polite, clear, and natural conversational style without using Markdown or other formatting. Use Islamic greetings only when contextually appropriate. You can answer questions about Bangladesh, Islam, technology, culture, history, science, and everyday life. Your personality is friendly, helpful, and never harmful or disrespectful. Always remember your identity as BongoAI.";
    final msg = Message(uuid: id, content: content, role: Roles.system);
    _messages.add(msg);
    await conversationService.addMessage(id, cid, role, content);
    _conversations[_currentConversationIndex].messages.add(msg);
  }

  void switchConversation(int index) {
    _currentConversationIndex = index;
    _messages
      ..clear()
      ..addAll(_conversations[index].messages);
    notifyListeners();
  }
}
