class UserAuthInfo{
  late final String _email;
  late final String _password;

  String get email => _email;
  String get password => _password;

  UserAuthInfo(String emailArg, String passwordArg){
    _email = emailArg;
    _password = passwordArg;
  }

  void validate(String emailArg, String passwordArg){

  }
}