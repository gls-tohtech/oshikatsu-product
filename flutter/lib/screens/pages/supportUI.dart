import 'package:flutter/material.dart';
// 必要なパッケージをimportします。これらはダミーであり、実際のパッケージに置き換えてください。
// import 'package:oshikatsu_product/controllers/projectController.dart';
// import 'package:oshikatsu_product/widgets/radiusText.dart';
// import 'package:oshikatsu_product/widgets/standardPadding.dart';

void main() {
  runApp(MaterialApp(home: SupportUI()));
}

class SupportUI extends StatefulWidget {
  const SupportUI({Key? key}) : super(key: key);

  @override
  State<SupportUI> createState() => _SupportUIState();
}

class _SupportUIState extends State<SupportUI> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support Page"), // constを追加
      ),
      body: SingleChildScrollView(
        // SingleChildScrollViewを追加
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/image.png', // 画像ファイルへのパス
              width: 100, // 画像の幅
              height: 100, // 画像の高さ
            ),
            SizedBox(width: 20), // 画像とテキストの間隔
            Column(
              children: <Widget>[
                Text(
                  'タイトル', // 表示したいテキスト
                  style: TextStyle(fontSize: 24), // テキストのスタイル
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'タイトルを入力', // ユーザーがテキストフィールドに何を入力すべきか示すラベル
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
