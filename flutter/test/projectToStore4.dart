import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/controllers/roomController.dart';
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

    var auth = UserAuthInfo(
      "oshiageProguctTestMail3@gmail.com", 
      "qwertyuiop"
    );
    var userProfile = UserProfile(
        name: "夢見るサポーター",
        birthdayYear: 23,
        birthdayMonth: 32,
        gender: "female",
        iconImageUrl: "",
        biography: "夢を見て何が悪い",
        relatedProjects: []
    );

    await userController.createUserWithEmailAndPassWord(userAuthInfo: auth, userProfile: userProfile);
    await userController.signInWithEmailAndPassWord(userAuthInfo: auth);

    expect(userController.isLogin, true);

    // final uploader = ProjectImageUploader();
    // await uploader.uploadImageAndFetchUrl();

    final project = Project(
      createdAt: Timestamp.now(), 
      createdBy: userController.userRef,
      admins: [userController.userRef], 
      members: [], 
      donaters: [], 
      title: "勝手にコラボ！ W広告でお祝いしましょう!!",
      discription: "", 
      deadline: Timestamp.fromDate(DateTime(2042, 11, 18)), 
      hashtags: ["idol", "コラボ"],
      thumbnailUrl: "https://firebasestorage.googleapis.com/v0/b/oshikatsu-dev-8bb0d.appspot.com/o/PROJECT_IMAGE_STORAGE%2FGHvJQKCaIAALlxA.jpg?alt=media&token=f83489ba-878d-47b2-a84d-457d4413735f", 
      moneyGoal: 100000,
      moneyDonated: 50000
    );

    final ProjectRegistry registry = ProjectRegistry();
    registry.add(newProjectData: project);

    final ProjectDataFetcher fetcher = ProjectDataFetcher();
    final Project fetchedProject = Project.fromMap(await fetcher.fetch(targetProjectId: project.projectId) ?? {});

    final roomController = RoomController();
    roomController.createGroupRoom("生誕祭!!!!", [userController.uid!]);

    expect(fetchedProject.createdBy, project.createdBy);
  });
}