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
                    showSettingButton: false,
                  );
                }
              ));
            },
            child: SizedBox(
              height: size.height * 0.05,
              width: size.width * widthRatio,
              child: Row(
                children: [
                  CircleAvatar(
                    child:  snapshot.data!.iconImageUrl != ""
                      ? Image.network(snapshot.data!.iconImageUrl)
                      : const Icon(Icons.person),
                  ),
                  SizedBox(width: size.width * widthRatio * 0.1),
                  FittedBox(
                    child: Text(
                      snapshot.data!.name,
                      style: const TextStyle(fontSize: 240),
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