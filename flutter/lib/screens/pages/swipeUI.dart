import 'dart:ui';

import 'package:flutter/material.dart';

class SwipeUI extends StatefulWidget {
  @override
  _SwipeUIState createState() => _SwipeUIState();
}

class _SwipeUIState extends State<SwipeUI> {
  final List<Post> posts = [
    Post(
      imageUrl: 'https://pbs.twimg.com/media/Fsi7o2uacAsolwi?format=jpg&name=4096x4096',
      avatarUrl: "https://kotonohaworks.com/free-icons/wp-content/uploads/kkrn_icon_user_4.png",
      avatarName: "あやか",
      projectName: "☆Wセンター記念☆ 応援広告作成プロジェクト",
      description: "",
    ),
    Post(
      imageUrl: 'https://pbs.twimg.com/media/F2LDbpHbAAEidt6?format=jpg&name=4096x4096',
      avatarUrl: "https://kotonohaworks.com/free-icons/wp-content/uploads/kkrn_icon_user_1.png",
      avatarName: "ずっと応援者",
      projectName: "生誕祭広告つくりましょう！",
      description: "",
    ),
    Post(
      imageUrl: "https://pbs.twimg.com/media/GHvJQKCaIAALlxA?format=jpg&name=4096x4096",
      avatarUrl: "https://kotonohaworks.com/free-icons/wp-content/uploads/kkrn_icon_user_2.png",
      avatarName: "夢見るサポーター",
      projectName: "勝手にコラボ！ W広告でお祝いしましょう！",
      description: "",
    ),
    Post(
      imageUrl: "https://pbs.twimg.com/media/E5HgSQRUYAMCnOW?format=jpg&name=large",
      avatarUrl: "https://kotonohaworks.com/free-icons/wp-content/uploads/kkrn_icon_user_3.png",
      avatarName: "めいめい",
      projectName: "【!!!デビュー記念!!!】みんなに番組みてもらおう！",
      description: "",
    ),
    Post(
      imageUrl: "https://pbs.twimg.com/media/FxqDNMiaQAAuU-H?format=jpg&name=large",
      avatarUrl: "https://kotonohaworks.com/free-icons/wp-content/uploads/kkrn_icon_user_5.png",
      avatarName: "mayu",
      projectName: "毎朝会いたいからバス停広告作りましょう♡",
      description: "",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: posts.length,
        scrollDirection: Axis.vertical, // 縦方向にスワイプ
        itemBuilder: (context, index) {
          Post post = posts[index];
          return Container(
              color: Colors.grey,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Image.network(post.imageUrl, fit: BoxFit.fill, height: 1000),
                  ),
                  Image.network(post.imageUrl, fit: BoxFit.fitWidth),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            post.projectName,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                const Text(
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  "オーナー",
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 8),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(post.avatarUrl),
                                          radius: 12,
                                        ),
                                      ),
                                      Text(
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        post.avatarName,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}

class Post {
  String imageUrl;
  String avatarUrl;
  String avatarName;
  String projectName;
  String description;

  Post({required this.imageUrl, required this.avatarUrl, required this.avatarName, required this.projectName, required this.description});
}


// https://kotonohaworks.com/free-icons/user/