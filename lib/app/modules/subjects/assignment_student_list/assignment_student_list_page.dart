import 'package:flutter/material.dart';

class AssignmentSubmissionsPage extends StatelessWidget {
  const AssignmentSubmissionsPage({super.key, required this.id});
  final String? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Topshiriq topshirgan talabalar"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          _assignmentInfo(),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return _studentCard(context,
                    name: "Talaba ${index + 1}",
                    id: "ID${1000 + index}",
                    date: "2025-01-10");
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Topshiriq haqida ma'lumot
  Widget _assignmentInfo() {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Fan: Dasturlash asoslari",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Topshiriq: Flutter UI yaratish"),
            SizedBox(height: 4),
            Text("Muddat: 15-yanvar 2025"),
          ],
        ),
      ),
    );
  }

  /// 🔹 Talaba kartasi
  Widget _studentCard(BuildContext context,
      {required String name,
        required String id,
        required String date}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.blue),
        title: Text(name),
        subtitle: Text("ID: $id\nTopshirilgan: $date"),
        isThreeLine: true,
        trailing: ElevatedButton(
          onPressed: () {
            _openEvaluationSheet(context, name);
          },
          child: const Text("Baholash"),
        ),
      ),
    );
  }
  void _openEvaluationSheet(BuildContext context, String studentName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Baholash: $studentName",
                    style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Izoh (feedback)",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Baho (0–100)",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Saqlash"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
