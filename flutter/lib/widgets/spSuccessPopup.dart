import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oshikatsu_product/widgets/radiusText.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';

class SPSucecssPopupComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.3),
        child: Card(
          color: Colors.white,
          elevation: 8,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.015)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(256),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5
                  )
                ),
                child: const Icon(
                  Icons.check,
                  size: 120,
                ),
              ),
              StandartPaddingComponent(),
              const Text("応援ありがとう!"),
              StandartPaddingComponent(),
              RadiusTextComponent(
                "ホームへ", 
                textTapped: () => {
                  Navigator.of(context).pop(),
                  Navigator.of(context).pop(),
                  Navigator.of(context).pop(),
                  Navigator.of(context).pop(),
                },
                widthRatio: 0.5,
                widthFactorRatio: 1.5,
              )
            ],
          ),
        ),
      ),
    );
  }
}