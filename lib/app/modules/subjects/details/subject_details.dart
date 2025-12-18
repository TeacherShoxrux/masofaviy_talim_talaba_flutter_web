import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/global/theme/app_colors.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/details/subject_item.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/details/subject_video_add_alert.dart';

import '../../../services/storage_service.dart';
import '../assignment/assignment_add_alert.dart';
import '../test_add/test_add_page.dart';

class SubjectDetails extends StatefulWidget {
  const SubjectDetails({super.key, this.subjectId});
  final String? subjectId;
  @override
  State<SubjectDetails> createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  var videos = [
    "Video 1: Introduction",
    "Video 2: Setup",
    "Video 3: Hello World",
  ];
  bool isAdmin = false;
  @override
  Widget build(BuildContext context) {
    isAdmin = StorageService.role == 'admin';
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            centerTitle: true,
            title: Text("fan nomi shu yerda bo'ladi"),
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
                      title: Text(videos[index]),
                      onTap: () {
                        final videoId = "12";
                        context.go(
                          '/subjects/${widget.subjectId}/video/$videoId',
                        );
                        print("Open video: ${videos[index]}");
                      },
                    ),
                  );
                },
                itemCount: 3,
              ),
              if (isAdmin)
                Positioned(
                  top: 15,
                  right: 15,
                  child: IconButton(
                    onPressed: () {
                      showAddVideoDialog(context);
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
                      leading: Icon(
                        Icons.checklist_outlined,
                        color: Colors.green,
                      ),
                      title: Text(videos[index]),
                      onTap: () {
                        var testid = 97;
                        context.go(
                          '/subjects/${widget.subjectId}/test/$testid',
                        );
                      },
                    ),
                  );
                },
                itemCount: 3,
              ),
              if (isAdmin)
                Positioned(
                  top: 15,
                  right: 15,
                  child: IconButton(
                    onPressed: () {
                      context.go('/subjects/${widget.subjectId}/test_add/${widget.subjectId}');
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
                      title: Text(videos[index]),
                      onTap: () {
                        print("Open video: ${videos[index]}");
                      },
                    ),
                  );
                },
                itemCount: 3,
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
                      leading: Icon(
                        Icons.assignment_returned_outlined,
                        color: Colors.deepPurpleAccent,
                      ),
                      title: Text(videos[index]),
                      onTap: () {
                        context.go('/subjects/${widget.subjectId}/assignment/${widget.subjectId}');
                        print("Open video: ${videos[index]}");
                      },
                    ),
                  );
                },
                itemCount: 3,
              ),
              if (isAdmin)
                Positioned(
                  top: 15,
                  right: 15,
                  child: IconButton(
                    onPressed: () {
                      showAddAssignmentDialog(context: context, subjectName: 'fan nomi here');
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => const AddTestDialog(),
                      // );

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
