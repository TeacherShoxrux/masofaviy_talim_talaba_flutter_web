import 'package:flutter/material.dart';


class SubjectItemList extends StatefulWidget {
  final String title;
  final Widget? mainIcon;
  final int itemCount;
  final Widget? Function(BuildContext context, int index) builder;

  const SubjectItemList({
    super.key,
    required this.title,
    this.mainIcon, required this.builder, required this.itemCount,

  });

  @override
  State<SubjectItemList> createState() => _ExpandableVideoListState();
}

class _ExpandableVideoListState extends State<SubjectItemList> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 5),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black45),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
                onTap: () {
                  setState(() => isOpen = !isOpen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(color: Colors.black, fontSize: 24,fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: (){
                        setState(() => isOpen = !isOpen);
                      },
                      icon: Icon(
                        isOpen ? Icons.expand_less : Icons.expand_more,
                        size: 45,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),

          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: isOpen ? widget.itemCount * 60 : 0,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 8),
              itemCount: widget.itemCount,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: widget.builder
            ),
          ),
        ],
      ),
    );
  }
}
