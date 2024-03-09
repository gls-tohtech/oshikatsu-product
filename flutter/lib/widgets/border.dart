import 'package:flutter/material.dart';

class HorizontalBorderComponent extends StatelessWidget{
  late final double _heightRatio;

  HorizontalBorderComponent({
    required double heightRatio
  }){
    _heightRatio = heightRatio;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        Container(
          width: size.width * 0.95,
          height: size.height * _heightRatio,
          color: Colors.grey,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
      ],
    );
  }
}