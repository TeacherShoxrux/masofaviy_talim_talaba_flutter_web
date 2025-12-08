import 'package:flutter/material.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({super.key});
  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  final List<Map<String, dynamic>> subjects = [
    {
      "name": "Matematika",
      "tests": [
        {"name": "Test 1", "score": 85},
        {"name": "Test 2", "score": 90},
        {"name": "Test 3", "score": 78},
      ],
      "tasks": [
        {"name": "Uyga vazifa 1", "score": 88},
        {"name": "Uyga vazifa 2", "score": 92},
      ],
    },
    {
      "name": "Fizika",
      "tests": [
        {"name": "Test 1", "score": 80},
        {"name": "Test 2", "score": 75},
      ],
      "tasks": [
        {"name": "Lab topshiriq 1", "score": 70},
        {"name": "Lab topshiriq 2", "score": 74},
        {"name": "Lab topshiriq 3", "score": 78},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fanlar ro'yhati")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];

          double avgTests = _average(subject["tests"]);
          double avgTasks = _average(subject["tasks"]);
          double total = (avgTests + avgTasks) / 2;

          return GestureDetector(
            onTap: () {
              _showSubjectDetail(context, subject);
            },
            child: _buildCard(subject["name"], avgTests, avgTasks, total),
          );
        },
      ),
    );
  }

  double _average(List list) {
    if (list.isEmpty) return 0;
    return list.map((e) => e["score"]).reduce((a, b) => a + b) / list.length;
  }

  Widget _buildCard(String name, double tests, double tasks, double total) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text("Testlar o‘rtacha: ${tests.toStringAsFixed(1)}"),
                Text("Topshiriqlar o‘rtacha: ${tasks.toStringAsFixed(1)}"),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              total.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 22,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSubjectDetail(BuildContext context, Map<String, dynamic> subject) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(subject["name"]),
          content: SizedBox(
            width: 500,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Testlar",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  ...subject["tests"].map<Widget>((t) {
                    return _buildDetailItem(t["name"], t["score"]);
                  }),

                  const SizedBox(height: 25),
                  const Text(
                    "Topshiriqlar",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  ...subject["tasks"].map<Widget>((t) {
                    return _buildDetailItem(t["name"], t["score"]);
                  }),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Yopish"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailItem(String title, int score) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          Text(
            score.toString(),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
