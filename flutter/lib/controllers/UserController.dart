import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import '../models/users/UserAuthInfo.dart';
import '../models/users/UserAuth.dart';
import '../models/users/Users.dart';
import '../models/users/UserProfile.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class UserController{
  UserController._();

  static UserController? _instance;

  factory UserController(){
    _instance ??= UserController._();
    return _instance!;
  }

  late final UserAuthentifier _auth;
  final UserResistry _resistry = UserResistry();
  late final UserDataFetcher _fetcher;

  late final UserAuthInfo _userAuthInfo;
  late final UserProfile _userProfile;
  late final UserStoreInfo _userStoreInfo;
  late final User? _user;

  bool get isLogin => _auth.isLogin;
  String get uid => _userStoreInfo.uid;

  void setUserInfo({required UserAuthInfo userAuthInfo, required UserProfile userProfile}){
    _userAuthInfo = userAuthInfo;
    _userProfile = userProfile;

    _auth = UserAuthentifier(_userAuthInfo);
  }

  void createUserWithEmailAndPassWord() async {
    await _auth.createUserWithEmailAndPassWord();
  }

  Future signInWithEmailAndPassWord() async { 
    _user = await _auth.signInWithEmailAndPassWord();
    if(_user == null) {
      print("_user variable is null in createUserWithEmailAndPassWord method of userController class");
      return;
    }
    
    _userStoreInfo = UserStoreInfo(uidArg: _user.uid, profileArg: _userProfile);
  }

  Future createChatCoreUserAccount(String userName) async {
    try{
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: userName,
          id: uid,
          lastName: "",
        ),
      );
    }
    catch(e){
      print("Failed to create user account of FirebaseChatCore in createChatCoreUserAccount method of userController class");
    }
  }

  void sendPasswordResetEmail() async {
    _auth.sendPasswordResetEmail();
  }

  void signOut(){
    if(!isLogin) return;
    _auth.signOut();
  } 

  void addToStore() { 
    if(!isLogin) return;
    _resistry.add(newUserDataArg: _userStoreInfo);
  }

  void updateToStore(UserStoreInfo newUserDataArg, UserTableColumn columnArg) {
    if(!isLogin) return;
    _resistry.update(newUserDataArg: newUserDataArg, columnArg: columnArg);
  }

  ///Mapデータを取得するときは、取得した変数[UsersTableColumn.カラム名（データベースの項目名）.name]と記述する。
  void fetchFromStore(){
    if(!isLogin) return;
    if(_userStoreInfo.uid == "") return;
    _fetcher.fetch(targetUidArg: _userStoreInfo.uid);
  }
}