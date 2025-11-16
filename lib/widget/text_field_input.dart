import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String hibtText;
  final TextInputType textInputType;
  final bool isPass;
  const TextFieldInput({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.hibtText,
    this.isPass = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hibtText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
