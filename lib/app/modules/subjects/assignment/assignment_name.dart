import 'package:flutter/material.dart';

class AssignmentName extends StatefulWidget {
  const AssignmentName({super.key, this.id});
  final String? id;
  @override
  State<AssignmentName> createState() => _AssignmentNameState();
}

class _AssignmentNameState extends State<AssignmentName> {
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
      child: Text(
        "Mathematics: Calculus Assignment",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
      ),
    );
  }
}
