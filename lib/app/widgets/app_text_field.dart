import 'package:flutter/material.dart';
class AppTextField extends StatelessWidget {
  const AppTextField({super.key, required this.text, this.controller});
  final String text;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
    decoration: InputDecoration(
      labelText: text,
      border: OutlineInputBorder(

        borderRadius: BorderRadius.circular(20))
    ),
    );
  }
}
