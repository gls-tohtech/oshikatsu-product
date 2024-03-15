import 'package:flutter/material.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';

//ここに利用規約
const TERM_OF_SERVICE_TEXT = "# Flexible要素## 概要Flexibleウィジェットは、親要素が提供する大きさに子要素を合わせるウィジェットである。これは、[[Expanded要素]]と比較して、`Flexible`は子ウィジェットのサイズが親ウィジェットの描画領域よりも小さい場合に変更しないという点で特徴的である。## 見た目親要素に合わせてテキストが入っている[[Card要素]]の大きさが変更されている。![[Flexible要素の例.png]]## コード例こうすることで大きさが二分される。```DartRow(	children: 		Flexible(			child: const Text(test1)		),		Flexible			child: const Text(test2)		),	]),```## プロパティ| プロパティ名 | 概要 | 備考 || ------------ | ---- | ---- || flex             | 親ウィジェットが提供する空間をどの程度割り当てるか     |      |";

class TermOfServiceComponent extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        StandartPaddingComponent(),
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('利用規約', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              buildSection(
                'はじめに', 
                '本利用規約は、[アプリ名]（以下、「本アプリ」）の利用に関する条件を定めるものです。本アプリを利用するユーザー（以下、「ユーザー」）は、本利用規約に同意し、遵守することを条件として本アプリの利用を許諾します。'
              ),
              buildSection(
                'サービスの内容', 
                '本アプリは、ユーザーが情報を提供し、利用するためのプラットフォームを提供します。本アプリのサービスは、ユーザーが自分の情報を登録し、他のユーザーとの間で情報交換を行うことを可能にします。'
              ),
              buildSection(
                '利用規約の適用', 
                '本利用規約は、本アプリの全てのユーザーに適用されます。本アプリを利用することで、ユーザーは本利用規約に同意したものとみなされます。'
              ),
              buildSection(
                '利用規約の変更', 
                '本アプリは、必要に応じて本利用規約を変更することがあります。変更後の利用規約は、本アプリのウェブサイトまたはアプリ内で公開された時点から効力を生じます。ユーザーは、変更後の利用規約に同意したものとみなされます。'
              ),
              buildSection(
                '利用規約の解釈', 
                '本利用規約に関する解釈については、本アプリの裁量によります。'
              ),
              buildSection(
                '個人情報の取り扱い', 
                '本アプリは、ユーザーから提供された個人情報を適切に取り扱います。個人情報の取り扱いに関する詳細は、プライバシーポリシーを参照してください。'
              ),
              buildSection(
                '権利の譲渡の禁止', 
                'ユーザーは、本アプリのサービスに関する権利を第三者に譲渡したり、貸与したりすることはできません。'
              ),
              buildSection(
                '準拠法', 
                '本利用規約の解釈に関しては、日本法を準拠法とします。'
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSection(String title, String discription){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(discription),
      ],
    );
  }
}