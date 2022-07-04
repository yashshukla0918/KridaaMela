import 'package:flutter/material.dart';
class Barrier extends StatelessWidget {

  const Barrier({Key? key, required this.height}) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return    Container(
      height: height,
      width: 80,
      decoration: BoxDecoration(
        color:Colors.green,
        border: Border.all(width: 8,color: Colors.green.shade900),
        borderRadius: BorderRadius.circular(10.0)
      ),
    );
  }
}
