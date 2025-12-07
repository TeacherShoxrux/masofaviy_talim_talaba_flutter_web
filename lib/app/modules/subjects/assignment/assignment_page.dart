import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/assignment/assignment_name.dart';

import 'assignment_details.dart';
import 'assignment_upload.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key, this.id});
  final String? id;

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 2,
                  blurStyle: BlurStyle.inner,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 5,
              centerTitle: true,
              title: Text("Fan nomi  shu yerda bo'ladi"),
            ),
          ),
          AssignmentName(), AssignmentDetails(),
          AssignmentUpload()


        ]),
      ),
    );
  }
}
