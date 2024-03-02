import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/firebase_options.dart';
import 'package:oshikatsu_product/models/projects/project.dart';
import 'package:oshikatsu_product/models/projects/projectStore.dart';
import 'package:oshikatsu_product/models/users/UserAuthInfo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  test("project-store", () async {
    final userController = UserController(); 

    var userAuthInfo = UserAuthInfo(
        "nenireru@gmail.com", 
        "qwertyuiop"
    );

    userController.signInWithEmailAndPassWord(userAuthInfo: userAuthInfo);

    final project = Project(
      createdAt: Timestamp.now(), 
      createdBy: userController.userRef,
      admins: [], 
      members: [], 
      donaters: [], 
      title: "ここにはプロジェクトタイトル", 
      discription: "ここにはプロジェクト説明文", 
      deadline: Timestamp.fromDate(DateTime(2042, 11, 18)), 
      hashtags: ["ここには", "ハッシュタグが", "入ります"], 
      thumbnailUrl: "https://firebasestorage.googleapis.com/v0/b/fir-test-58395.appspot.com/o/DL%2F2024-01-13_12.07.43.png?alt=media&token=321335a6-2246-46c1-857b-6d95e08abcf9", 
      moneyGoal: 100000,
      moneyDonated: 50000
    );

    final ProjectRegistry registry = ProjectRegistry();
    registry.add(newProjectData: project);

    final ProjectDataFetcher fetcher = ProjectDataFetcher();
    final Project fetchedProject = Project.fromMap(await fetcher.fetch(targetProjectId: project.projectId) ?? {});

    expect(fetchedProject.createdBy, project.createdBy);
  });
}