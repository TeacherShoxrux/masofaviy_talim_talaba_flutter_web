import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("SubjectsPage"),
        ElevatedButton(onPressed: (){
          context.go('/subjects/12');
        }, child: Text("Subject details"))
      ],
    ));
  }
}
