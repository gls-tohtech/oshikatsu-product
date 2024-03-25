import 'package:firebase_auth/firebase_auth.dart';
import 'package:oshikatsu_product/utils/result.dart';
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

  Future<Result<User?>> createUserWithEmailAndPassWord() async {
    return await _userAuthController.createUserWithEmailAndPassWord(_userAuthInfo);
  }

  Future<Result<User?>> signInWithEmailAndPassWord() async {
    final Result<User?> user = await _userAuthController.signInWithEmailAndPassWord(_userAuthInfo);
    if(user.isOk) _isLogin = true;
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

  Future<Result<User?>> createUserWithEmailAndPassWord(UserAuthInfo userAuthInfoArg) async {
    try{
        final User? user = (
        await AUTH.createUserWithEmailAndPassword(
          email: userAuthInfoArg.email, 
          password: userAuthInfoArg.password
        )
      ).user;

      return Result<User?>(
        isOk: true,
        value: user
      );
    }
    catch(e){
      return Result(
        isOk: false,
        executedMessage: e.toString()
      );
    }
  }

  Future<Result<User?>> signInWithEmailAndPassWord(UserAuthInfo userAuthInfoArg) async {
    try{
        final User? user = (
        await AUTH.signInWithEmailAndPassword(
          email: userAuthInfoArg.email, 
          password: userAuthInfoArg.password
        )
      ).user;

      return Result<User?>(
        isOk: true,
        value: user
      );
    }
    catch(e){
      return Result(
        isOk: false,
        executedMessage: e.toString()
      );
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

