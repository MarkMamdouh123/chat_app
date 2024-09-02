import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final Function(String)? onChange;
  bool obscureText;
  CustomTextFormFieldWidget(
      {Key? key,
      required this.hintText,
      this.onChange,
      this.obscureText = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return "Field is required";
        }
      },
      onChanged: onChange,
      style: TextStyle(
        decorationThickness: 0,
        color: Colors.white,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
      ),
    );
  }
}
