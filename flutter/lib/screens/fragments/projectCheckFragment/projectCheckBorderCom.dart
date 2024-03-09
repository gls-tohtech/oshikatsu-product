import 'package:flutter/material.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';

class ProjectCheckBorderComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        StandartPaddingComponent(),
        Container(
          width: size.width * 1,
          height: size.height * 0.002,
          color: Colors.grey,
        ),
        StandartPaddingComponent(),
      ],
    );
  }
}