import 'package:bongoai/locator.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';
import '../services/chat_service.dart';

class ChatViewModel extends ChangeNotifier {
  final List<Message> _messages = [];
  List<Message> get messages => _messages;

  final ChatService _chatService = serviceLocator<ChatService>();

  Future<void> sendMessage(String text) async {
    _messages.add(Message(text: text, isUser: true));
    notifyListeners();
    final response = await _chatService.sendMessage(text);
    _messages.add(Message(text: response, isUser: false));
    notifyListeners();
  }

  void sendMessageWithSampleResponse(String text) {
    _messages.add(Message(text: text, isUser: true));
    _messages.add(Message(text: 'This is a sample response.', isUser: false));
    notifyListeners();
  }

  void addUserMessage(String text) {
    _messages.add(Message(text: text, isUser: true));
    notifyListeners();
  }

  void addBotMessage(String text) {
    _messages.add(Message(text: text, isUser: false));
    notifyListeners();
  }

  void updateBotMessage(int index, String newText) {
    if (index >= 0 && index < _messages.length && !_messages[index].isUser) {
      _messages[index] = Message(text: newText, isUser: false);
      notifyListeners();
    }
  }
}
