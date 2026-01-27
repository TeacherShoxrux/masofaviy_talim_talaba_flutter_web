import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/Services/storage_service.dart';
import 'package:masofaviy_talim_talaba/app/app_routes.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/components/subject_add_alert.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/components/subject_controller.dart';
import 'package:masofaviy_talim_talaba/app/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

import '../../global/app_colors.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  var item = [
    "Kimyo",
    "Oliy matematika",
    "Geografiya",
    "Boshqarish nazariyasini amaliy asoslari",
  ];
  bool isAdmin = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){
      context.read<SubjectController>().getSubjectList();
    });
  }

  @override
  Widget build(BuildContext context) {
    isAdmin = StorageService.role == 'Teacher';
    var controller = context.read<SubjectController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: Text("Fanlar"),
        ),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        actions: [
          if (isAdmin)
            IconButton(
              onPressed: () {
                showAddSubjectDialog(context);
              },
              icon: Icon(
                CupertinoIcons.add_circled,
                color: AppColors.primaryColor,
                size: 34,
              ),
            ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30, right: 40),
        color: Colors.grey.shade300,
        child: ListView.builder(
          itemCount: controller.subjects.length,
          itemBuilder: (_, i) => Card(
            child: ListTile(
              onTap: () => context.go(AppRoutes.subjectDetailById(controller.subjects[i].id.toString())),
              selectedColor: Colors.blueAccent,
              leading: Icon(
                Icons.science_outlined,
                size: 34,
                color: AppColors.primaryColor,
              ),
              trailing: CustomElevatedButton(
                  onPressed: () => context.go(AppRoutes.subjectDetailById(controller.subjects[i].id.toString())),
                  text: "Kirish"),
              title: Text( controller.subjects[i].name,),
              titleTextStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              subtitle: Text(
                controller.subjects[i].description,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
