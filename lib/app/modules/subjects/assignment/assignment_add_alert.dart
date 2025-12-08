import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

Future<void> showAddAssignmentDialog({
  required BuildContext context,
  required String subjectName,
}) async {
  TextEditingController assignmentNameController = TextEditingController();
  TextEditingController assignmentDescriptionController =
  TextEditingController();
  List<PlatformFile> selectedFiles = [];

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Topshiriq qo'shish",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SizedBox(
            width: 450,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Fan nomi
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Fan: $subjectName",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: assignmentNameController,
                    decoration: const InputDecoration(
                      labelText: "Topshiriq nomi",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: assignmentDescriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Topshiriq izohi",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (selectedFiles.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: selectedFiles
                          .map((f) => Row(
                            children: [
                              Icon(Icons.file_copy),
                              Flexible(
                                child: Text(
                                "${f.name} (${(f.size / 1024).toStringAsFixed(2)} KB)",overflow: TextOverflow.ellipsis,),
                              ),
                            ],
                          ))
                          .toList(),
                    ),
                  const SizedBox(height: 12),

                  /// Fayl uploader
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                          allowMultiple: true,
                        );
                        if (result != null) {
                          setState(() {
                            selectedFiles.add(result.files.first);
                            // selectedFiles = result.files.first;
                          });
                        }
                      },
                      icon: const Icon(Icons.upload_file),
                      label: const Text("Fayl(lar) tanlash"),
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Tanlangan fayllar

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
                if (assignmentNameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Topshiriq nomini kiriting")),
                  );
                  return;
                }
                print("Fan: $subjectName");
                print("Topshiriq nomi: ${assignmentNameController.text}");
                print(
                    "Izoh: ${assignmentDescriptionController.text}");
                print("Fayllar: ${selectedFiles.map((f) => f.name).join(", ")}");

                Navigator.pop(context);
              },
              child: const Text("Saqlash"),
            ),
          ],
        );
      });
    },
  );
}
