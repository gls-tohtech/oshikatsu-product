import 'package:flutter/material.dart';
import 'package:oshikatsu_product/utils/result.dart';
import 'package:oshikatsu_product/utils/showDialog.dart';
import 'package:oshikatsu_product/utils/validate/validateType.dart';

Result checkValidate(BuildContext context, Validate target){
  Result<String> result = _checkValidate(target);
  if(result.isOk){
    return Result(isOk: true);
  }
  else{
    showWarnDialog(
      context, 
      result.value!
    );
    return Result<String>(
      isOk: false,
      value: result.value
    );
  }
}

Result<String> _checkValidate(Validate target){
  Result<String> result = target.errorResult;
  if(result.isOk){
    return Result(isOk: true);
  }
  else{
    return Result<String>(
      isOk: false,
      value: result.value
    );
  }
}

Result<List<String>> _isNotContainsInvalidValue(Validate target){
  String invalidValue = target.value.replaceAll(target.validateType.allowRegExp, '');
  List<String> invalidValueList = invalidValue.split("");

  final result = target.validateType.isMatchedAllowRange(target);
  if(!result.isOk) return Result(isOk: true);

  if(invalidValue.isEmpty){
    return Result(isOk: true);
  }
  else{
    return Result(
      isOk: false,
      value: invalidValueList
    );
  }
}

class Validate{
  final String value;
  final ValidateType validateType;

  const Validate({
    required this.value,
    required this.validateType,
  });
}

extension ValidateErrorMessage on Validate{
  Result<String> get isNotEnteredValue {
    if(value != ""){
      return Result(isOk: true);
    }
    else{
      return Result(
        isOk: false,
        value: "${validateType.title}が入力されていません。\n"
      );
    }
  }

  Result<String> get isNotContainsInvalidValue {
    Result<List<String>> result = _isNotContainsInvalidValue(this);
    if(result.isOk){
      return Result(isOk: true);
    }
    else{
      return Result(
        isOk: false,
        value: "無効な値 ${result.value} を使用しています。\n使用可能な値は、\n${validateType.letterTypeMessage}です。\n"
      );
    }
  }

  Result<String> get isMatchedAddress {
    if(validateType is! AddressValidateType) return Result(isOk: true);
    if(validateType.allowRegExp.hasMatch(value)){
      return Result(isOk: true);
    }
    else{
      return Result(
        isOk: false,
        value: "入力された値がメールアドレスの形式ではありません。\n"
      );
    }
  }

  Result<String> get errorResult {
    String errorMessage = "";

    Result result = isNotEnteredValue;
    if(!result.isOk) errorMessage += result.value;

    result = isMatchedAddress;
    if(!result.isOk) errorMessage += result.value;

    result = validateType.isMatchedAllowRange(this);
    if(!result.isOk) errorMessage += result.value;

    result = isNotContainsInvalidValue;
    if(!result.isOk) errorMessage += result.value;

    if(errorMessage == ""){
      return Result(isOk: true);
    }
    else{
      return Result<String>(
        isOk: false,
        value: errorMessage
      );
    }
  }
}
