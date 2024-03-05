import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/projects/project.dart';
import 'package:oshikatsu_product/screens/fragments/projectDetailFragment/projectDetailAiderCom.dart';
import 'package:oshikatsu_product/screens/fragments/projectDetailFragment/projectDetailBorderCom.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';
import 'projectDetailBottomInfoCom.dart';
import 'projectDetailFooterCom.dart';
import 'projectDetailImgCom.dart';
import 'projectDetailTopInfoCom.dart';
import 'projectDetailTextCom.dart';

class ProjectDetailFragment extends StatelessWidget{
  late final Function() _bookmarkTapped;
  late final Project _project;

  ProjectDetailFragment({
    required Project project,
    required Function() bookmarkTapped,
  }){
    _project = project;
    _bookmarkTapped = bookmarkTapped;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProjectDetailImgComponent(
              _project.thumbnailUrl, 
              () => {
                Navigator.of(context).pop() 
              }
            ),
            StandartPaddingComponent(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Column(
                children: [
                  ProjectDetailTopInfoComponent(
                    title: _project.title,
                    hashtagList: _project.hashtags, 
                    targetMoneyAmount: _project.moneyGoal, 
                    totalMoneyAmount: _project.moneyDonated, 
                    aiderNumbers: _project.donaters.length, 
                    createrNumbers: _project.members.length, 
                    deadLine: _project.deadline
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.01)),
                  ProjectDetailTextComponent(
                    detailText: _project.discription
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.01)),
                  ProjectDetailBottomInfoComponent(
                    creater: _project.createdBy.toString(), 
                    platform: "", 
                    deadLine: _project.deadline
                  ),
                  ProjectDetailBorderComponent(),
                  StandartPaddingComponent(),
                  ProjectDetailAiderComponent(donaters: _project.donaters),
                  StandartPaddingComponent(),
                  ProjectDetailBorderComponent(),
                  ProjectDetailFooterComponent(
                    bookmarkTapped: _bookmarkTapped, 
                    project: _project,
                  ),
                  StandartPaddingComponent(),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
