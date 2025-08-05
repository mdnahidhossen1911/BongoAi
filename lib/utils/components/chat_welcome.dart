import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/assets_path.dart';

class ChatWelcome extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final double animationSize;
  const ChatWelcome({
    super.key,
    this.title = 'Hello, User!',
    this.subtitle = 'How can I help you today?',
    this.description =
        "Ask me anything what's on your mind.\nI'm here to assist you!",
    this.animationSize = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          AssetsPath.lottieAnimation,
          width: animationSize,
          height: animationSize,
          fit: BoxFit.contain,
          repeat: true,
          animate: true,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
