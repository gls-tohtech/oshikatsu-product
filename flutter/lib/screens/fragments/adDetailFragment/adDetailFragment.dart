import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';
import '../../../models/ads/ad.dart';
import 'adDetailAiderCom.dart';
import 'adDetailBorderCom.dart';
import 'adDetailBottomInfoCom.dart';
import 'adDetailFooterCom.dart';
import 'adDetailImgCom.dart';
import 'adDetailTopInfoCom.dart';
import 'adDetailTextCom.dart';

class AdDetailFragment extends StatelessWidget{
  late final String _title;
  late final String _adDetail;
  late final List<String> _hashtags;
  late final String _imageUrl;
  late final int _targetMoneyAmount;
  late final int _totalMoneyAmount;
  late final int _aiderNumbers;
  late final int _createrNumbers;
  late final String _createrUID;
  late final String _platform;
  late final Timestamp _deadLine;
  late final List<String> _aiders;
  late final List<String> _creaters;
  late final Function() _bookmarkTapped;
  late final Ad _ad;

  AdDetailFragment({
    required Ad ad,
    required Function() bookmarkTapped,
  }){
    _ad = ad;
    _createrUID = _ad.dbProcessedMap[AdTableColumn.AD_CREATER.name];
    _title = _ad.dbProcessedMap[AdTableColumn.AD_TITLE.name];
    _adDetail = _ad.dbProcessedMap[AdTableColumn.AD_DETAIL.name];
    _hashtags = _ad.dbProcessedMap[AdTableColumn.AD_HASHTAG.name].split(",");
    _imageUrl = _ad.dbProcessedMap[AdTableColumn.AD_IMAGE_URL.name];
    _targetMoneyAmount = _ad.dbProcessedMap[AdTableColumn.AD_TARGET_MONEY_AMOUNT.name];
    _totalMoneyAmount = _ad.dbProcessedMap[AdTableColumn.AD_TOTAL_MONEY_AMOUNT.name];
    _platform = _ad.dbProcessedMap[AdTableColumn.AD_TARGET_PLATFORM.name];
    _deadLine = _ad.dbProcessedMap[AdTableColumn.AD_DEADLINE.name];
    _creaters = _ad.dbProcessedMap[AdTableColumn.AD_CREATERS.name].split(",");;
    _createrNumbers = _ad.dbProcessedMap[AdTableColumn.AD_CREATERS.name].length;
    _aiders = _ad.dbProcessedMap[AdTableColumn.AD_AIDERS.name].split(",");;
    _aiderNumbers = _ad.dbProcessedMap[AdTableColumn.AD_AIDERS.name].length;
    _bookmarkTapped = bookmarkTapped;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AdDetailImgComponent(
              _imageUrl, 
              () => {
                Navigator.of(context).pop() 
              }
            ),
            StandartPaddingComponent(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Column(
                children: [
                  AdDetailTopInfoComponent(
                    title: _title,
                    hashtagList: _hashtags, 
                    targetMoneyAmount: _targetMoneyAmount, 
                    totalMoneyAmount: _totalMoneyAmount, 
                    aiderNumbers: _aiderNumbers, 
                    createrNumbers: _createrNumbers, 
                    deadLine: _deadLine
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.01)),
                  AdDetailTextComponent(
                    detailText: _adDetail
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.01)),
                  AdDetailBottomInfoComponent(
                    creater: _createrUID, 
                    platform: _platform, 
                    deadLine: _deadLine
                  ),
                  AdDetailBorderComponent(),
                  StandartPaddingComponent(),
                  AdDetailAiderComponent(aiders: _aiders),
                  StandartPaddingComponent(),
                  AdDetailBorderComponent(),
                  AdDetailFooterComponent(
                    bookmarkTapped: _bookmarkTapped, 
                    ad: _ad,
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
