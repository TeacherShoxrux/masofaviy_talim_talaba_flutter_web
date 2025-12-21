import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/modules/login/cam.dart';
import '../../services/storage_service.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/custom_button.dart';

enum UserType { student, admin }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserType selectedUser = UserType.student;

  TextEditingController phoneController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return Cam();
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text("Talaba"),
                    selected: selectedUser == UserType.student,
                    onSelected: (val) {
                      setState(() {
                        selectedUser = UserType.student;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text("Admin"),
                    selected: selectedUser == UserType.admin,
                    onSelected: (val) {
                      setState(() {
                        selectedUser = UserType.admin;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),
              if (selectedUser == UserType.student) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: AppTextField(
                      text: 'Tel nomeringizni kiriting',
                      controller: phoneController),
                ),
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,
                  child: Cam(),
                ),
              ],

              /// Admin login
              if (selectedUser == UserType.admin) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: AppTextField(
                      text: 'Login', controller: loginController),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: AppTextField(
                      text: 'Parol', controller: passwordController),
                ),
              ],

              const SizedBox(height: 25),

              CustomButton(
                text: 'Login',
                onTap: () {
                  if (selectedUser == UserType.student) {

                    print("Talaba login: ${phoneController.text}");
                    StorageService.saveRole('student');

                    context.go('/home');
                  } else {
                    // TODO: Admin login logikasi (login + password)
                    print(
                        "Admin login: ${loginController.text}, Parol: ${passwordController.text}");
                    StorageService.saveRole('admin');
                    context.go('/home');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
