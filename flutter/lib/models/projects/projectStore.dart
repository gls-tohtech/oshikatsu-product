import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/models/users/UserStore.dart';
import 'project.dart';

class ProjectRegistry{
  final db = FirebaseFirestore.instance;

  Future add({required Project newProjectData}) async{
    var docRef = db
      .collection(PROJECTS_TABLE_COLLECTION_NAME)
      .doc(newProjectData.projectId);

    await docRef.set(newProjectData.getDbProcessedMap());

    addRelationToUserProfile(
      relatedProject: docRef
    );
  }

  Future<DocumentReference> update({required Project newProjectData}) async{
    var docRef = db
      .collection(PROJECTS_TABLE_COLLECTION_NAME)
      .doc(newProjectData.projectId);

      await docRef.update(newProjectData.getDbProcessedMap());

      return docRef;
  }

  void addRelationToUserProfile({required DocumentReference relatedProject}){
    final userProfile = UserController().userProfile!;
    final newUserProfile = UserProfile(
      name: userProfile.name, 
      birthdayYear: userProfile.birthdayYear, 
      birthdayMonth: userProfile.birthdayMonth, 
      gender: userProfile.gender, 
      iconImageUrl: userProfile.iconImageUrl,
      biography: userProfile.biography, 
      relatedProjects: (userProfile.relatedProjects)..add(relatedProject)
    );

    final registry = UserRegistry();
    registry.update(newUserDataArg: UserStoreInfo(
      uidArg: UserController().uid!, 
      profileArg: newUserProfile
    ));
  }
}

class ProjectDataFetcher{
  final db = FirebaseFirestore.instance;

  ///Mapデータを取得するときは、取得した変数[ProjectsTableColumn.カラム名（データベースの項目名）.name]と記述する。
  Future<Map<String, dynamic>> fetch({required String targetProjectId}) async{
    final fetchedProject = await db
      .collection(PROJECTS_TABLE_COLLECTION_NAME)
      .doc(targetProjectId)
      .get();

    return fetchedProject.data() ?? {};
  }
}