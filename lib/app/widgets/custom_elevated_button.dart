import 'package:flutter/material.dart';

import '../global/theme/app_colors.dart';
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){},style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor)
    ), child: Text(text,style: TextStyle(color: Colors.white),),);
  }
}
