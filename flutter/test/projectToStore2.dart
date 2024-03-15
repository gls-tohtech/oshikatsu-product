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
      "oshiageProguctTestMail1@gmail.com", 
      "qwertyuiop"
    );
    var userProfile = UserProfile(
        name: "あやか",
        birthdayYear: 23,
        birthdayMonth: 32,
        gender: "female",
        iconImageUrl: "",
        biography: "",
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
      title: "☆Wセンター記念☆ 応援広告作成プロジェクト",
      discription: "", 
      deadline: Timestamp.fromDate(DateTime(2042, 11, 18)), 
      hashtags: ["idol", "センター記念"],
      thumbnailUrl: "https://firebasestorage.googleapis.com/v0/b/oshikatsu-dev-8bb0d.appspot.com/o/PROJECT_IMAGE_STORAGE%2FFsi7o2uacAsolwi.jpg?alt=media&token=eb041a73-0a70-4900-ae05-81ef97bf5e1e", 
      moneyGoal: 10000,
      moneyDonated: 2000
    );

    final ProjectRegistry registry = ProjectRegistry();
    registry.add(newProjectData: project);

    final ProjectDataFetcher fetcher = ProjectDataFetcher();
    final Project fetchedProject = Project.fromMap(await fetcher.fetch(targetProjectId: project.projectId) ?? {});

    final roomController = RoomController();
    roomController.createGroupRoom("Wセンター記念", [userController.uid!]);

    expect(fetchedProject.createdBy, project.createdBy);
  });
}