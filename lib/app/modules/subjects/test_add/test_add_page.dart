import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/modules/notification/notification_controller.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test/component/test_controller.dart';
import 'package:provider/provider.dart';
import 'components/question_add_alert.dart';


class TestAddPage extends StatefulWidget {
  const TestAddPage({super.key, this.id});
  final String? id;
  @override
  State<TestAddPage> createState() => _AddTestDialogState();
}

class _AddTestDialogState extends State<TestAddPage> {
  TextEditingController testNameController = TextEditingController();
  List<Map<String, dynamic>> questions = [
    {
      "question": "O‘zbekiston poytaxti qaysi shahar?",
      "variants": ["Toshkent", "Samarqand", "Buxoro", "Namangan"],
      "correct": 0,
    },
    {
      "question": "Dunyodagi eng katta okean qaysi?",
      "variants": ["Atlantika", "Tinch", "Hind", "Shimoliy Muz okeani"],
      "correct": 1,
    },
    {
      "question": "2 + 2 tengmi?",
      "variants": ["3", "4", "5", "22"],
      "correct": 1,
    },
    {
      "question": "O'zbekiston milliy valyutasi nima?",
      "variants": ["Sum", "Dollar", "Rubl", "Euro"],
      "correct": 0,
    },
    {
      "question": "Dunyo bo‘yicha eng ko‘p aholiga ega d",
      "variants": ["Hindiston", "Xitoy", "AQSh", "Indoneziya"],
      "correct": 1,
    },
  ];

  void showAddQuestionDialog()async {
    showDialog(
      context: context,
      builder: (context) {
        return AddQuestionDialog(
          testId: int.tryParse(widget.id ?? "0") ?? 0,
          onSave: (newQuestion) {
            var controller = context.read<TestController>();
            controller.addQuestion(newQuestion);
          },
        );
      },
    ).then((e){
      setState(() {
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    var controller = context.read<TestController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test savollari"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Test nomi qismi
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: testNameController,
                  decoration: const InputDecoration(
                    labelText: "Test nomi",
                    prefixIcon: Icon(Icons.edit),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Savol qo‘shish tugmasi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Savollar ro'yxati",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: showAddQuestionDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text("Qo‘shish"),
                ),
              ],
            ),
            const Divider(),

            /// Qo‘shilgan savollar ro‘yxati (Render xatoligi tuzatilgan qism)
            Expanded(
              child: FutureBuilder<bool?>(
                // widget.id yoki kerakli ID ni yuboring
                future: controller.getQuestionsByTestId(int.parse(widget.id ?? "0")),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final questionsList = controller.testWithQuestions?.questions ?? [];

                  if (questionsList.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.quiz_outlined, size: 64, color: Colors.grey),
                          Text("Hech qanday savol qo‘shilmagan", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 8),
                    itemCount: questionsList.length,
                    itemBuilder: (context, index) {
                      final q = questionsList[index];

                      // To'g'ri javobni topish mantiqi
                      final correctAnswer = q.answers?.firstWhere(
                            (a) => a.isCorrect == true,
                      );

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 3,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            child: Text("${index + 1}"),
                          ),
                          title: Text(
                            q.description ?? "Matn yo'q",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle, size: 16, color: Colors.green),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "Javob: ${correctAnswer?.text}",
                                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () {
                              // Savolni o'chirish logikasi
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            /// Testni saqlash tugmasi
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: (controller.testWithQuestions?.questions?.isEmpty ?? true)
                    ? null
                    : () {
                  // Saqlash logikasi
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Barcha o'zgarishlar saqlandi!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("TESTNI YAKUNLASH VA SAQLASH", style: TextStyle(letterSpacing: 1.2)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
