class Result<T>{
  final bool isOk;
  final T? value;
  final String executedMessage;
 
  Result({
    required this.isOk,
    this.value,
    this.executedMessage = ""
  });
}
