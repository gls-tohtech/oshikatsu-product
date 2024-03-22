import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/controllers/projectController.dart';
import 'package:oshikatsu_product/controllers/roomController.dart';
import 'package:oshikatsu_product/models/projects/project.dart';
import 'package:oshikatsu_product/models/projects/projectStore.dart';
import 'package:oshikatsu_product/settings/appColors.dart';
import 'package:oshikatsu_product/widgets/hashtags.dart';
import 'package:oshikatsu_product/widgets/radiusText.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';
import 'package:oshikatsu_product/widgets/submitSuccessPopup.dart';
import 'package:oshikatsu_product/widgets/termOfService.dart';

class SubmitFragment extends StatefulWidget {
  const SubmitFragment({Key? key}) : super(key: key);

  @override
  State<SubmitFragment> createState() => _SubmitFragmentState();
}

class _SubmitFragmentState extends State<SubmitFragment> {
  final TextEditingController _amountController = TextEditingController();
  int _selectedValue = 1000;
  String _selectedPlatform = "X";
  DateTime? _selectedDate;

  TextEditingController _title = TextEditingController();
  TextEditingController _discription = TextEditingController();
  String _imageUrl = "";
  TextEditingController _moneyGoal = TextEditingController();
  TextEditingController _roomName = TextEditingController();
  TextEditingController _hashtagsController = TextEditingController();

  List<String> _hashtags = [];

  bool _isShowSuccessPopup = false;

  void _submitButtonTapped(){
    _uploadProject();
  }

  void _uploadProject() async {
    final userController = UserController();
    final registry = ProjectRegistry();

    bool isExcuteable = await _checkDecided();
    if(!isExcuteable) return;

    final project = Project(
      createdAt: Timestamp.now(), 
      createdBy: userController.userRef, 
      admins: [], 
      members: [], 
      donaters: [], 
      title: _title.text, 
      discription: _discription.text, 
      deadline: Timestamp.fromDate(_selectedDate!), 
      hashtags: [], 
      thumbnailUrl: _imageUrl, 
      moneyGoal: int.tryParse(_moneyGoal.text) ?? 0, 
      moneyDonated: 0,
      roomID: _roomName.text
    );

    registry.add(newProjectData: project);

    _createRoom();

    setState(() {
      _isShowSuccessPopup = !_isShowSuccessPopup;
    });
  }

  void _createRoom() async {
    final userController = UserController();
    final roomController = RoomController();
    roomController.createGroupRoom(_roomName.text, [userController.uid!]);
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );

    if(pickedDate == null) return;
    
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  Future<bool> _checkDecided() async {
    if(_title.text == "") {
      _showWarnDialog("タイトル");
      return false;
    }
    if(_moneyGoal.text == ""){
      _showWarnDialog("目標金額");
      return false;
    }
    if(_selectedDate == null) {
      _showWarnDialog("期限日時");
      return false;
    }
    if(_roomName.text == "") {
      _showWarnDialog("共同制作部屋の名前");
      return false;
    }
    return true;
  }

