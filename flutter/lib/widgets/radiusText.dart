import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RadiusTextComponent extends StatelessWidget{
  late final String _text;
  late final Function() _textTapped;
  late final double _widthRaio;

  RadiusTextComponent(
    String text,
    Function()? textTapped,
    double? widthRaio
  ){
    _text = text;
    textTapped != null ? _textTapped = textTapped : _textTapped = (() => {});
    widthRaio != null ? _widthRaio = widthRaio : _widthRaio = 0.2;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: size.width * 0.5,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(256),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(256),
          onTap: _textTapped(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                _text,
                textScaler: const TextScaler.linear(1),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          )
        ),
      )
    );
  }
}