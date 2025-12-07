import 'package:flutter/material.dart';

import '../global/theme/app_colors.dart';
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.text, this.onPressed, this.color});
  final String text;
  final Color? color;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:onPressed,style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(color??AppColors.primaryColor)
    ), child: Text(text,style: TextStyle(color: Colors.white),),);
  }
}
