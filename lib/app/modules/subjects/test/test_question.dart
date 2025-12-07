import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test/variant.dart';
import 'package:masofaviy_talim_talaba/app/widgets/custom_elevated_button.dart';

class TestQuestion extends StatefulWidget {
  const TestQuestion({super.key});

  @override
  State<TestQuestion> createState() => _TestQuestionState();
}

class _TestQuestionState extends State<TestQuestion> {
  @override
  Widget build(BuildContext context) {
    return  Container(

      width: double.infinity,
      margin: EdgeInsets.only(right: 30,left: 30,top: 8),
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.white10),
          boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 2,blurRadius: 2,blurStyle: BlurStyle.inner),BoxShadow(color: Colors.white10)]
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Question  N# 12", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
          SizedBox(height: 8,),
          Text("Solve this math mathmatical problem to solve this only on time to solve and count it on time 12+34= ?",
            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),
          ),
          SizedBox(height: 12,),
          Image.network("https://picsum.photos/500/300"),
          SizedBox(height: 12,),
          Divider(),
          Variant(),
          Variant(),
          Variant(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [  CustomElevatedButton(text: "Orqaga"),
              SizedBox(width: 20,),
              CustomElevatedButton(text: "Keyingisi"),
            ],
          )


        ],
      ),
    );
  }
}
