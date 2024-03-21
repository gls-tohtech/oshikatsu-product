import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: Text(
                  title,
                  textScaler: const TextScaler.linear(1.5),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => { 
                  Navigator.of(context).pop(),
                }, 
                icon: const Icon(Icons.close)
              ),
            )
          ],
        )
      ],
    );
  }
}