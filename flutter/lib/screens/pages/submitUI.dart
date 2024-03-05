import 'package:flutter/material.dart';
import 'package:oshikatsu_product/controllers/projectController.dart';
import 'package:oshikatsu_product/widgets/radiusText.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';

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
  int _selectedValue = 1000;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  String _imageUrl = "";

  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime ?? TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDate = pickedDate;
          _selectedTime = pickedTime;
        });
      }
    }
  }

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
                  child: RadiusTextComponent(
                    "追加",
                    textTapped: () async {
                      ProjectController projectController = ProjectController();
                      final result =
                          await projectController.pickImageAndUpload();
                      setState(() {
                        _imageUrl = result;
                      });

                      print("$_imageUrl");
                    },
                  ),
                ),
                Image.network(_imageUrl),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '期限',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          child: RadiusTextComponent("期限を選択",
                              widthRaio: 0.3,
                              textTapped: () => _pickDateTime(context)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: _selectedDate != null && _selectedTime != null
                          ? Text(
                              '期限日時: ${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')} ${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            )
                          : SizedBox.shrink(),
                      // 条件に合わない場合は何も表示しない
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
                      flex: 2,
                      child: Container(
                        height: 40.0, // ここでコンテナの高さを設定
                        child: TextFormField(
                          decoration: const InputDecoration(
                            isDense: true, // 追加：フィールドの密度を高くする
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 8.0), // 上下のパディングを調整
                            border: OutlineInputBorder(),
                            hintText: '掲載場所',
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
                      flex: 2,
                      child: Container(
                        height: 40.0, // ここでコンテナの高さを設定
                        child: TextFormField(
                          decoration: const InputDecoration(
                            isDense: true, // 追加：フィールドの密度を高くする
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 8.0), // 上下のパディングを調整
                            border: OutlineInputBorder(),
                            hintText: 'ハッシュタグを追加する',
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
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "支援して欲しいもの", // 見出しテキスト
                        style: TextStyle(
                          fontSize: 16, // フォントサイズを適宜調整
                          fontWeight: FontWeight.bold, // フォントを太く
                        ),
                      ),
                    ),
                    //const SizedBox(height: 10),
                    StandartPaddingComponent(),
                    Row(
                      children: [
                        RadiusTextComponent('お金'),
                        SizedBox(
                          width: 10,
                        ),
                        RadiusTextComponent('素材'),
                        SizedBox(
                          width: 10,
                        ),
                        RadiusTextComponent(
                          'クリエイター',
                          widthRaio: 0.3,
                        ),
                      ],
                    )
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
                Container(
                  height: 40.0, // ここでコンテナの高さを設定
                  child: TextFormField(
                    decoration: const InputDecoration(
                      isDense: true, // 追加：フィールドの密度を高くする
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8.0), // 上下のパディングを調整
                      border: OutlineInputBorder(),
                      hintText: 'グループ名',
                    ),
                    keyboardType: TextInputType.number,
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
                    width: 200,
                    height: 40.0, // ここでコンテナの高さを設定
                    child: TextFormField(
                      decoration: const InputDecoration(
                          isDense: true, // 追加：フィールドの密度を高くする
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8.0), // 上下のパディングを調整
                          border: OutlineInputBorder(),
                          suffixText: '人'),
                      keyboardType: TextInputType.number,
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
                    width: 200,
                    height: 40.0, // ここでコンテナの高さを設定
                    child: TextFormField(
                      decoration: const InputDecoration(
                          isDense: true, // 追加：フィールドの密度を高くする
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8.0), // 上下のパディングを調整
                          border: OutlineInputBorder(),
                          suffixText: '人'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                const SizedBox(height: 20), // constを追加
                RadiusTextComponent(
                  '投稿する',
                  widthRaio: 0.7,
                )
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
