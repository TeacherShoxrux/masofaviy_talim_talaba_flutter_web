import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test_add/components/question_create_model.dart';

class AddQuestionDialog extends StatefulWidget {
  final int testId;
  final Function(QuestionCreateModel) onSave;

  const AddQuestionDialog({
    super.key,
    required this.testId,
    required this.onSave,
  });

  @override
  State<AddQuestionDialog> createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _variantController = TextEditingController();

  late QuestionCreateModel _question;
  final List<Answer> _variants = [];

  @override
  void initState() {
    super.initState();
    _question = QuestionCreateModel(
      testId: widget.testId,
      text: '',
      description: '',
      filePath: '',
      answers: _variants,
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _variantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Savol qo‘shish",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _questionController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Savol matni",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _variantController,
                      decoration: const InputDecoration(
                        labelText: "Variant qo‘shish",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_variantController.text.isNotEmpty) {
                        setState(() {
                          // Birinchi qo'shilgan variant avtomatik to'g'ri bo'ladi
                          bool isFirst = _variants.isEmpty;
                          _variants.add(Answer(
                            isCorrect: isFirst,
                            text: _variantController.text,
                          ));
                          _variantController.clear();
                        });
                      }
                    },
                    child: const Text("Qo‘shish"),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_variants.isNotEmpty)
                Column(
                  children: _variants.asMap().entries.map((entry) {
                    int index = entry.key;
                    Answer item = entry.value;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: item.isCorrect
                            ? Colors.green.withOpacity(0.1)
                            : Colors.transparent,
                        border: Border.all(
                          color: item.isCorrect ? Colors.green : Colors.grey.shade300,
                          width: item.isCorrect ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: RadioListTile<int>(
                        title: Text(item.text),
                        value: index,
                        groupValue: _variants.indexWhere((e) => e.isCorrect),
                        activeColor: Colors.green,
                        onChanged: (int? selectedIndex) {
                          setState(() {
                            for (int i = 0; i < _variants.length; i++) {
                              _variants[i] = Answer(
                                text: _variants[i].text,
                                isCorrect: i == selectedIndex,
                              );
                            }
                          });
                        },
                        secondary: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _variants.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
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
            if (_questionController.text.isEmpty || _variants.isEmpty) {
              // Xatolik xabarini chiqarish (Dialog ichida snackbar ishlamasligi mumkin,
              // shuning uchun onSave ichida tekshirish yaxshi)
              return;
            }

            // Modelni to'ldiramiz
            _question.text = "Savol"; // yoki kerakli nom
            _question.description = _questionController.text;
            _question.filePath = ""; // fayl bo'lsa shu yerga


            widget.onSave(_question);
            Navigator.pop(context);
          },
          child: const Text("Savolni qo‘shish"),
        ),
      ],
    );
  }
}