import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/global/theme/app_colors.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/details/subject_item.dart';

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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
              backgroundColor: Colors.white,
              elevation: 5,
              centerTitle: true, title: Text("fan nomi shu yerda bo'ladi")),
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
                    final video_Id = "12";
                    context.go('/subjects/${widget.subjectId}/video/$video_Id');
                    print("Open video: ${videos[index]}");
                  },
                ),
              );
            },
            itemCount: 3,
          ),
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
                  leading: Icon(Icons.checklist_outlined, color: Colors.green),
                  title: Text(videos[index]),
                  onTap: () {
                    var testid = 97;
                    context.go('/subjects/${widget.subjectId}/test/$testid');
                  },
                ),
              );
            },
            itemCount: 3,
          ),
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
                  leading: Icon(Icons.crop_square_sharp, color: Colors.amber),
                  title: Text(videos[index]),
                  onTap: () {
                    print("Open video: ${videos[index]}");
                  },
                ),
              );
            },
            itemCount: 3,
          ),
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
        ],
      ),
    );
  }
}
