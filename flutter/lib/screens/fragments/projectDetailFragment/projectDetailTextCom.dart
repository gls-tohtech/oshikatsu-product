import 'package:flutter/material.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';

class ProjectDetailTextComponent extends StatelessWidget{
  late final String _detailText;

  ProjectDetailTextComponent({
    required String detailText
  }){
    _detailText = detailText;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "広告概要",
            textScaler: TextScaler.linear(1.5),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        StandartPaddingComponent(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
          child: Text(_detailText),
        )
      ],
    );
  }
}