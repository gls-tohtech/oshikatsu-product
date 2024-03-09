import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';

class UserProfileComponent extends StatefulWidget {
  final UserProfile userProfile;
  UserProfileComponent({required this.userProfile});

  @override
  _UserProfileComponentState createState() => _UserProfileComponentState();
}

class _UserProfileComponentState extends State<UserProfileComponent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late UserProfile _userProfile = widget.userProfile;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // 設定ページへ遷移するロジックをここに記述
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // ユーザー情報セクション
          UserInformationSection(
            userProfile: _userProfile,
          ),
          // タブバー
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'プロジェクト'),
              Tab(text: 'クリエイト'),
            ],
          ),
          // タブビュー
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(color: Colors.white), // プロジェクトタブのコンテンツ
                Container(color: Colors.white), // クリエイトタブのコンテンツ
              ],
            ),
          ),
        ],
      ),
      // ここに他のコードを追加
    );
  }
}

class UserInformationSection extends StatelessWidget {
  late UserProfile userProfile;
  UserInformationSection({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    // ダミーのフォロー数とフォロワー数
    final int followersCount = 150;
    final int followingCount = 75;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(userProfile.name), // 仮の画像URL
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(userProfile.name,
                      style: Theme.of(context).textTheme.headline6
                    ),
                    Text(userProfile.biography),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('フォロー', style: Theme.of(context).textTheme.caption),
                  Text('$followingCount',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('フォロワー', style: Theme.of(context).textTheme.caption),
                  Text('$followersCount',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
