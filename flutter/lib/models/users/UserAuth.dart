import 'package:firebase_auth/firebase_auth.dart';
import './UserAuthInfo.dart';

class UserAuthentifier{
  final AUTH = FirebaseAuth.instance;
  final _UserAuthController _userAuthController = _UserAuthController();

  late final UserAuthInfo _userAuthInfo;

  bool _isLogin = false;

  bool get isLogin => _isLogin;

  UserAuthentifier(this._userAuthInfo){
    if(_userAuthInfo.email == "" || _userAuthInfo.password == ""){
      throw Exception(
        "non-exist property in _userAuthInfo, email:[${_userAuthInfo.email}] - password:[${_userAuthInfo.password}]"
      );
    }
  }

  Future<User?> createUserWithEmailAndPassWord() async {
    return await _userAuthController.createUserWithEmailAndPassWord(_userAuthInfo);
  }

  Future<User?> signInWithEmailAndPassWord() async {
    final User? user = await _userAuthController.signInWithEmailAndPassWord(_userAuthInfo);
    if(user != null) _isLogin = true;
    return user;
  }

  void signOut() async {
    _userAuthController.signOut();
    _isLogin = false;
  }

  void sendPasswordResetEmail() async{
    _userAuthController.sendPasswordResetEmail(_userAuthInfo);
  }
}

class _UserAuthController{
  final AUTH = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassWord(UserAuthInfo userAuthInfoArg) async {
    try{
        final User? user = (
        await AUTH.createUserWithEmailAndPassword(
          email: userAuthInfoArg.email, 
          password: userAuthInfoArg.password
        )
      ).user;

      return user;
    }
    catch(e){
      print(e);
    }
  }

  Future<User?> signInWithEmailAndPassWord(UserAuthInfo userAuthInfoArg) async {
    try{
        final User? user = (
        await AUTH.signInWithEmailAndPassword(
          email: userAuthInfoArg.email, 
          password: userAuthInfoArg.password
        )
      ).user;

      return user;
    }
    catch(e){
      print(e);
    }
  }

  void signOut() async {
    await AUTH.signOut();
  }

  void sendPasswordResetEmail(UserAuthInfo userAuthInfoArg) async{
    try{
      await AUTH.sendPasswordResetEmail(
        email: userAuthInfoArg.email
      );
      print("パスワードリセット用のメールを送信しました");
    }
    catch(e){
      print(e);
    }
  }
}

