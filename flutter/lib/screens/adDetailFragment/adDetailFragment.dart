import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/ad.dart';
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
  late final Function() _movePreviousButtonTapped;
  late final Function() _bookmarkTapped;
  late final Function() _moveSupportUIButtonTapped;
  late final Ad _adInfo;

  AdDetailFragment({
    required Ad adInfo,
    required Function() movePreviousButtonTapped,
    required Function() bookmarkTapped,
    required Function() moveSupportUIButtonTapped,
  }){
    _adInfo = adInfo;
    _createrUID = _adInfo.dbProcessedMap[AdTableColumn.AD_CREATER.name];
    _title = _adInfo.dbProcessedMap[AdTableColumn.AD_TITLE.name];
    _adDetail = _adInfo.dbProcessedMap[AdTableColumn.AD_DETAIL.name];
    _hashtags = _adInfo.dbProcessedMap[AdTableColumn.AD_HASHTAG.name];
    _imageUrl = _adInfo.dbProcessedMap[AdTableColumn.AD_IMAGE_URL.name];
    _targetMoneyAmount = _adInfo.dbProcessedMap[AdTableColumn.AD_TARGET_MONEY_AMOUNT.name];
    _totalMoneyAmount = _adInfo.dbProcessedMap[AdTableColumn.AD_TOTAL_MONEY_AMOUNT.name];
    _platform = _adInfo.dbProcessedMap[AdTableColumn.AD_TARGET_PLATFORM.name];
    _deadLine = _adInfo.dbProcessedMap[AdTableColumn.AD_DEADLINE.name];
    _creaters = _adInfo.dbProcessedMap[AdTableColumn.AD_CREATERS.name];
    _createrNumbers = _adInfo.dbProcessedMap[AdTableColumn.AD_CREATER_NUMBERS.name];
    _aiders = _adInfo.dbProcessedMap[AdTableColumn.AD_AIDERS.name];
    _aiderNumbers = _adInfo.dbProcessedMap[AdTableColumn.AD_AIDER_NUMBERS.name];
    _moveSupportUIButtonTapped = movePreviousButtonTapped;
    _bookmarkTapped = bookmarkTapped;
    _moveSupportUIButtonTapped = moveSupportUIButtonTapped;
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          AdDetailImgComponent(_imageUrl, _movePreviousButtonTapped),
          Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
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
                  deadLine: Timestamp.now()
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
                Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
                AdDetailAiderComponent(aiders: _aiders),
                Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
                AdDetailBorderComponent(),
                AdDetailFooterComponent(
                  bookmarkTapped: _bookmarkTapped, 
                  moveSupportUIButtonTapped: _moveSupportUIButtonTapped
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: size.height * 0.005)),
              ],
            )
          ),
        ],
      ),
    );
  }
}
