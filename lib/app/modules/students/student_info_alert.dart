import 'dart:typed_data';
import 'package:flutter/material.dart';

Future<void> showStudentInfoDialog({
  required BuildContext context,
  required String fullName,
  required String birthDate,
  required String phone,
  Uint8List? faceImageBytes,
  String? additionalInfo,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          "Talaba ma'lumotlari",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              children: [

                /// FaceID rasm
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: faceImageBytes != null
                      ? ClipOval(
                    child: Image.memory(
                      faceImageBytes,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      width: 150,
                      height: 150,
                    ),
                  )
                      : const Icon(Icons.person, size: 80, color: Colors.grey),
                ),

                const SizedBox(height: 16),

                /// Ism Familiya
                Row(
                  children: [
                    const Text("Ism Familiya: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(child: Text(fullName)),
                  ],
                ),
                const SizedBox(height: 8),

                /// Tug‘ilgan sana
                Row(
                  children: [
                    const Text("Tug‘ilgan sana: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(child: Text(birthDate)),
                  ],
                ),
                const SizedBox(height: 8),

                /// Telefon
                Row(
                  children: [
                    const Text("Telefon: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(child: Text(phone)),
                  ],
                ),
                const SizedBox(height: 8),

                /// Qo‘shimcha ma’lumot
                if (additionalInfo != null) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Qo‘shimcha: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(child: Text(additionalInfo)),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Yopish"),
          ),
        ],
      );
    },
  );
}
