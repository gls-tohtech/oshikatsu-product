import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/models/users/UserStore.dart';
import 'package:oshikatsu_product/widgets/relatedProjectListItem.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';

class RelatedProjectList extends ConsumerStatefulWidget {
  final DocumentReference userRef;
  const RelatedProjectList({super.key, required this.userRef});

  @override
  RelatedProjectListState createState() => RelatedProjectListState();
}

class RelatedProjectListState extends ConsumerState<RelatedProjectList> {
  final _userContoroller = UserController();
  final _fetcher = UserDataFetcher();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _fetcher.fetchUserProfileFromRef(userRef: widget.userRef), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // ローディング表示
            } else if (snapshot.hasError) {
              return const Center(child: Text('エラーが発生しました')); // エラーハンドリング
            } else {
              return Column(
                children: [
                  StandartPaddingComponent(),
                  for(var ref in snapshot.data!.relatedProjects) RelatedProjectListItem(projectRef: ref)
                ],
              );
            }
          }
        ),
      )
    );
  }
}