import 'package:oshikatsu_product/utils/result.dart';
import 'package:oshikatsu_product/utils/validate/validate.dart';

abstract class ValidateType{
  RegExp get allowRegExp => RegExp(r'.*');
  int get allowRangeStart => 0;
  int get allowRangeEnd => 256;
  String get letterTypeMessage;
  String get title;

  Result<String> isMatchedAllowRange(Validate target){
    if(target.value.length > allowRangeEnd){
      return Result<String>(
        isOk: false,
        value: "$titleの文字数は$allowRangeEnd字より少なくしてください。\n"
      );
    }
    else if(target.value.length < allowRangeStart){
      return Result<String>(
        isOk: false,
        value: "$titleの文字数は$allowRangeStart字より多くしてください。\n"
      );
    }
    else{
      return Result(isOk: true);
    }
  }
}

class AddressValidateType extends ValidateType{
  @override
  RegExp get allowRegExp => RegExp('.*@.*');

  @override
  String get letterTypeMessage => "半角英数字(大文字、小文字)、@、ドット";

  @override
  String get title => "メールアドレス";
}

class PasswordValidateType extends ValidateType{
  @override
  // ignore: valid_regexps
  RegExp get allowRegExp => RegExp(r'^[a-zA-Z0-9!"#$%&()*+,-./:;<=>?@[\]^_`{|}~]{8,24}');

  @override
  int get allowRangeStart => 8;

  @override
  int get allowRangeEnd => 24;

  @override
  String get letterTypeMessage => "半角英数字(大文字、小文字)、記号で$allowRangeStart文字以上$allowRangeEnd文字以下";

  @override
  String get title => "パスワード";
}

class StringValidateType extends ValidateType{
  @override
  String get letterTypeMessage => "";

  @override
  String get title => "文字列";
}
