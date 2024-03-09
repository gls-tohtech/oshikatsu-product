import 'dart:ui';

import 'package:flutter/material.dart';

class SwipeUI extends StatefulWidget {
  @override
  _SwipeUIState createState() => _SwipeUIState();
}

class _SwipeUIState extends State<SwipeUI> {
  // 表示する画像のリストを用意
  final List<String> images = [
    'https://pbs.twimg.com/media/Fsi7o2uacAsolwi?format=jpg&name=4096x4096',
    'https://pbs.twimg.com/media/F2LDbpHbAAEidt6?format=jpg&name=4096x4096',
    'https://files.slack.com/files-pri/T6EBP9WUR-F06NTEG3T5J/image.png',

    // ...他の画像を追加
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: images.length,
        scrollDirection: Axis.vertical, // 縦方向にスワイプ
        itemBuilder: (context, index) {
          String imagePath = images[index];
          return Container(
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //   image: ,
            //   fit: BoxFit.cover,
            // )),

            child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Container(),
                  Image.network(imagePath, fit: BoxFit.fill, height: 1000),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(color: Colors.black.withOpacity(0)),
                  ),
                  Image.network(imagePath, fit: BoxFit.fitWidth),
                ]),
            // child: Image.network(
            //   imagePath,
            //   fit: BoxFit.fitWidth, // 画面に合わせて画像を調整
            // ),
          );
        },
      ),
    );
  }
}
