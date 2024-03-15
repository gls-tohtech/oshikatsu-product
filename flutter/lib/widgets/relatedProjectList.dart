import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/widgets/relatedProjectListItem.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';

class RelatedProjectList extends ConsumerStatefulWidget {
  const RelatedProjectList({super.key});

  @override
  RelatedProjectListState createState() => RelatedProjectListState();
}

class RelatedProjectListState extends ConsumerState<RelatedProjectList> {
  final _userContoroller = UserController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StandartPaddingComponent(),
            for(var ref in _userContoroller.userProfile!.relatedProjects) RelatedProjectListItem(projectRef: ref)
          ],
        ),
      )
    );
  }
}