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

  final UserRegistry _registry = UserRegistry();
  final UserDataFetcher _fetcher = UserDataFetcher();

  UserAuthentifier? _auth;
  UserAuthInfo? _userAuthInfo;
  UserProfile? _userProfile;
  UserStoreInfo? _userStoreInfo;
  User? _user;

  bool _isAccountCreated = false;

  bool get isLogin => _auth!.isLogin;
  String get uid => _userStoreInfo!.uid;

  Future createUserWithEmailAndPassWord({required UserAuthInfo userAuthInfo, required UserProfile userProfile}) async {
    _userAuthInfo = userAuthInfo;
    _userProfile = userProfile;
    _auth = UserAuthentifier(_userAuthInfo!);

    _user = await _auth!.createUserWithEmailAndPassWord();
    _createChatCoreUserAccount();

    _isAccountCreated = true;

    _userStoreInfo = UserStoreInfo(uidArg: _user!.uid, profileArg: _userProfile!);
    _addToStore();
  }

  Future signInWithEmailAndPassWord({required UserAuthInfo userAuthInfo}) async { 
    _userAuthInfo = userAuthInfo;
    
    _auth = UserAuthentifier(_userAuthInfo!);
    _user = await _auth!.signInWithEmailAndPassWord();

    final UserProfile? userProfile = await _fetchUserProfileFromStore();
    if(userProfile != null) _userProfile = userProfile;

    if(_user == null) {
      print("_user variable is null in createUserWithEmailAndPassWord method of userController class");
      return;
    }
    await _fetchUserProfileFromStore();
    _userStoreInfo = UserStoreInfo(uidArg: _user!.uid, profileArg: _userProfile!);
  }

  Future<void> _createChatCoreUserAccount() async {
    try{
      final String? iconImageUrl = _userProfile!.dbProcessedMap[UserTableColumn.ICON_IMAGE_URL.name] != ""
        ? _userProfile!.dbProcessedMap[UserTableColumn.ICON_IMAGE_URL.name]
        : null;
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: _userProfile!.dbProcessedMap[UserTableColumn.NAME.name],
          id: _user!.uid,
          lastName: "",
          imageUrl: iconImageUrl
        ),
      );
    }
    catch(e){
      print("Failed to create user account of FirebaseChatCore in createChatCoreUserAccount method of userController class");
    }
  }

  void sendPasswordResetEmail() async {
    _auth!.sendPasswordResetEmail();
  }

  void signOut(){
    if(!isLogin) return;
    _auth!.signOut();
  } 

  void _addToStore() { 
    if(!_isAccountCreated) return;
    _registry.add(newUserDataArg: _userStoreInfo!);
  }

  void updateToStore(UserStoreInfo newUserDataArg) {
    if(!isLogin) return;
    _registry.update(newUserDataArg: newUserDataArg);
  }

  Future<UserProfile?> _fetchUserProfileFromStore() async {
    if(!isLogin) return null;
    if(_user!.uid == "") return null;
    UserProfile fetchedData = await _fetcher.fetchUserProfile(targetUidArg: _user!.uid);
    return fetchedData;
  }
}
