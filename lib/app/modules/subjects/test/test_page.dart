import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test/test_line.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test/test_question.dart';
import 'package:masofaviy_talim_talaba/app/widgets/custom_button.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key, this.id});
  final String? id;
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int id=45;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Test name here"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(margin:EdgeInsets.only(left: 40,right: 40),child: TestLine()), TestQuestion(),
          SizedBox(height: 20,),
          SizedBox(width:300,child: CustomButton(text: "Testni yakunlash",onTap: (){
            context.go("..");
            context.go('/subjects/${widget.id}/test_result/$id');

          },)),SizedBox(height: 30,)
          ],
        ),
      )
    );
  }
}
