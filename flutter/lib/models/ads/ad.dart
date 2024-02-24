import 'package:cloud_firestore/cloud_firestore.dart';

const ADS_TABLE_COLLECTION_NAME = "ads";

enum AdTableColumn{
  AD_CREATER,
  AD_IMAGE_URL,
  AD_TITLE,
  AD_DETAIL,
  AD_TARGET_MONEY_AMOUNT,
  AD_TOTAL_MONEY_AMOUNT,
  AD_DEADLINE,
  AD_CREATERS,
  AD_TARGET_AIDOL,
  AD_TARGET_PLATFORM,
  AD_CATEGORY,
  AD_HASHTAG,
  AD_AIDERS,
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
  late final List<String> _creaters;
  late final String _targetIdol;
  late final List<String> _targetPlatform;
  late final List<String> _category;
  late final List<String> _hashtag;
  late final List<String> _aiders;
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
    required String targetIdol,
    required List<String> targetPlatform,
    required List<String> category,
    required List<String> hashtag,
    required List<String> aiders,
    required Timestamp created
  }){
    _creater = creater;
    _imageUrl = imageUrl;
    _title = title;
    _detail = detail;
    _totalMoneyAmount = totalMoneyAmount;
    _targetMoneyAmount = targetMoneyAmount;
    _deadline = Timestamp.fromDate(deadline);
    _creaters = creaters;
    _targetIdol = targetIdol;
    _targetPlatform = targetPlatform;
    _category = category;
    _hashtag = hashtag;
    _aiders = aiders;

    _created = created;

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
      AdTableColumn.AD_TARGET_AIDOL.name:_targetIdol,
      AdTableColumn.AD_TARGET_PLATFORM.name:_targetPlatform,
      AdTableColumn.AD_CATEGORY.name:_category,
      AdTableColumn.AD_HASHTAG.name:_hashtag,
      AdTableColumn.AD_AIDERS.name:_aiders,
      AdTableColumn.AD_CREATED.name:_created,
    };
  }

  factory Ad.fromMap(Map<String, dynamic> mapArg){
    return Ad(
      creater: mapArg[AdTableColumn.AD_CREATER.name], 
      imageUrl: mapArg[AdTableColumn.AD_IMAGE_URL.name], 
      title: mapArg[AdTableColumn.AD_TITLE.name], 
      detail: mapArg[AdTableColumn.AD_DETAIL.name], 
      totalMoneyAmount: mapArg[AdTableColumn.AD_TOTAL_MONEY_AMOUNT.name], 
      targetMoneyAmount: mapArg[AdTableColumn.AD_TARGET_MONEY_AMOUNT.name], 
      deadline: mapArg[AdTableColumn.AD_DEADLINE.name].toDate(),  
      creaters: mapArg[AdTableColumn.AD_CREATERS.name], 
      targetIdol: mapArg[AdTableColumn.AD_TARGET_AIDOL.name], 
      targetPlatform: mapArg[AdTableColumn.AD_TARGET_PLATFORM.name],
      category: mapArg[AdTableColumn.AD_CATEGORY.name], 
      hashtag: mapArg[AdTableColumn.AD_HASHTAG.name],
      aiders: mapArg[AdTableColumn.AD_AIDERS.name],
      created: mapArg[AdTableColumn.AD_CREATED.name]
    );
  }
}