import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/projects/project.dart';
import 'package:oshikatsu_product/widgets/termOfService.dart';
import 'package:oshikatsu_product/widgets/topPadding.dart';
import 'spBorderCom.dart';
import 'spContentsCom.dart';
import 'spImgCom.dart';

class SupportProcessFragment extends StatelessWidget{
  late final Project _project;

  SupportProcessFragment({
    required Project project
  }){
    _project = project;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Column(
            children: [
              TopPaddingComponent(),
              buildHeader(context),
              SpBorderComponent(),
              Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.01)),
              SPImgComponent(
                imageUrl: _project.thumbnailUrl,
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.01)),
              SpContentsComponent(
                project: _project
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.01)),
              SpBorderComponent(),
              TermOfServiceComponent()
            ],
          ),
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