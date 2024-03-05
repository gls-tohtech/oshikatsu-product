import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
            
        //for(var ele in _donaters) buildAider(context, ele)
      ],
    );
  }

  Widget buildAider(BuildContext context, String aiderArg){
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.001),
      child: Text(aiderArg),
    );
  }
}