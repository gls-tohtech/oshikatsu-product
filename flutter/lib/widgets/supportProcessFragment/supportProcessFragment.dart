import 'package:flutter/material.dart';
import 'spBorderCom.dart';
import 'spContentsCom.dart';
import 'spImgCom.dart';
import 'spTermOfServiceCom.dart';

class SupportProcessFragment extends StatelessWidget{
  late final String _title;
  late final String _imageUrl;

  SupportProcessFragment({
    required String title,
    required String imageUrl
  }){
    _title = title;
    _imageUrl = imageUrl;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: [
            buildHeader(context),
            SpBorderComponent(),
            Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.01)),
            SPImgComponent(
              imageUrl: _imageUrl,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.01)),
            SpContentsComponent(
              title: _title
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.01)),
            SpBorderComponent(),
            SPTermOfServiceComponent()
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: size.height * 0.01),
            child: const Text(
              "応援の手続き",
              textScaler: TextScaler.linear(1.5),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ),
        Align(
          alignment: Alignment.centerRight,
          child:  IconButton(
            onPressed: () => { 
              Navigator.of(context).pop(),
            }, 
            icon: const Icon(Icons.close)
          ),
        )
      ],
    );
  }
}