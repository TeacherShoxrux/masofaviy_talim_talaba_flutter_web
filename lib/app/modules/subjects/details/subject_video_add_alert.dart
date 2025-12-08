import 'package:flutter/material.dart';

Future<void> showAddVideoDialog(BuildContext context) async {
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Video qo'shish",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// Video nomi
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Video nomi",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                /// Video URL
                TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    labelText: "Video URL",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                /// Video izohi
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "Video izohi",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Bekor qilish"),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: video saqlash logikasi
              print("Video nomi: ${nameController.text}");
              print("Video URL: ${urlController.text}");
              print("Izohi: ${descriptionController.text}");
              Navigator.pop(context);
            },
            child: const Text("Saqlash"),
          ),
        ],
      );
    },
  );
}
