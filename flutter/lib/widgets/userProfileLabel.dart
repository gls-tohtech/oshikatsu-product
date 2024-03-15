import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/models/users/UserStore.dart';
import 'package:oshikatsu_product/widgets/userProfile.dart';

class UserProfileLabelComponent extends StatelessWidget {
  final DocumentReference userRef;
  final double widthRatio;

  final _fetcher = UserDataFetcher();

  UserProfileLabelComponent({
    required this.userRef, 
    required this.widthRatio,
  });

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _fetcher.fetchUserProfileFromRef(userRef: userRef), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // ローディング表示
        } else if (snapshot.hasError) {
          return const Center(child: Text('エラーが発生しました')); // エラーハンドリング
        } else {
          return InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return UserProfileComponent(
                    userProfile: snapshot.data!,
                    userRef: userRef,
                    isLoginedUser: false,
                  );
                }
              ));
            },
            child: SizedBox(
              height: size.height * 0.05,
              width: size.width * widthRatio,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: CircleAvatar(
                      child: snapshot.data!.iconImageUrl != ""
                        ? Image.network(snapshot.data!.iconImageUrl)
                        : const Icon(Icons.person),
                    ),
                  ),
                  SizedBox(width: size.width * widthRatio * 0.05),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: StrokedText(
                      snapshot.data!.name,
                      fontSize: 16,
                      color: Colors.black,
                      strokeColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ); // データ表示
        }
      }
    );
  }
}

class StrokedText extends StatelessWidget {
 const StrokedText(
    this.text, {
    this.color,
    this.strokeColor,
    this.fontSize,
    this.strokeSize,
    Key? key,
 }) : super(key: key);

 final String text;
 final Color? color;
 final Color? strokeColor;
 final double? fontSize;
 final double? strokeSize;

 @override
 Widget build(BuildContext context) {
    final fontSize = this.fontSize ??
        Theme.of(context).textTheme.bodyMedium?.fontSize ??
        16.0;

    return Stack(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeSize ?? 4
              ..color = strokeColor ?? Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
 }
}
