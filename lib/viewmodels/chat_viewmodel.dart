import 'package:bongoai/locator.dart';
import 'package:bongoai/utils/roles.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';
import '../services/chat_service.dart';

class ChatViewModel extends ChangeNotifier {
  final List<Message> _messages = [];
  List<Message> get messages => _messages;

  final ChatService _chatService = serviceLocator<ChatService>();

  Future<void> sendMessage(String text) async {
    _messages.add(Message(content: text, role: Roles.user));
    notifyListeners();
    final response = await _chatService.sendMessage(text);
    _messages.add(Message(content: response, role: Roles.assistant));
    notifyListeners();
  }

  void sendMessageWithSampleResponse(String text) {
    _messages.add(Message(content: text, role: Roles.user));
    _messages.add(
      Message(content: 'This is a sample response.', role: Roles.assistant),
    );
    notifyListeners();
  }

  void addUserMessage(String text) {
    _messages.add(Message(content: text, role: Roles.user));
    notifyListeners();
  }

  void addBotMessage(String text) {
    _messages.add(Message(content: text, role: Roles.assistant));
    notifyListeners();
  }
}
