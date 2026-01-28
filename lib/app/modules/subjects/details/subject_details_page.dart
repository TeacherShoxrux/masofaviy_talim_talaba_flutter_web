import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/details/subject_item.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/details/subject_video_add_alert.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/components/subject_controller.dart';
import 'package:provider/provider.dart';

import '../../../global/app_colors.dart';
import '../../../services/storage_service.dart';
import '../assignment/assignment_add_alert.dart';
import '../test/test_create_dialog.dart';
import '../test_add/test_add_page.dart';

class SubjectDetailsPage extends StatefulWidget {
  const SubjectDetailsPage({super.key, required this.subjectId});
  final String subjectId;
  @override
  State<SubjectDetailsPage> createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetailsPage> {
  bool isAdmin = true;
  void _showCreateTestDialog() {
    showDialog(
      context: context,
      builder: (context) => TestCreateDialog(
        subjectId: int.parse(widget.subjectId), // Hozirgi fan ID-si
        onSave: (testData) {

          context.read<SubjectController>().createTest( testData);
        },
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){
      context.read<SubjectController>().getSubjectDetailsById(widget.subjectId);
    });
  }
  @override
  void dispose() {
    context.read<SubjectController>().details=null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // isAdmin = StorageService.role == 'Teacher';
    var controller= context.read<SubjectController>();
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            centerTitle: true,
            title: Text(controller.details?.subject.name??""),
          ),
          Stack(
            children: [
              SubjectItemList(
                title: "Video darsliklar",
                builder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.play_circle_fill, color: Colors.red),
                      title: Text(controller.details?.videos[index].name??""),
                      onTap: () {
                        context.go(
                          '/subjects/${widget.subjectId}/video/${controller.details?.videos[index].id}',
                        );
                      },
                    ),
                  );
                },
                itemCount: controller.details?.videos.length?? 0,
              ),
              if (isAdmin)
                Positioned(
                  top: 15,
                  right: 15,
                  child: IconButton(
                    onPressed: () {
                      showAddVideoDialog(context,widget.subjectId).then((e){
                        context.read<SubjectController>().getSubjectDetailsById(widget.subjectId);
                      });
                    },
                    icon: Icon(
                      CupertinoIcons.add_circled,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                  ),
                ),
            ],
          ),
          Stack(
            children: [
              SubjectItemList(
                title: "Testlar",
                builder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      trailing:IconButton(onPressed: (){


                        context.go('/subjects/${widget.subjectId}/test_add/${controller.details?.tests[index].id}');
                      }, icon: Icon(Icons.edit, color: Colors.amberAccent,)),
                      leading: Icon(
                        Icons.checklist_outlined,
                        color: Colors.green,
                      ),
                      title: Text(controller.details?.tests[index].name??"",maxLines: 1,),
                      onTap: () {
                        var testid =controller.details?.tests[index].id;
                        context.go(
                          '/subjects/${widget.subjectId}/test/$testid',
                        );
                      },
                    ),
                  );
                },
                itemCount: controller.details?.tests.length??0,
              ),
              if (isAdmin)
                Positioned(
                  top: 15,
                  right: 15,
                  child: IconButton(
                    onPressed: () {
                      _showCreateTestDialog();

                    },
                    icon: Icon(
                      CupertinoIcons.add_circled,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                  ),
                ),
            ],
          ),

          Stack(
            children: [
              SubjectItemList(
                title: "Krossworlar",
                builder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.crop_square_sharp,
                        color: Colors.amber,
                      ),
                      title: Text(controller.details?.crossWords[index].name??"",maxLines: 1,),
                      onTap: () {
                        // print("Open Crossword: ${videos[index]}");
                      },
                    ),
                  );
                },
                itemCount: controller.details?.crossWords.length??0,
              ),
              if (isAdmin)
                Positioned(
                  top: 15,
                  right: 15,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.add_circled,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                  ),
                ),
            ],
          ),
          Stack(
            children: [
              SubjectItemList(
                title: "Mustaqil ish topshiriqlari",
                builder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      trailing: IconButton(
                          onPressed: () => context.go('/subjects/${widget.subjectId}/assignment_submission/${widget.subjectId}'),
                          icon: Icon(Icons.assessment_rounded)),
                      leading: Icon(
                        Icons.assignment_returned_outlined,
                        color: Colors.deepPurpleAccent,
                      ),
                      title: Text(controller.details?.independentWorks[index].name??"",maxLines: 1),
                      onTap: () {
                        context.go('/subjects/${widget.subjectId}/assignment/${widget.subjectId}');
                        if (kDebugMode) {
                          // print("Open video: ${videos[index]}");
                        }
                      },
                    ),
                  );
                },
                itemCount:controller.details?.independentWorks.length??0,
              ),
              if (isAdmin)
                Positioned(
                  top: 15,
                  right: 15,
                  child: IconButton(
                    onPressed: () {
                      showAddAssignmentDialog(context: context, subjectName: 'fan nomi here');

                    },
                    icon: Icon(
                      CupertinoIcons.add_circled,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
