import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/custom_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(fontSize:24,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 25), child: AppTextField(text: 'Tel nomeringgizni kiriting')),
              SizedBox(height: 25,),
              CircleAvatar(
                radius: 150,
                backgroundColor: Colors.green,
              ),
              SizedBox(height: 20,),
              CustomButton(text: 'Login',onTap: (){
                context.go('/home');
              },)
            ],
          ),
        ),
      ),
    );
  }
}
