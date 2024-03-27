import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:oshikatsu_product/models/users/roomUser.dart';
import 'package:oshikatsu_product/settings/tables.dart';
import 'package:oshikatsu_product/utils/result.dart';
import '../models/users/UserAuthInfo.dart';
import '../models/users/UserAuth.dart';
import '../models/users/UserStore.dart';
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
  RoomUser? _roomUser;
  User? _user;

  bool _isAccountCreated = false;

  bool get isLogin => _auth != null ? _auth!.isLogin : false;
  String? get uid => _userStoreInfo != null ? _userStoreInfo!.uid : "";
  DocumentReference get userRef => FirebaseFirestore.instance.collection(USERS_TABLE_COLLECTION_NAME).doc("$uid");
  UserProfile? get userProfile => _userProfile;
  RoomUser? get roomUser => _roomUser;

  Future<Result> createUserWithEmailAndPassWord({required UserAuthInfo userAuthInfo, required UserProfile userProfile}) async {
    _userAuthInfo = userAuthInfo;
    _userProfile = userProfile;
    _auth = UserAuthentifier(_userAuthInfo!);

    Result result = await _auth!.createUserWithEmailAndPassWord();
    if(result.isOk) _auth = result.value;
    if(!result.isOk) return result;

    _createChatCoreUserAccount();

    _isAccountCreated = true;

    _userStoreInfo = UserStoreInfo(uidArg: _user!.uid, profileArg: _userProfile!);
    _addToStore();

    return const Result(isOk: true);
  }

  Future<Result> signInWithEmailAndPassWord({required UserAuthInfo userAuthInfo}) async { 
    _userAuthInfo = userAuthInfo;
    
    _auth = UserAuthentifier(_userAuthInfo!);

    Result result = await _auth!.signInWithEmailAndPassWord();
    if(result.isOk) _user = result.value;
    if(!result.isOk) return result;

    if(_user == null) {
      print("_user variable is null in createUserWithEmailAndPassWord method of userController class");
      return const Result(isOk: false);
    }

    final UserProfile? userProfile = await _fetchUserProfileFromStore();
    if(userProfile != null) _userProfile = userProfile;

    _userProfile = await _fetchUserProfileFromStore();
    _roomUser = await _fetchRoomUserFromStore();
    _userStoreInfo = UserStoreInfo(uidArg: _user!.uid, profileArg: _userProfile!);

    return const Result(isOk: true);
  }

  Future<void> _createChatCoreUserAccount() async {
    try{
      final String? iconImageUrl = _userProfile!.name != ""
        ? _userProfile!.iconImageUrl
        : null;
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: _userProfile!.name,
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
  
  Future<RoomUser?> _fetchRoomUserFromStore() async {
    if(!isLogin) return null;
    if(_user!.uid == "") return null;
    RoomUser fetchedData = await _fetcher.fetchRoomUserData(targetUidArg: _user!.uid);
    return fetchedData;
  }
}
