import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oshikatsu_product/screens/fragments/projectDetailFragment/projectDetailBorderCom.dart';

class ProjectDetailBottomInfoComponent extends StatelessWidget{
  late final String _creater;
  late final String _platform;
  late final Timestamp _deadLine;


  ProjectDetailBottomInfoComponent({
    required String creater,
    required String platform,
    required Timestamp deadLine,
  }){
    _creater = creater;
    _platform = platform;
    _deadLine = deadLine;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Column(
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
              child: const Text("作成者"),
            ),
            Text(_creater)
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
            Text(_platform)
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