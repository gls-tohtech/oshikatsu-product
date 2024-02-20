import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oshikatsu_product/firebase_options.dart';
import 'package:test/test.dart';
import 'package:oshikatsu_product/models/users/UserAuthInfo.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  test("user-store", () async {
    final userController = UserController();

    userController.setUserInfo(
      userAuthInfo: UserAuthInfo(
        "rerurateyuto@gmail.com", 
        "qwertyuiop"
      ),
      userProfile: UserProfile(
        nameArg: "reru",
        birthdayYearArg: 23,
        birthdayMonthArg: 32,
        genderArg: "male",
        iconImageUrlArg: "",
        userProfileDetailArg: "",
        geometryArg: ""
      )
    );

    await userController.createUserWithEmailAndPassWord();
    await userController.signInWithEmailAndPassWord();
    await userController.createChatCoreUserAccount("rerurate");
    userController.addToStore();

    expect(userController.isLogin, true);
  });
}
