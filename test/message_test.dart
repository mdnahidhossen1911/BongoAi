import 'package:bongoai/models/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Message Model', () {
    test('should create a user message', () {
      final msg = Message(text: 'Hello', isUser: true);
      expect(msg.text, 'Hello');
      expect(msg.isUser, true);
    });

    test('should create a bot message', () {
      final msg = Message(text: 'Hi there', isUser: false);
      expect(msg.text, 'Hi there');
      expect(msg.isUser, false);
    });
  });
}
