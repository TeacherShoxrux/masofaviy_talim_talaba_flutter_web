import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.subjectsCount,
    required this.videosCount,
    required this.tasksCount,
    required this.studentsCount,
  });
  final int subjectsCount;
  final int videosCount;
  final int tasksCount;
  final int studentsCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Wrap(

            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.start,
            children: [
              _buildCard("Fanlar", subjectsCount, Icons.book),
              _buildCard("Videolar", videosCount, Icons.video_collection),
              _buildCard("Topshiriqlar", tasksCount, Icons.assignment),
              _buildCard("Talabalar", studentsCount, Icons.people),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, int count, IconData icon) {
    return Container(
      width: 280,          // katta bo‘lib ketmasligi uchun limit
      height: 150,         // proporsiya chiroyli bo‘lishi uchun
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 38, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}