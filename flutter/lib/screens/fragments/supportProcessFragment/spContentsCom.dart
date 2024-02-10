import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/ads/ad.dart';
import 'package:oshikatsu_product/screens/fragments/adCheckFragment/adCheckFragment.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';
import 'spBorderCom.dart';

class SpContentsComponent extends StatelessWidget{
  late final Ad _ad;
  late final String  _title;
  int _supportMoneyAmount = 1000;
  String _comment = "";

  SpContentsComponent({
    required Ad ad
  }){
    _ad = ad;
    _title = _ad.dbProcessedMap[AdTableColumn.AD_TITLE.name];
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
            child: MoneyAmountSelectMenuComponent((p0) => {_supportMoneyAmount = p0})
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
        StandartPaddingComponent(),
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
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return AdCheckFragment(
                ad: _ad,
                supportMoneyAmount: _supportMoneyAmount, 
                comment: _comment
              );
            }))
          },
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

class MoneyAmountSelectMenuComponent extends StatefulWidget {
  late final Function(int) _setMoneyAmount;

  MoneyAmountSelectMenuComponent(this._setMoneyAmount);

  @override
  _MoneyAmountSelectMenuComponentState createState() => _MoneyAmountSelectMenuComponentState(this._setMoneyAmount);
}

class _MoneyAmountSelectMenuComponentState extends State<MoneyAmountSelectMenuComponent> {
  late final Function(int) _setMoneyAmount;
  int _selectedValue = 1000;

  _MoneyAmountSelectMenuComponentState(this._setMoneyAmount);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: const[
        DropdownMenuItem(
          child: Text("1000 円"),
          value: 1000
        ),
        DropdownMenuItem(
          child: Text("5000 円"),
          value: 5000
        ),
        DropdownMenuItem(
          child: Text("10000 円"),
          value: 10000
        ),
        DropdownMenuItem(
          child: Text("20000 円"),
          value: 20000
        ),
      ], 
      value: _selectedValue,
      onChanged: (value) {
        setState(() {
          _selectedValue = value!;
          _setMoneyAmount(_selectedValue);
        });
      }
    );
  }
}