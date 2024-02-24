import 'package:cloud_firestore/cloud_firestore.dart';
import 'project.dart';

class ProjectRegistry{
  final db = FirebaseFirestore.instance;

  Future add({required Project newProjectData}) async{
    await db
      .collection(PROJECTS_TABLE_COLLECTION_NAME)
      .doc(newProjectData.projectId)
      .set(newProjectData.dbProcessedMap);
  }

  Future update({required Project newProjectData}) async{
    await db
      .collection(PROJECTS_TABLE_COLLECTION_NAME)
      .doc(newProjectData.projectId)
      .update(newProjectData.dbProcessedMap);
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