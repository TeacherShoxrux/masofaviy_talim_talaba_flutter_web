import 'package:flutter/material.dart';

Future<void> showStudentAddSubjectDialog(BuildContext context) async {
  TextEditingController searchController = TextEditingController();

  // Misol uchun kurslar ro'yhati
  List<Map<String, String>> courses = [
    {"name": "Matematika"},
    {"name": "Fizika"},
    {"name": "Kimyo"},
    {"name": "Biologiya"},
    {"name": "Informatika"},
    {"name": "Tarix"},
    {"name": "Geografiya"},
    {"name": "Adabiyot"},
  ];

  List<Map<String, String>> filteredCourses = List.from(courses);
  List<Map<String, String>> selectedCourses = [];

  void searchCourse(String query) {
    filteredCourses = courses
        .where((c) =>
        c["name"]!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  await showDialog(
    context: context,
    builder: (context) {
      var studentName="Adham Sloyev";
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text(
            "Talabani fanga biriktirish",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// Talaba ismi
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Talaba: $studentName",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12),

                /// Search field
                TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchCourse(value);
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Kurs nomi bo‘yicha izlash",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                /// Courses list
                SizedBox(
                  height: 200,
                  child: filteredCourses.isEmpty
                      ? const Center(child: Text("Hech qanday kurs topilmadi"))
                      : ListView.builder(
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = filteredCourses[index];
                      bool isSelected = selectedCourses.contains(course);
                      return ListTile(
                        title: Text(course["name"]!),
                        trailing: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (!isSelected) {
                                selectedCourses.add(course);
                              }
                            });
                          },
                          child: Text(isSelected ? "Tanlangan" : "Tanlash"),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                /// Tanlangan kurslar
                if (selectedCourses.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Tanlangan kurslar:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    children: selectedCourses
                        .map((c) => Chip(
                      label: Text(c["name"]!),
                      onDeleted: () {
                        setState(() {
                          selectedCourses.remove(c);
                        });
                      },
                    ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Bekor qilish"),
            ),
            ElevatedButton(
              onPressed: selectedCourses.isEmpty
                  ? null
                  : () {
                // TODO: Backendga biriktirish logikasi
                print(
                    "$studentName talaba quyidagi kurslarga biriktirildi: ${selectedCourses.map((c) => c["name"]).join(", ")}");
                Navigator.pop(context);
              },
              child: const Text("Biriktirish"),
            ),
          ],
        );
      });
    },
  );
}