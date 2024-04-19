import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/firebase_options.dart';
import 'package:oshikatsu_product/models/projects/project.dart';
import 'package:oshikatsu_product/models/projects/projectStorage.dart';
import 'package:oshikatsu_product/models/projects/projectStore.dart';
import 'package:oshikatsu_product/models/users/UserAuthInfo.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  // try {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8088);
  //   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //   FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  // } catch (e) {
  //   // ignore: avoid_print
  //   print(e);
  // }

  test("project-store", () async {
    final userController = UserController(); 

    var userAuthInfo = UserAuthInfo(
        "nenireru@gmail.com", 
        "qwertyuiop"
    );

    var userProfile = UserProfile(
      name: "rerurate",
      birthdayYear: 23,
      birthdayMonth: 32,
      gender: "male",
      iconImageUrl: "https://firebasestorage.googleapis.com/v0/b/oshikatsu-dev-8bb0d.appspot.com/o/USER_ICON_IMAGE%2Fskadi.jpg?alt=media&token=bb0a37e3-a5be-4096-a458-2436ec551b61",
      biography: "",
      relatedProjects: []
    );

    await userController.createUserWithEmailAndPassWord(userAuthInfo: userAuthInfo, userProfile: userProfile);
    await userController.signInWithEmailAndPassWord(userAuthInfo: userAuthInfo);

    expect(userController.isLogin, true);

    // final uploader = ProjectImageUploader();
    // await uploader.uploadImageAndFetchUrl();

    final project1 = Project(
      createdAt: Timestamp.now(), 
      createdBy: userController.userRef,
      admins: [userController.userRef], 
      members: [], 
      donaters: [], 
      title: "芦田愛菜応援会",
      discription: "このプロジェクトは芦田愛菜さんを応援するものです。", 
      deadline: Timestamp.fromDate(DateTime(2042, 11, 18)), 
      hashtags: ["idol", "cute"],
      thumbnailUrl: "", 
      moneyGoal: 100000,
      moneyDonated: 50000
    );


    final project2 = Project(
      createdAt: Timestamp.now(), 
      createdBy: userController.userRef,
      admins: [userController.userRef], 
      members: [], 
      donaters: [], 
      title: "POEMを応援したい!", 
      discription: "POEMを応援したい人集まれ!", 
      deadline: Timestamp.fromDate(DateTime(2024, 12, 31)), 
      hashtags: ["idol", "cute"], 
      thumbnailUrl: "", 
      moneyGoal: 10000,
      moneyDonated: 0
    );

    final project3 = Project(
      createdAt: Timestamp.now(), 
      createdBy: userController.userRef,
      admins: [userController.userRef], 
      members: [], 
      donaters: [], 
      title: "地元アイドル：アイクルガールズ", 
      discription: "ボランティアアイドルのため、収益なしらしい。。。", 
      deadline: Timestamp.fromDate(DateTime(2024, 3, 31)), 
      hashtags: ["idol", "cute"], 
      thumbnailUrl: "", 
      moneyGoal: 65535,
      moneyDonated: 1024
    );

    final ProjectRegistry registry = ProjectRegistry();
    registry.add(newProjectData: project1);
    registry.add(newProjectData: project2);
    registry.add(newProjectData: project3);

    final ProjectDataFetcher fetcher = ProjectDataFetcher();
    final Project fetchedProject = Project.fromMap(await fetcher.fetch(targetProjectId: project3.projectId) ?? {});

    expect(fetchedProject.createdBy, project3.createdBy);
  });
}