extension FormatIntToAnyDigits on int{
  String formatIntToAnyDigits(int digit) {
    String numberStr = toString();
    
    if (numberStr.length > digit) {
    numberStr = numberStr.substring(numberStr.length - digit);
    }

    while (numberStr.length < digit) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }
}
