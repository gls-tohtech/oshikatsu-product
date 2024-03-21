import 'package:flutter/material.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';

void showWarnDialog(BuildContext context, String text){
  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              children: [
                const Icon(
                  Icons.warning,
                  size: 75,
                ),
                StandartPaddingComponent(),
                FittedBox(
                  child: Text(text),
                )
              ],
            )
          ),
        ),
        elevation: 8,
      );
    }
  );
}