import 'package:flutter/material.dart';

class TestLine extends StatefulWidget {
  const TestLine({super.key});

  @override
  State<TestLine> createState() => _State();
}

class _State extends State<TestLine> {
  @override
  Widget build(BuildContext context) {
    return Wrap(

      direction: Axis.horizontal,
      children: List.generate(
        20,
        (i) => Container(
          margin: EdgeInsets.only(right: 8,bottom: 8),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text("${i+1}"),
          ),
        ),
      ),
    );
  }
}
