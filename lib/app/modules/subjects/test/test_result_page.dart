import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/global/theme/app_colors.dart';

import '../../../widgets/custom_elevated_button.dart';

class TestResultPage extends StatefulWidget {
  const TestResultPage({super.key, this.id});
  final String? id;
  @override
  State<TestResultPage> createState() => _TestResultState();
  }

  class _TestResultState extends State<TestResultPage> {

    @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade300,
        child: Center(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all()
            ),
            width: 600,
            height: 300,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Column(
                    children: [
                      Text("Test result",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 34),),
                      Text("86%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50, color: AppColors.primaryColor),),
                      Text("Congratulations! You scored 86% on your Mathematics test. Keep up the good work and see where you can improve by reviewing the detailed analysis above.",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                    ],
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton(text: "Qaytish",onPressed: ()=>context.go("/subjects/12")),
                        SizedBox(width: 20),
                        CustomElevatedButton(text: "Yana test",),

                      ],
                    ),
                  )



              ]
            )
          ),
        )
      ),
    );
  }
}
