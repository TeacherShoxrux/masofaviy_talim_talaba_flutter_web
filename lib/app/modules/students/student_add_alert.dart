import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

Future<void> showAddStudentDialog(BuildContext context) async {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  DateTime? birthDate;
  Uint8List? faceImageBytes;
  String? faceImageName;

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              "Talaba qo'shish",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: SizedBox(
              width: 500, // Web uchun standart kenglik
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// Ismi Familiyasi
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Ismi Familiyasi",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Tug‘ilgan sana
                    const Text("Tug‘ilgan sana"),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () async {
                        DateTime? selected = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );
                        if (selected != null) {
                          setState(() => birthDate = selected);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          birthDate == null
                              ? "Tug‘ilgan sanani tanlang"
                              : "${birthDate!.day}.${birthDate!.month}.${birthDate!.year}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// FaceID rasmi (FilePicker)
                    const Text("FaceID rasmi"),
                    const SizedBox(height: 6),
                    /// FaceID rasmi (FilePicker) aylana va kvadrat markaz bilan
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          withData: true,
                        );
                        if (result != null && result.files.isNotEmpty) {
                          setState(() {
                            faceImageBytes = result.files.first.bytes;
                            faceImageName = result.files.first.name;
                          });
                        }
                      },
                      child: Container(
                        width: 150, // kvadrat
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // aylana
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: faceImageBytes == null
                            ? const Center(
                          child: Text(
                            "Rasm tanlash",
                            style: TextStyle(color: Colors.blue),
                            textAlign: TextAlign.center,
                          ),
                        )
                            : ClipOval(
                          child: Image.memory(
                            faceImageBytes!,
                            fit: BoxFit.cover, // markazini ko‘rsatadi
                            alignment: Alignment.center,
                            width: 150,
                            height: 150,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),
                    const Text(
                      "Tiniq tushirilgan yuz rasmini yuklang",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),

                    const SizedBox(height: 16),

                    /// Telefon raqami
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Telefon raqami",
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
                  // TODO: Saqlash logikasi shu yerda
                  Navigator.pop(context);
                },
                child: const Text("Saqlash"),
              ),
            ],
          );
        },
      );
    },
  );
}
