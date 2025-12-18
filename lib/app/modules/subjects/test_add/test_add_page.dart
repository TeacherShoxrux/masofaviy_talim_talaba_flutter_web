import 'package:flutter/material.dart';

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
      "question": "Dunyo bo‘yicha eng ko‘p aholiga ega davlat?",
      "variants": ["Hindiston", "Xitoy", "AQSh", "Indoneziya"],
      "correct": 1,
    }
  ];


  void showAddQuestionDialog() {
    TextEditingController questionController = TextEditingController();
    List<String> variants = [];
    int? correctIndex;

    TextEditingController variantController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text(
              "Savol qo‘shish",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SizedBox(
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Savol matni
                    TextField(
                      controller: questionController,
                      decoration: const InputDecoration(
                        labelText: "Savol matni",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),

                    /// Variant qo‘shish
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: variantController,
                            decoration: const InputDecoration(
                              labelText: "Variant qo‘shish",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (variantController.text.isNotEmpty) {
                              setState(() {
                                variants.add(variantController.text);
                                variantController.clear();
                              });
                            }
                          },
                          child: const Text("Qo‘shish"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (variants.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Variantlar (to‘g‘ri javobni belgilang):",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          ...variants.asMap().entries.map((entry) {
                            int idx = entry.key;
                            String val = entry.value;
                            return ListTile(
                              title: Text(val),
                              leading: Radio<int>(
                                value: idx,
                                groupValue: correctIndex,
                                onChanged: (val) {
                                  setState(() {
                                    correctIndex = val;
                                  });
                                },
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    if (correctIndex == idx) correctIndex = null;
                                    variants.removeAt(idx);
                                  });
                                },
                              ),
                            );
                          }),
                        ],
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
                  if (questionController.text.isEmpty ||
                      variants.isEmpty ||
                      correctIndex == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Savol matni, variantlar va to‘g‘ri javobni belgilang"),
                      ),
                    );
                    return;
                  }

                  // Serverga yuborish logikasi shu yerga
                  Map<String, dynamic> questionData = {
                    "question": questionController.text,
                    "variants": variants,
                    "correct": correctIndex,
                  };

                  // TEMP: serverga yuborish o‘rniga local listga qo‘shdik
                  questions.add(questionData);

                  Navigator.pop(context); // alertni yopish
                  setState(() {}); // page ni yangilash
                },
                child: const Text("Savolni qo‘shish"),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test qo'shish"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Test nomi
            TextField(
              controller: testNameController,
              decoration: const InputDecoration(
                labelText: "Test nomi",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            /// Savol qo‘shish tugmasi
            ElevatedButton.icon(
              onPressed: showAddQuestionDialog,
              icon: const Icon(Icons.add),
              label: const Text("Savol qo‘shish"),
            ),
            const SizedBox(height: 16),

            /// Qo‘shilgan savollar ro‘yxati
            Expanded(
              child: questions.isEmpty
                  ? const Center(child: Text("Hech qanday savol qo‘shilmagan"))
                  : ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final q = questions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(q["question"]),
                      subtitle: Text(
                          "To‘g‘ri javob: ${q["variants"][q["correct"]]}"),
                    ),
                  );
                },
              ),
            ),

            /// Testni saqlash
            ElevatedButton(
              onPressed: questions.isEmpty || testNameController.text.isEmpty
                  ? null
                  : () {

                print("Test nomi: ${testNameController.text}");
                print("Savollar: $questions");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Test saqlandi!")),
                );
                setState(() {
                  testNameController.clear();
                  questions.clear();
                });
              },
              child: const Text("Testni saqlash"),
            ),
          ],
        ),
      ),
    );
  }
}