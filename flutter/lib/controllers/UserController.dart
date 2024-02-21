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

  Future createUserWithEmailAndPassWord({required UserAuthInfo userAuthInfo, required UserProfile userProfile}) async {
    _userAuthInfo = userAuthInfo;
    _auth = UserAuthentifier(_userAuthInfo);

    await _auth.createUserWithEmailAndPassWord();
    _addToStore();
  }

  Future signInWithEmailAndPassWord({required UserAuthInfo userAuthInfo}) async { 
    _auth = UserAuthentifier(_userAuthInfo);
    _user ??= await _auth.signInWithEmailAndPassWord();
    if(_user == null) {
      print("_user variable is null in createUserWithEmailAndPassWord method of userController class");
      return;
    }
    await _fetchUserDataFromStore();
    _userStoreInfo = UserStoreInfo(uidArg: _user.uid, profileArg: _userProfile);
  }

  Future<void> createChatCoreUserAccount() async {
    try{
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: _userProfile.dbProcessedMap[UserTableColumn.NAME.name],
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

  void _addToStore() { 
    if(!isLogin) return;
    _resistry.add(newUserDataArg: _userStoreInfo);
  }

  void updateToStore(UserStoreInfo newUserDataArg, UserTableColumn columnArg) {
    if(!isLogin) return;
    _resistry.update(newUserDataArg: newUserDataArg, columnArg: columnArg);
  }

  Future<void> _fetchUserDataFromStore() async {
    if(!isLogin) return;
    if(_userStoreInfo.uid == "") return;
    Map<String, dynamic> fetchedData = await _fetcher.fetch(targetUidArg: _userStoreInfo.uid);
    _userProfile = UserProfile.fromMap(fetchedData);
  }
}