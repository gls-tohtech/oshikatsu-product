import 'package:flutter/material.dart';
import 'spBorderCom.dart';

class SpContentsComponent extends StatelessWidget{
  late final String  _title;
  late final int _supportMoneyAmount = 1000;
  String _comment = "";

  SpContentsComponent({
    required String title
  }){
    _title = title;
  }

  @override 
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(),
        SpBorderComponent(),
        buildChoicePayment(context),
        SpBorderComponent(),
        buildSupportMoneyAmount(context),
        SpBorderComponent(),
        buildCommentSubmitForm(context),
        Padding(padding: EdgeInsets.symmetric(vertical:  size.height * 0.01)),
        buildButton(context)
      ],
    );
  }

  Widget buildTitle(){
    return Text(
      _title,
      textScaler: const TextScaler.linear(1.4),
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget buildChoicePayment(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "支払方法",
          textScaler: TextScaler.linear(1.2),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () => {}, 
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 32,
          )
        )
      ],
    );
  }

  Widget buildSupportMoneyAmount(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "応援金額",
          textScaler: TextScaler.linear(1.2),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: Text("$_supportMoneyAmount  円"),
          )
        )
      ],
    );
  }

  Widget buildCommentSubmitForm(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "コメント",
          textScaler: TextScaler.linear(1.1),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005),),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget buildButton(BuildContext context){
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
          onTap: () => {},
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "応援する",
                textScaler: TextScaler.linear(1),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          )
        ),
      )
    );
  }
}