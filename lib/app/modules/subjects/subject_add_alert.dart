import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

Future<void> showAddSubjectDialog(BuildContext context) async {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Yangi fan qo'shish",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// Fan nomi
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Fan nomi",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              /// Fan tavsifi / qo‘shimcha ma’lumot
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Tavsif (optional)",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Bekor qilish"),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: fanni saqlash logikasi
              print("Fan nomi: ${nameController.text}");
              print("Tavsif: ${descriptionController.text}");
              Navigator.pop(context);
            },
            child: const Text("Saqlash"),
          ),
        ],
      );
    },
  );
}