  void _showWarnDialog(String unDecidedColumn){
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Column(
                children: [
                  Icon(
                    Icons.warning,
                    size: 75,
                  ),
                  StandartPaddingComponent(),
                  Text("$unDecidedColumnを"),
                  const Text("入力してください"),
                ],
              )
            ),
          ),
          elevation: 8,
        );
      }
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    StandartPaddingComponent(),
                    _imageUrl != ""
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(_imageUrl),
                      )
                      : InkWell(
                        radius: 8,
                        onTap: () async {
                          ProjectController projectController = ProjectController();
                          final result = await projectController.pickImageAndUpload();
                          setState(() {
                            _imageUrl = result;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors().primaryColor,
                              width: 1
                            )
                          ),
                          height: 180,
                          width: double.infinity,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Icon(
                                Icons.image_search,
                                size: 100,
                              ),
                              Text("サムネイルイメージを選択する"),
                            ],
                          )
                        ),
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
                      controller: _title,
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
                      controller: _discription,
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
                        const Expanded(
                          flex: 2,
                          child: Text(
                            '目標金額',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 40.0, // ここでコンテナの高さを設定
                            child: TextFormField(
                              controller: _moneyGoal,
                              decoration: const InputDecoration(
                                isDense: true, // 追加：フィールドの密度を高くする
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 8.0
                                ), // 上下のパディングを調整
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
                            const Text(
                              '期限',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RadiusTextComponent(
                              "期限を選択",
                              widthRatio: 0.3,
                              textTapped: () => _pickDateTime(context)
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: _selectedDate != null 
                              ? Text(
                                  '期限日時: ${_selectedDate!.year}年 ${_selectedDate!.month.toString().padLeft(2, '0')}月 ${_selectedDate!.day.toString().padLeft(2, '0')}日',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                )
                              : const SizedBox.shrink(),
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
                        const Expanded(
                          flex: 2,
                          child: Text(
                            '掲載場所',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 40.0, // ここでコンテナの高さを設定
                            child: DropdownButton(
                              items: const[
                                DropdownMenuItem(
                                  child: Text("X"),
                                  value: "X",
                                ),
                                DropdownMenuItem(
                                  child: Text("Instagram"),
                                  value: "Instagram"
                                ),
                                DropdownMenuItem(
                                  child: Text("facebook"),
                                  value: "facebook",
                                ),
                              ], 
                              value: _selectedPlatform,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPlatform = value!;
                                });
                              },
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
                        Row(
                          children: <Widget>[
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'ハッシュタグ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 40.0, // ここでコンテナの高さを設定
                                child: TextFormField(
                                  controller: _hashtagsController,
                                  decoration: const InputDecoration(
                                    isDense: true, // 追加：フィールドの密度を高くする
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 8.0), // 上下のパディングを調整
                                    border: OutlineInputBorder(),
                                    hintText: 'ハッシュタグを追加する',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 40.0, // ここでコンテナの高さを設定
                                child: RadiusTextComponent(
                                  "追加",
                                  textTapped: () {
                                    setState(() {
                                      String hashtag = _hashtagsController.text;
                                      if(hashtag == "") return; 
                                      _hashtags.add(hashtag);
                                      _hashtagsController.text = "";
                                    });
                                  },
                                )
                              ),
                            ),
                          ],
                        ),
                        StandartPaddingComponent(),
                        HashtagsComponent(hashtags: _hashtags)
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
                            const SizedBox(
                              width: 10,
                            ),
                            RadiusTextComponent('素材'),
                            const SizedBox(
                              width: 10,
                            ),
                            RadiusTextComponent(
                              'クリエイター',
                              widthRatio: 0.3,
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
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
                    SizedBox(
                      height: 40.0, // ここでコンテナの高さを設定
                      child: TextFormField(
                        controller: _roomName,
                        decoration: const InputDecoration(
                          isDense: true, // 追加：フィールドの密度を高くする
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8.0), // 上下のパディングを調整
                          border: OutlineInputBorder(),
                          hintText: 'グループ名',
                        ),
                      ),
                    ),
                    // const SizedBox(height: 15), // 見出しとテキストフィールドの間のスペース
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   child: const Text(
                    //     "素材提供者の募集人数", // 見出しテキスト
                    //     style: TextStyle(
                    //       fontSize: 16, // フォントサイズを適宜調整
                    //       fontWeight: FontWeight.bold, // フォントを太く
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 8), // 見出しとテキストフィールドの間のスペース
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: SizedBox(
                    //     width: 200,
                    //     height: 40.0, // ここでコンテナの高さを設定
                    //     child: TextFormField(
                    //       decoration: const InputDecoration(
                    //           isDense: true, // 追加：フィールドの密度を高くする
                    //           contentPadding: EdgeInsets.symmetric(
                    //               vertical: 10.0, horizontal: 8.0), // 上下のパディングを調整
                    //           border: OutlineInputBorder(),
                    //           suffixText: '人'),
                    //       keyboardType: TextInputType.number,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 15), // 見出しとテキストフィールドの間のスペース
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   child: const Text(
                    //     "クリエイターの人数", // 見出しテキスト
                    //     style: TextStyle(
                    //       fontSize: 16, // フォントサイズを適宜調整
                    //       fontWeight: FontWeight.bold, // フォントを太く
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 8), // 見出しとテキストフィールドの間のスペース
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: SizedBox(
                    //     width: 200,
                    //     height: 40.0, // ここでコンテナの高さを設定
                    //     child: TextFormField(
                    //       decoration: const InputDecoration(
                    //           isDense: true, // 追加：フィールドの密度を高くする
                    //           contentPadding: EdgeInsets.symmetric(
                    //               vertical: 10.0, horizontal: 8.0), // 上下のパディングを調整
                    //           border: OutlineInputBorder(),
                    //           suffixText: '人'),
                    //       keyboardType: TextInputType.number,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20), // constを追加
                    RadiusTextComponent(
                      '投稿する',
                      widthRatio: 0.7,
                      textTapped: () {
                        _submitButtonTapped();
                      },
                    ),
                    // StandartPaddingComponent(),
                    // const Divider(
                    //   color: Colors.grey,
                    //   thickness: 1,
                    // ),
                    // TermOfServiceComponent()
                  ],
                ),
              ),
            ),
          ),
          if(_isShowSuccessPopup) SubmitSucecssPopupComponent(
            imageUrl: _imageUrl, 
            closePopup: () => { _isShowSuccessPopup = !_isShowSuccessPopup }
          )
        ],
      )
    );
  }
}
