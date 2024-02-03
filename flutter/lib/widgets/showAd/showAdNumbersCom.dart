import 'package:flutter/material.dart';

class ShowAdNumberesConponent extends StatelessWidget {
  late final int _aiderNumbers;
  late final int _createrNumbers;

  ShowAdNumberesConponent(
    this._aiderNumbers,
    this._createrNumbers
  );

  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height * 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRowCom(
            context: context, 
            labelTitle: "広告応援", 
            leftValue: _aiderNumbers, 
            rightValue: 0
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.002)),
          buildRowCom(
            context: context, 
            labelTitle: "クリエイター", 
            leftValue: _createrNumbers, 
            rightValue: 0
          ),
        ],
      )
    );
  }

  Widget buildRowCom({
    required BuildContext context,
    required String labelTitle, 
    required int leftValue,
    required int rightValue
  }){
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.22,
          child: Text(
            labelTitle,
            textScaler: TextScaler.linear(0.9),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            width: size.width * 0.15,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text("  $leftValue / $rightValue  "),
          ),
        ),
        const Text(" 人"),
      ],
    );
  }
}