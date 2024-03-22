import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oshikatsu_product/widgets/border.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';
import 'package:oshikatsu_product/widgets/topPadding.dart';

class HeaderTitleWidget extends StatelessWidget{
  final String title;

  HeaderTitleWidget(this.title);

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        TopPaddingComponent(),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                textScaler: const TextScaler.linear(1.5),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => { 
                  Navigator.of(context).pop(),
                }, 
                icon: const Icon(Icons.close)
              ),
            ),
          ],
        ),
        HorizontalBorderComponent(heightRatio: 0.002),
        StandartPaddingComponent()
      ],
    );
  }
}