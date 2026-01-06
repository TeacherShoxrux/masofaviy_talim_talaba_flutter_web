import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/modules/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   int? subjectsCount;

   int? videosCount;

   int? tasksCount;

   int? studentsCount;
   @override
   void initState() {
     super.initState();

     WidgetsBinding.instance.addPostFrameCallback((_) {
       context.read<HomeController>().getDetail();
     });
   }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: Consumer<HomeController>(
          builder: (context, controller, _) {
            return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.start,
                    children: [
                      _buildCard("Fanlar",context.read<HomeController>().statisticsModel?.subjectsCount??0, Icons.book),
                      _buildCard("Videolar",context.read<HomeController>().statisticsModel?.videosCount ?? 0, Icons.video_collection),
                      _buildCard("Topshiriqlar", context.read<HomeController>().statisticsModel?.independentWorkCount ?? 0, Icons.assignment),
                      _buildCard("Testlar", context.read<HomeController>().statisticsModel?.testsCount ?? 0, Icons.assessment_outlined),
                    ],
                  ),
                ),

          );
        }
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