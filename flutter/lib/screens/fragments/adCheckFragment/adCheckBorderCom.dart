import 'package:flutter/material.dart';

class AdCheckBorderComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        Container(
          width: size.width * 1,
          height: size.height * 0.002,
          color: Colors.grey,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
      ],
    );
  }
}