import 'package:flutter/material.dart';

class TestCreateDialog extends StatefulWidget {
  final int subjectId;
  final Function(Map<String, dynamic> data) onSave;

  const TestCreateDialog({
    super.key,
    required this.subjectId,
    required this.onSave
  });

  @override
  State<TestCreateDialog> createState() => _TestCreateDialogState();
}

class _TestCreateDialogState extends State<TestCreateDialog> {
  final _formKey = GlobalKey<FormState>();

  // Controllerlar ma'lumotlarni boshqarish uchun
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _iconController = TextEditingController();
  final _timeController = TextEditingController();
  final _scoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Row(
        children: [
          Icon(Icons.quiz_outlined, color: Colors.blue),
          SizedBox(width: 10),
          Text("Yangi test yaratish"),
        ],
      ),
      content: SizedBox(
        width: 400, // Desktop uchun kenglik
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildField(_nameController, "Test nomi", Icons.title),
                _buildField(_iconController, "Ikonka URL (string)", Icons.image),
                _buildField(_descController, "Tavsif", Icons.description, maxLines: 3),
                Row(
                  children: [
                    Expanded(
                      child: _buildField(
                          _timeController,
                          "Vaqt (daqiqa)",
                          Icons.timer,
                          isNumber: true
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildField(
                          _scoreController,
                          "Maks. ball",
                          Icons.grade,
                          isNumber: true
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Bekor qilish", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: _submit,
          child: const Text("Saqlash"),
        ),
      ],
    );
  }

  // Input maydonlarini yaratish uchun helper
  Widget _buildField(
      TextEditingController controller,
      String label,
      IconData icon,
      {bool isNumber = false, int maxLines = 1}
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        validator: (value) => value == null || value.isEmpty ? "Maydonni to'ldiring" : null,
      ),
    );
  }

  // Ma'lumotlarni yig'ish va yuborish
  void _submit() {
    if (_formKey.currentState!.validate()) {
      final data = {
        "subjectId": widget.subjectId,
        "icon": _iconController.text,
        "name": _nameController.text,
        "description": _descController.text,
        "time": int.tryParse(_timeController.text) ?? 0,
        "maxScore": int.tryParse(_scoreController.text) ?? 0,
      };

      widget.onSave(data);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _iconController.dispose();
    _timeController.dispose();
    _scoreController.dispose();
    super.dispose();
  }
}