import 'package:flutter/material.dart';
import 'package:oshikatsu_product/utils/showDialog.dart';

void validate(BuildContext context, Map<ValidateType, dynamic> targetValueMap){
  targetValueMap.forEach((ValidateType key, dynamic value) {
    if(isIncludeKeys(value, key.allowList)){
      showWarnDialog(
        context, 
        "${key.title}が無効な値、または入力されていない可能性があります。"
      );
    }
  });
}

enum ValidateType{
  EMAIL,
  PASSWORD,
  NUM,
  COMMON_STRING
}

extension ValidateTypeEx on ValidateType{
  String get allowList{
    switch(this){
      case ValidateType.EMAIL: {
        return "1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM.@";
      }
      case ValidateType.PASSWORD: {
        return "1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
      }
      case ValidateType.NUM: {
        return "1234567890";
      }
      case ValidateType.COMMON_STRING: {
        return "1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
      }
      default: {
        return "";
      }
    }
  }

  String get title {
    switch(this){
      case ValidateType.EMAIL: {
        return "メールアドレス";
      }
      case ValidateType.PASSWORD: {
        return "パスワード";
      }
      case ValidateType.NUM: {
        return "数値";
      }
      case ValidateType.COMMON_STRING: {
        return "文字列";
      }
      default: {
        return "";
      }
    }
  }
}

bool isIncludeKeys(String value, String keys){
  return !keys.split("").any((char) => value.contains(char));
}
