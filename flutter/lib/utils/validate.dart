import 'package:flutter/material.dart';
import 'package:oshikatsu_product/utils/showDialog.dart';

bool isNotIncludeInvalidValue(BuildContext context, Validate target){
  List<String> invalidCharList = getInvalidValue(target.value.toString(), target.validateType.allowListStr);
  if(isIncludeKeys(target.value.toString(), target.validateType.allowListStr)){
    showWarnDialog(
      context, 
      invalidCharList.isEmpty
        ? "${target.validateType.title}が入力されていません。"
        : "無効な値 $invalidCharList を使用しています。\n使用可能な値は、\n${target.validateType.allowRange}\nです。"
    );

    return false;
  }

  return true;
}

abstract class ValidateType{
  String get allowListStr;
  String get allowRange;
  String get title;
}

class AddressValidateType extends ValidateType{
  @override
  String get allowListStr => "1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM.@";

  @override
  String get allowRange => "半角英数字(大文字、小文字)、@、ドット";

  @override
  String get title => "メールアドレス";
}

class PasswordValidateType extends ValidateType{
  @override
  String get allowListStr => "1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";

  @override
  String get allowRange => "半角英数字(大文字、小文字)";

  @override
  String get title => "パスワード";

}

bool isIncludeKeys(String value, String keys){
  return !keys.split("").any((char) => value.contains(char));
}

List<String> getInvalidValue(String value, String keys){
  String invalidValue = value.replaceAll(RegExp('[$keys]'), '');
  return invalidValue.split("");
}

class Validate{
  final String value;
  final ValidateType validateType;

  const Validate({
    required this.value,
    required this.validateType,
  });
}
