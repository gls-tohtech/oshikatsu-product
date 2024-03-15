import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oshikatsu_product/widgets/userProfileLabel.dart';

class ProjectDetailAiderComponent extends StatelessWidget{
  late final List<DocumentReference> _donaters;

  ProjectDetailAiderComponent({
    required List<DocumentReference> donaters
  }){
    _donaters = donaters;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.015)),
            SizedBox(
              width: size.width * 0.2,
              child: const Text("応援者"),
            ),
            
        for(DocumentReference userRef in _donaters) UserProfileLabelComponent(userRef: userRef, widthRatio: 0.4)
      ],
    );
  }
}