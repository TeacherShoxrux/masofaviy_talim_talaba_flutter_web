import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/global/theme/app_colors.dart';
import 'package:masofaviy_talim_talaba/app/widgets/custom_elevated_button.dart';
class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  
  var item=[
    "Kimyo",
    "Oliy matematika",
    "Geografiya",
    "Boshqarish nazariyasini amaliy asoslari"
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: Text("Fanlar"),
        ),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 32),
      ),
        body: Container(
          padding: EdgeInsets.only(left: 30,right: 40),
          color: Colors.grey.shade300,
          child: ListView.builder(
              itemCount: item.length,
              itemBuilder: (_,i)=>Card(
                child: ListTile(
                  onTap: ()=>context.go('/subjects/12'),
                  selectedColor: Colors.blueAccent,
                  leading: Icon(Icons.science_outlined,size: 34,color: AppColors.primaryColor,),
                  trailing: CustomElevatedButton(text: "Kirish"),
                  title: Text(item[i]),
                  titleTextStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                  subtitle: Text("Matematika va geografiya fanlarni qiloli hisoblanadi va uni o'rganish kerak"),
                ),
              )),
        ));
  }
}
// Text("SubjectsPage"),
// ElevatedButton(onPressed: (){
// context.go('/subjects/12');
// }, child: Text("Subject details"))