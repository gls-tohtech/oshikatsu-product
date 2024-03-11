import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/screens/fragments/projectDetailFragment/projectDetailBorderCom.dart';
import 'package:oshikatsu_product/widgets/userProfile.dart';
import 'package:oshikatsu_product/widgets/userProfileLabel.dart';

class ProjectDetailBottomInfoComponent extends StatelessWidget{
  late final DocumentReference _createrRef;
  late final String _platform;
  late final Timestamp _deadLine;

  ProjectDetailBottomInfoComponent({
    required DocumentReference createrRef,
    required String platform,
    required Timestamp deadLine,
  }){
    _createrRef = createrRef;
    _platform = platform;
    _deadLine = deadLine;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "広告情報",
                textScaler: TextScaler.linear(1.5),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ProjectDetailBorderComponent(),
            buildInfo(context),
          ],
        ),
      ],
    );
  }

  Widget buildInfo(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.015)),
            SizedBox(
              width: size.width * 0.4,
              child: const Text(
                "作成者",
              ),
            ),
            SizedBox(
              child: UserProfileLabelComponent(userRef: _createrRef, widthRatio: 0.5)
            ),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        Row(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.015)),
            SizedBox(
              width: size.width * 0.4,
              child: const Text("掲載場所"),
            ),
            //Text(_platform)
            const Text("X")
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
        Row(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.015)),
            SizedBox(
              width: size.width * 0.4,
              child: const Text("広告掲載までの日時"),
            ),
            Text("${_deadLine.toDate().year}  年   ${_deadLine.toDate().month}  月   ${_deadLine.toDate().day}  日")
          ],
        ),
      ],
    );
  }
}