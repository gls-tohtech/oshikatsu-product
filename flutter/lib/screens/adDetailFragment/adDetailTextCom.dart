import 'package:flutter/material.dart';

class AdDetailTextComponent extends StatelessWidget{
  late final String _detailText;

  AdDetailTextComponent({
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
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
          child: Text(_detailText),
        )
      ],
    );
  }
}