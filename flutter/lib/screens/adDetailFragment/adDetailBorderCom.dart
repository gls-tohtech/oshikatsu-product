import 'package:flutter/material.dart';

class AdDetailBorderComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        Container(
          width: size.width * 0.95,
          height: size.height * 0.006,
          color: Colors.grey,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
      ],
    );
  }
}