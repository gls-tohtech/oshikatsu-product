extension FormatIntToSixDigits on int{
  String get formatIntToSixDigits{
    String numberStr = toString();
    
    if (numberStr.length > 6) {
    numberStr = numberStr.substring(numberStr.length - 6);
    }

    while (numberStr.length < 6) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }
}
