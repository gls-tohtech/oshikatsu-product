import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

enum AdTableColumn{
  AD_CREATER,
  AD_IMAGE_URL,
  AD_TITLE,
  AD_DETAIL,
  AD_TARGET_MONEY_AMOUNT,
  AD_TOTAL_MONEY_AMOUNT,
  AD_DEADLINE,
  AD_CREATERS,
  AD_CREATER_NUMBERS,
  AD_TARGET_AIDOL,
  AD_TARGET_PLATFORM,
  AD_CATEGORY,
  AD_HASHTAG,
  AD_AIDERS,
  AD_AIDER_NUMBERS,
  AD_CREATED,
}

class Ad{
  late final String _adId;

  late final String _creater;
  late final String _imageUrl;
  late final String _title;
  late final String _detail;
  late final int _targetMoneyAmount;
  late final int _totalMoneyAmount;
  late final Timestamp _deadline;
  late final String _creaters;
  late final int _createrNumbers;
  late final String _targetIdol;
  late final String _targetPlatform;
  late final String _category;
  late final String _hashtag;
  late final String _aiders;
  late final int _aiderNumbers;
  late final Timestamp _created;

  late Map<String, dynamic> _dbProcessedMap;

  String get adId => _adId;
  Map<String, dynamic> get dbProcessedMap => _dbProcessedMap; 

  Ad({
    required String creater,
    required String imageUrl,
    required String title,
    required String detail,
    required int totalMoneyAmount,
    required int targetMoneyAmount,
    required DateTime deadline,
    required List<String> creaters,
    required int createrNumbers,
    required String targetIdol,
    required String targetPlatform,
    required List<String> category,
    required List<String> hashtag,
    required List<String> aiders,
    required int aiderNumbers
  }){
    _creater = creater;
    _imageUrl = imageUrl;
    _title = title;
    _detail = detail;
    _totalMoneyAmount = totalMoneyAmount;
    _targetMoneyAmount = targetMoneyAmount;
    _deadline = Timestamp.fromDate(deadline);
    _creaters = creaters.join(",");
    _createrNumbers = createrNumbers;
    _targetIdol = targetIdol;
    _targetPlatform = targetPlatform;
    _category = category.join(",");
    _hashtag = hashtag.join(",");
    _aiders = aiders.join(",");
    _aiderNumbers = aiderNumbers;

    _created = Timestamp.now();

    _adId = "$_creater:$_title:${_created.toString()}";

    _dbProcessedMap = _createDbProcessedMap();
  } 

  Map<String, dynamic> _createDbProcessedMap(){
    return {
      AdTableColumn.AD_CREATER.name:_creater,
      AdTableColumn.AD_IMAGE_URL.name:_imageUrl,
      AdTableColumn.AD_TITLE.name:_title,
      AdTableColumn.AD_DETAIL.name:_detail,
      AdTableColumn.AD_TARGET_MONEY_AMOUNT.name:_targetMoneyAmount,
      AdTableColumn.AD_TOTAL_MONEY_AMOUNT.name:_totalMoneyAmount,
      AdTableColumn.AD_DEADLINE.name:_deadline,
      AdTableColumn.AD_CREATERS.name:_creaters,
      AdTableColumn.AD_CREATER_NUMBERS.name:_createrNumbers,
      AdTableColumn.AD_TARGET_AIDOL.name:_targetIdol,
      AdTableColumn.AD_TARGET_PLATFORM.name:_targetPlatform,
      AdTableColumn.AD_CATEGORY.name:_category,
      AdTableColumn.AD_HASHTAG.name:_hashtag,
      AdTableColumn.AD_AIDERS.name:_aiders,
      AdTableColumn.AD_AIDER_NUMBERS.name:_aiderNumbers,
      AdTableColumn.AD_CREATED.name:_created,
    };
  }
}