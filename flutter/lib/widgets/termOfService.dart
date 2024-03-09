import 'package:flutter/material.dart';

//ここに利用規約
const TERM_OF_SERVICE_TEXT = "# Flexible要素## 概要Flexibleウィジェットは、親要素が提供する大きさに子要素を合わせるウィジェットである。これは、[[Expanded要素]]と比較して、`Flexible`は子ウィジェットのサイズが親ウィジェットの描画領域よりも小さい場合に変更しないという点で特徴的である。## 見た目親要素に合わせてテキストが入っている[[Card要素]]の大きさが変更されている。![[Flexible要素の例.png]]## コード例こうすることで大きさが二分される。```DartRow(	children: 		Flexible(			child: const Text(test1)		),		Flexible			child: const Text(test2)		),	]),```## プロパティ| プロパティ名 | 概要 | 備考 || ------------ | ---- | ---- || flex             | 親ウィジェットが提供する空間をどの程度割り当てるか     |      |";

class TermOfServiceComponent extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical:  size.height * 0.005)),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "利用規約",
            textScaler: TextScaler.linear(1.2),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical:  size.height * 0.005)),
        const Text(TERM_OF_SERVICE_TEXT)
      ],
    );
  }
}