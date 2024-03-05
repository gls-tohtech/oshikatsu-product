import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RadiusTextComponent extends StatelessWidget {
  late final String _text;
  late final Alignment _alignment;
  late final Function() _textTapped;
  late final double _widthRaio;
  late final double _widthFactorRatio;

  RadiusTextComponent(
    String text, {
    Alignment? alignment,
    Function()? textTapped,
    double? widthRatio,
    double? widthFactorRatio
  }){
    _text = text;
    alignment != null ? _alignment = alignment : _alignment = Alignment.center;
    textTapped != null ? _textTapped = textTapped : _textTapped = (() => {});
    widthRatio != null ? _widthRaio = widthRatio : _widthRaio = 0.2;
    widthFactorRatio != null ? _widthFactorRatio = widthFactorRatio : _widthFactorRatio = 1;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final customPurpleColor = Color(0xFF694D9F);
    return Align(
        alignment: _alignment,
        widthFactor: _widthFactorRatio,
        child: Container(
          width: size.width * _widthRaio,
          decoration: BoxDecoration(
            border: Border.all(
              color: customPurpleColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(256),
          ),
          child: InkWell(
              borderRadius: BorderRadius.circular(256),
              onTap: _textTapped,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _text,
                      textScaler: const TextScaler.linear(1),
                      style: TextStyle(
                          color: customPurpleColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ))),
        ));
  }
}
