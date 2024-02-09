import 'package:flutter/material.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';

class AdDetailBorderComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        StandartPaddingComponent(),
        Container(
          width: size.width * 0.95,
          height: size.height * 0.006,
          color: Colors.grey,
        ),
        StandartPaddingComponent(),
      ],
    );
  }
}