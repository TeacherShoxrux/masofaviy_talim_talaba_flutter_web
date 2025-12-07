import 'package:flutter/material.dart';
class Variant extends StatefulWidget {
  const Variant({super.key});

  @override
  State<Variant> createState() => _VariantState();
}

class _VariantState extends State<Variant> {
  bool isChecked=false;
  @override
  Widget build(BuildContext context) {
    return

      InkWell(
        onTap: ()=>setState(() {
          isChecked= !isChecked;
        }),
        child: Container(
          margin: EdgeInsets.only(top: 12,bottom: 12),
          padding: EdgeInsets.only(top: 12,bottom: 12),
          decoration: BoxDecoration(
            color: !isChecked?Colors.white10:Colors.black12,
            borderRadius: BorderRadius.circular(12),border: Border.all(color: Colors.black26)
          ),
          child: Row(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Checkbox.adaptive(value: isChecked, onChanged: (e)=>setState(() {
                isChecked= !isChecked;
              })),
            ),
            Flexible(child: Text("jhasdfj kasd fk aksdg askdksdjg askdjgf sdkj kjdg asdaksdvkasjsadjk",style: TextStyle(fontSize: 18),))
          ],
              ),
        ),
      );
  }
}
