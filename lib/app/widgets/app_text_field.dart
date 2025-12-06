import 'package:flutter/material.dart';
class AppTextField extends StatelessWidget {
  const AppTextField({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextField(
    decoration: InputDecoration(
      labelText: text,
      border: OutlineInputBorder(

        borderRadius: BorderRadius.circular(20))
    ),
    );
  }
}
