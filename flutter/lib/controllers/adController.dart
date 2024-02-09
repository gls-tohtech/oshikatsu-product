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

  Future<void> updateTotalMoneyAmount({required int additionalMoney, required Ad existedAdInfo}) async {
    final Ad newAdInfo = Ad(
      creater: existedAdInfo.dbProcessedMap[AdTableColumn.AD_CREATER.name], 
      imageUrl: existedAdInfo.dbProcessedMap[AdTableColumn.AD_IMAGE_URL.name], 
      title: existedAdInfo.dbProcessedMap[AdTableColumn.AD_TITLE.name], 
      detail: existedAdInfo.dbProcessedMap[AdTableColumn.AD_DETAIL.name], 
      totalMoneyAmount: existedAdInfo.dbProcessedMap[AdTableColumn.AD_TARGET_MONEY_AMOUNT.name] + additionalMoney, 
      targetMoneyAmount: existedAdInfo.dbProcessedMap[AdTableColumn.AD_TOTAL_MONEY_AMOUNT.name], 
      deadline: existedAdInfo.dbProcessedMap[AdTableColumn.AD_DEADLINE.name], 
      creaters: existedAdInfo.dbProcessedMap[AdTableColumn.AD_CREATERS.name], 
      targetIdol: existedAdInfo.dbProcessedMap[AdTableColumn.AD_TARGET_AIDOL.name], 
      targetPlatform: existedAdInfo.dbProcessedMap[AdTableColumn.AD_TARGET_PLATFORM],
      category: existedAdInfo.dbProcessedMap[AdTableColumn.AD_CATEGORY], 
      hashtag: existedAdInfo.dbProcessedMap[AdTableColumn.AD_HASHTAG],
      aiders: existedAdInfo.dbProcessedMap[AdTableColumn.AD_AIDERS.name]
    );

    _resistry.update(newAdData: newAdInfo, column: AdTableColumn.AD_TOTAL_MONEY_AMOUNT);
  }

  Future<void> fetchFromStorage({required String adId}) async {
    _fetcher.fetch(targetAdId: adId);
  }
}