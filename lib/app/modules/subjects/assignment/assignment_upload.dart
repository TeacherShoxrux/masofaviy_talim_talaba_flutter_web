import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/custom_elevated_button.dart';

class AssignmentUpload extends StatefulWidget {
  const AssignmentUpload({super.key});

  @override
  State<AssignmentUpload> createState() => _AssignmentUploadState();
}

class _AssignmentUploadState extends State<AssignmentUpload> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        Text(
          "Submit Your Response",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Text("Upload your response to the assignment here"),
        SizedBox(height: 20,),
        Row(
          children: [
            Icon(Icons.file_open_outlined),
            SizedBox(width: 10,),
            Text("Upload Assignment.pdf"),
          ],
        ),
        SizedBox(height: 10,),
        IconButton.filled(onPressed: (){}, icon: Icon(Icons.file_upload_outlined)),
        SizedBox(height: 10,),
        TextField(
          style: TextStyle(color: Colors.black),
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Write your response here",
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(),

          ),
        ),
        SizedBox(height: 10,),
        CustomElevatedButton(text: "Submit",onPressed: ()=>context.go("/subjects/12"),)
      ]),
    );
  }
}
