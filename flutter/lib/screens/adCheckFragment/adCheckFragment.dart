import 'package:flutter/material.dart';
import 'adCheckBorderCom.dart';

class AdCheckFragment extends StatelessWidget{
  late final String _title;
  late final int _supportMoneyAmount;
  late final TextEditingController _textController;

  AdCheckFragment({
    required String title,
    required int supportMoneyAmount,
    required String comment
  }){
    _title = title;
    _supportMoneyAmount = supportMoneyAmount;
    _textController = TextEditingController(text: comment);
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      child: Column(
        children: [
          buildHeader(context),
          AdCheckBorderComponent(),
          buildTitle(),
          AdCheckBorderComponent(),
          buildChoicePayment(context),
          AdCheckBorderComponent(),
          buildSupportMoneyAmount(context),
          AdCheckBorderComponent(),
          buildCommentSubmitForm(context),
          Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.02)),
          buildButton(context)
        ],
      ),
    );
  }

  Widget buildTitle(){
    return Text(
      _title,
      textScaler: const TextScaler.linear(1.4),
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }


  Widget buildHeader(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: size.height * 0.01),
            child: const Text(
              "応援内容の確認",
              textScaler: TextScaler.linear(1.5),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ),
        Align(
          alignment: Alignment.centerRight,
          child:  IconButton(
            onPressed: () => { 
              Navigator.of(context).pop(),
            }, 
            icon: const Icon(Icons.close)
          ),
        )
      ],
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red
          ),
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
          controller: _textController,
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