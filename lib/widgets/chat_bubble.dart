import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message_model.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.alignment,
    required this.color,
    required this.message,
    required this.id,
  }) : super(key: key);
  final AlignmentGeometry alignment;
  final Color color;
  final MessageModel message;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 210,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        decoration: BoxDecoration(
          color: color,
          borderRadius: message.id == id
              ? BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(30),
                )
              : BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(30),
                ),
          border: Border.fromBorderSide(
            BorderSide(
              width: 4,
              color: color,
            ),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
