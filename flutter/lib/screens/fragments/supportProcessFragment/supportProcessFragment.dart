import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/ads/ad.dart';
import 'package:oshikatsu_product/widgets/termOfService.dart';
import 'spBorderCom.dart';
import 'spContentsCom.dart';
import 'spImgCom.dart';

class SupportProcessFragment extends StatelessWidget{
  late final Ad _ad;
  late final String _title;
  late final String _imageUrl;

  SupportProcessFragment({
    required Ad ad
  }){
    _ad = ad;
    _title = _ad.dbProcessedMap[AdTableColumn.AD_TITLE.name];
    _imageUrl = _ad.dbProcessedMap[AdTableColumn.AD_IMAGE_URL.name];
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
              buildHeader(context),
              SpBorderComponent(),
              Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.01)),
              SPImgComponent(
                imageUrl: _imageUrl,
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.01)),
              SpContentsComponent(
                ad: _ad
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