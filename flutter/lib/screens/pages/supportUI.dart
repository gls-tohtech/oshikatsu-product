import 'package:flutter/material.dart';
import 'submitUI.dart'; // 必要に応じてパスを調整してください

class SupportUI extends StatefulWidget {
  const SupportUI({Key? key}) : super(key: key);

  @override
  State<SupportUI> createState() => _SupportUIState();
}

class _SupportUIState extends State<SupportUI>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '投稿一覧', icon: Icon(Icons.list)),
            Tab(text: '投稿作成', icon: Icon(Icons.create)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Itiran(title: '投稿一覧です', icon: Icons.list), // '投稿一覧' タブの内容
          // 第二のタブの内容はここでは省略し、_handleTabSelectionで処理を行う意図を変更していません。
          SubmitUI(),
        ],
      ),
    );
  }
}

class Itiran extends StatelessWidget {
  final String title;
  final IconData icon;

  const Itiran({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 100), // アイコンを使用
            SizedBox(width: 20),
            Column(
              children: <Widget>[
                Text(
                  title, // プロパティからのタイトルを使用
                  style: TextStyle(fontSize: 24),
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'タイトルを入力',
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
