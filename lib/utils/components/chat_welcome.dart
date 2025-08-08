import 'package:bongoai/utils/components/app_logo.dart';
import 'package:flutter/material.dart';

class ChatWelcome extends StatelessWidget {
  final String name;
  final String description;
  final double animationSize;
  const ChatWelcome({
    super.key,
    this.description =
        "Ask me anything what's are on your mind.\nAm here to assist you!",
    this.animationSize = 200,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        AppLogo(height: 100, width: 90),
        const SizedBox(height: 16),
        Text(
          'Hello, $name!\nAm ready for help you',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
