import 'package:flutter/material.dart';
class SubjectDetails extends StatefulWidget {
  const SubjectDetails({super.key, this.subjectId});
final String? subjectId;
  @override
  State<SubjectDetails> createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("SubjectDetails nested by argument=> ${widget.subjectId}"),
    );
  }
}
