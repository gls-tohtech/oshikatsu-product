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

    var auth = UserAuthInfo(
        "nenireru@gmail.com", 
        "qwertyuiop"
    );
    var userProfile = UserProfile(
        nameArg: "reru",
        birthdayYearArg: 23,
        birthdayMonthArg: 32,
        genderArg: "male",
        iconImageUrlArg: "",
        biography: "",
    );

    await userController.createUserWithEmailAndPassWord(userAuthInfo: auth, userProfile: userProfile);
    await userController.signInWithEmailAndPassWord(userAuthInfo: auth);

    expect(userController.isLogin, true);
  });
}
