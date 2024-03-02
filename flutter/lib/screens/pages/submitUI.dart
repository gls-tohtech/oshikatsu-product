import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: SubmitUI()));
}

class SubmitUI extends StatefulWidget {
  const SubmitUI({Key? key}) : super(key: key);

  @override
  State<SubmitUI> createState() => _SubmitUIState();
}

class _SubmitUIState extends State<SubmitUI> {
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
        title: const Text("Submit Page"), // constを追加
      ),
      body: SingleChildScrollView(
        // SingleChildScrollViewを追加
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8.0), // constを追加
            margin: const EdgeInsets.all(8.0), // constを追加
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20), // constを追加
                // 見出しテキスト
                const Text(
                  "プロジェクト作成",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // 見出しの下の線
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                const SizedBox(height: 20), // constを追加
                Container(
                  padding: const EdgeInsets.all(8.0), // constを追加
                  child: Image.asset('lib/screens/pages/5-25.jpg'),
                ),
                const SizedBox(height: 20), // constを追加
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "タイトル", // 見出しテキスト
                    style: TextStyle(
                      fontSize: 16, // フォントサイズを適宜調整
                      fontWeight: FontWeight.bold, // フォントを太く
                    ),
                  ),
                ),
                const SizedBox(height: 8), // 見出しとテキストフィールドの間のスペース
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'タイトルを入力', // ユーザーがテキストフィールドに何を入力すべきか示すラベル
                  ),
                ),
                const SizedBox(height: 20), // constを追加
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "広告の説明", // 見出しテキスト
                    style: TextStyle(
                      fontSize: 16, // フォントサイズを適宜調整
                      fontWeight: FontWeight.bold, // フォントを太く
                    ),
                  ),
                ),
                const SizedBox(height: 8), // constを追加
                TextField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '広告の説明',
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: const Text(
                        '目標金額',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 40.0, // ここでコンテナの高さを設定
                        child: TextFormField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            isDense: true, // 追加：フィールドの密度を高くする
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 8.0), // 上下のパディングを調整
                            border: OutlineInputBorder(),
                            hintText: '金額を入力',
                            suffixText: '円',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
                ),

                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),

                const SizedBox(height: 8), // constを追加
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // 子ウィジェットを左揃えにする
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '期限',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 50, // TextFieldの横幅を指定
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '月',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 8.0),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 8.0), // TextFieldとテキストの間のスペースを調整
                            Text('月',
                                style:
                                    TextStyle(fontSize: 16.0)), // 月というテキストを表示
                          ],
                        ),
                        SizedBox(width: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 50, // TextFieldの横幅を指定
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '月',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 8.0),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 8.0), // TextFieldとテキストの間のスペースを調整
                            Text('月',
                                style:
                                    TextStyle(fontSize: 16.0)), // 月というテキストを表示
                          ],
                        ),
                        SizedBox(width: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 50, // TextFieldの横幅を指定
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '月',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 8.0),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 8.0), // TextFieldとテキストの間のスペースを調整
                            Text('月',
                                style:
                                    TextStyle(fontSize: 16.0)), // 月というテキストを表示
                          ],
                        ),
                        SizedBox(width: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 50, // TextFieldの横幅を指定
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '月',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 8.0),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 8.0), // TextFieldとテキストの間のスペースを調整
                            Text('月',
                                style:
                                    TextStyle(fontSize: 16.0)), // 月というテキストを表示
                          ],
                        ),
                        SizedBox(width: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 50, // TextFieldの横幅を指定
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '月',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 8.0),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 8.0), // TextFieldとテキストの間のスペースを調整
                            Text('月',
                                style:
                                    TextStyle(fontSize: 16.0)), // 月というテキストを表示
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: const Text(
                        '掲載場所',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '掲載場所',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: const Text(
                        'ハッシュタグ',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ハッシュタグを追加する',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '支援して欲しいもの',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildButton(context, 'お金'),
                    _buildButton(context, '素材'),
                    _buildButton(context, 'クリエイター'),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "共同制作部屋の作成", // 見出しテキスト
                    style: TextStyle(
                      fontSize: 22, // フォントサイズを適宜調整
                      fontWeight: FontWeight.bold, // フォントを太く
                    ),
                  ),
                ),
                const SizedBox(height: 15), // 見出しとテキストフィールドの間のスペース
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "グループ名", // 見出しテキスト
                    style: TextStyle(
                      fontSize: 16, // フォントサイズを適宜調整
                      fontWeight: FontWeight.bold, // フォントを太く
                    ),
                  ),
                ),
                const SizedBox(height: 8), // 見出しとテキストフィールドの間のスペース
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'グループ名を入力', // ユーザーがテキストフィールドに何を入力すべきか示すラベル
                  ),
                ),
                const SizedBox(height: 15), // 見出しとテキストフィールドの間のスペース
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "素材提供者の募集人数", // 見出しテキスト
                    style: TextStyle(
                      fontSize: 16, // フォントサイズを適宜調整
                      fontWeight: FontWeight.bold, // フォントを太く
                    ),
                  ),
                ),
                const SizedBox(height: 8), // 見出しとテキストフィールドの間のスペース
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 200, // ここで希望の幅を指定
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixText: '人', // 人を表す絵文字
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15), // 見出しとテキストフィールドの間のスペース
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "クリエイターの人数", // 見出しテキスト
                    style: TextStyle(
                      fontSize: 16, // フォントサイズを適宜調整
                      fontWeight: FontWeight.bold, // フォントを太く
                    ),
                  ),
                ),
                const SizedBox(height: 8), // 見出しとテキストフィールドの間のスペース
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 200, // ここで希望の幅を指定
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixText: '人', // 人を表す絵文字
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // constを追加
                ElevatedButton(
                  onPressed: () {
                    // ここにボタンが押された時の処理を書く
                  },
                  child: const Text('保存する'), // constを追加
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: () {
          // ボタンが押された時のアクションをここに書く
          print('$label button pressed');
        },
        child: Text(label),
      ),
    );
  }
}
