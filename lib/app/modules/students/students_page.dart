import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/modules/students/student_add_alert.dart';
import 'package:masofaviy_talim_talaba/app/modules/students/student_info_alert.dart';
import 'package:masofaviy_talim_talaba/app/modules/students/stundent_append_subject_alert.dart';

import '../../global/theme/app_colors.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> students = [
    {
      "img": "https://i.pravatar.cc/150?img=1",
      "name": "Abdulloh Karimov",
      "info": "3-kurs, Kompyuter injiniring",
    },
    {
      "img": "https://i.pravatar.cc/150?img=2",
      "name": "Dilnoza Akromova",
      "info": "2-kurs, Dasturiy injiniring",
    },
    {
      "img": "https://i.pravatar.cc/150?img=3",
      "name": "Jamshid Raxmonov",
      "info": "1-kurs, Axborot tizimlari",
    },
    {
      "img": "https://i.pravatar.cc/150?img=4",
      "name": "Madina Murodova",
      "info": "4-kurs, Telekommunikatsiya",
    },
    {
      "img": "https://i.pravatar.cc/150?img=1",
      "name": "Abdulloh Karimov",
      "info": "3-kurs, Kompyuter injiniring",
    },
    {
      "img": "https://i.pravatar.cc/150?img=2",
      "name": "Dilnoza Akromova",
      "info": "2-kurs, Dasturiy injiniring",
    },
    {
      "img": "https://i.pravatar.cc/150?img=3",
      "name": "Jamshid Raxmonov",
      "info": "1-kurs, Axborot tizimlari",
    },
    {
      "img": "https://i.pravatar.cc/150?img=4",
      "name": "Madina Murodova",
      "info": "4-kurs, Telekommunikatsiya",
    },
    {
      "img": "https://i.pravatar.cc/150?img=1",
      "name": "Abdulloh Karimov",
      "info": "3-kurs, Kompyuter injiniring",
    },
    {
      "img": "https://i.pravatar.cc/150?img=2",
      "name": "Dilnoza Akromova",
      "info": "2-kurs, Dasturiy injiniring",
    },
    {
      "img": "https://i.pravatar.cc/150?img=3",
      "name": "Jamshid Raxmonov",
      "info": "1-kurs, Axborot tizimlari",
    },
    {
      "img": "https://i.pravatar.cc/150?img=4",
      "name": "Madina Murodova",
      "info": "4-kurs, Telekommunikatsiya",
    },
  ];

  List<Map<String, dynamic>> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    filteredStudents = students;
  }

  void searchStudent(String query) {
    setState(() {
      filteredStudents = students
          .where(
            (s) =>
                s["name"].toLowerCase().contains(query.toLowerCase()) ||
                s["info"].toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Talabalar ro'yhati"),
        actions: [
          IconButton(
            onPressed: () {
              showAddStudentDialog(context);
            },
            icon: Icon(
              CupertinoIcons.add_circled,
              color: AppColors.primaryColor,
              size: 34,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: searchStudent,
              decoration: InputDecoration(
                hintText: "Talaba qidirish...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  final s = filteredStudents[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),

                      /// LEFT SIDE — IMAGE
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(s["img"]),
                      ),

                      /// MIDDLE — NAME + INFO
                      title: Text(
                        s["name"],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(s["info"]),

                      trailing: SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              tooltip: "Ma'lumot",
                              icon: const Icon(Icons.info_outline),
                              onPressed: () {
                                showStudentInfoDialog(
                                  context: context,
                                  fullName: "Ali Valiyev",
                                  birthDate: "15.05.2004",
                                  phone: "+998901234567",
                                  additionalInfo:
                                      "Talaba Informatika kursida o'qiydi",
                                );
                              },
                            ),
                            IconButton(
                              tooltip: "Kursga qo'shish",
                              onPressed: () {
                                showStudentAddSubjectDialog(context);
                              },
                              icon: Icon(CupertinoIcons.person_add),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
