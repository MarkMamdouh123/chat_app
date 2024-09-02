import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.alignment,
    required this.color,
  }) : super(key: key);
  final AlignmentGeometry alignment;
  final Color color;
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
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40),
            topLeft: Radius.circular(40),
            topRight: Radius.circular(30),
          ),
          border: Border.fromBorderSide(
            BorderSide(
              width: 4,
              color: Colors.blue,
            ),
          ),
        ),
        child: Text(
          "Hello Mark its me Mario",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
