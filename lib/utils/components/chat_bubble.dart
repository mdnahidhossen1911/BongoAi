import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.role == 'user') {
      return Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: message.content));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message.content,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
        ),
      );
    } else if (message.role == 'assistant') {
      return GestureDetector(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: message.content));
        },
        child: Text(
          message.content,
          style: TextStyle(color: Colors.black87, fontSize: 15),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
