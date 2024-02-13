import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ads/ad.dart';
import '../models/ads/adStore.dart';
import '../models/ads/adStorage.dart';

class AdController{
  final AdResistry _resistry = AdResistry();
  final AdDataFetcher _fetcher = AdDataFetcher();
  final AdImageUploader _uploader = AdImageUploader();

  Future<String> pickImageAndUpload() async {
    final String imageUrl = await _uploader.uploadImageAndFetchUrl() ?? "";
    return imageUrl;
  }

  Future<void> addToStorage({required Ad newAdDataArg}) async {
    _resistry.add(newAdData: newAdDataArg);
  }

  Future<void> updateTotalMoneyAmount({required Ad existedAdInfo, required String aiderName, required int additionalMoney}) async {
    List<String> aiders = existedAdInfo.dbProcessedMap[AdTableColumn.AD_AIDERS.name].split(",");;
    if (!aiders.contains(aiderName)) aiders.add(aiderName);
    
    final Ad newAdInfo = Ad(
      creater: existedAdInfo.dbProcessedMap[AdTableColumn.AD_CREATER.name], 
      imageUrl: existedAdInfo.dbProcessedMap[AdTableColumn.AD_IMAGE_URL.name], 
      title: existedAdInfo.dbProcessedMap[AdTableColumn.AD_TITLE.name], 
      detail: existedAdInfo.dbProcessedMap[AdTableColumn.AD_DETAIL.name], 
      totalMoneyAmount: existedAdInfo.dbProcessedMap[AdTableColumn.AD_TOTAL_MONEY_AMOUNT.name] + additionalMoney, 
      targetMoneyAmount: existedAdInfo.dbProcessedMap[AdTableColumn.AD_TARGET_MONEY_AMOUNT.name], 
      deadline: existedAdInfo.dbProcessedMap[AdTableColumn.AD_DEADLINE.name].toDate(), 
      creaters: existedAdInfo.dbProcessedMap[AdTableColumn.AD_CREATERS.name].split(","), 
      targetIdol: existedAdInfo.dbProcessedMap[AdTableColumn.AD_TARGET_AIDOL.name], 
      targetPlatform: existedAdInfo.dbProcessedMap[AdTableColumn.AD_TARGET_PLATFORM.name],
      category: existedAdInfo.dbProcessedMap[AdTableColumn.AD_CATEGORY.name].split(","), 
      hashtag: existedAdInfo.dbProcessedMap[AdTableColumn.AD_HASHTAG.name].split(","),
      aiders: aiders,
      created: existedAdInfo.dbProcessedMap[AdTableColumn.AD_CREATED.name]
    );

    _resistry.update(newAdData: newAdInfo);
  }

  Future<void> fetchFromStorage({required String adId}) async {
    _fetcher.fetch(targetAdId: adId);
  }
}