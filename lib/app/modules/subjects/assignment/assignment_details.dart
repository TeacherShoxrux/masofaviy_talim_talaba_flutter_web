import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/global/theme/app_colors.dart';

class AssignmentDetails extends StatelessWidget {
  const AssignmentDetails({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Assignment Details",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          Text(
            "This assignment requires you to solve the given calculus problems and submit your solutions in a PDF or DOC file. Make sure to include all your workings and explanations.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 20,),

            child: InkWell(
              onTap: (){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.picture_as_pdf_rounded),
                    color: AppColors.primaryColor,
                  ),
                  Text("Download Assignment.pdf", style: TextStyle(fontWeight: FontWeight.w500,color: AppColors.primaryColor)),

                ],
              ),
            ),
          ),
          Container(

            padding: EdgeInsets.symmetric(horizontal: 20,),
                       child: InkWell(
              onTap: (){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.picture_as_pdf_rounded),
                    color: AppColors.primaryColor,
                  ),
                  Text("Download Assignment.pdf", style: TextStyle(fontWeight: FontWeight.w500,color: AppColors.primaryColor)),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
