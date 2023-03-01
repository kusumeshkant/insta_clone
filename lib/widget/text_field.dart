import 'package:flutter/material.dart';

class TextFieldinput extends StatelessWidget {
  const TextFieldinput(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isPass = false,
      required this.textInputType});
  final TextEditingController controller;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
