import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/models/projects/project.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final projectsCollection = firestore.collection(PROJECTS_TABLE_COLLECTION_NAME);

final projectStreamProvider = StreamProvider.autoDispose.family((ref, String projectId){
  final projectsSnapshot = projectsCollection.doc(projectId).snapshots();
  final project = 
    projectsSnapshot.map((snapshot) => 
      Project.fromMap(snapshot.data() ?? {})
    );

  return project;
});

final projectsStreamProvider = StreamProvider.autoDispose((ref){
  final projectsSnapshot = projectsCollection.snapshots();
  final projects = 
    projectsSnapshot.map((querySnapshot) => querySnapshot.docs.map((doc){
      return Project.fromMap(doc.data());
    }).toList());

  return projects;
});

final projectStreamProviderFromRef = StreamProvider.autoDispose.family((ref, DocumentReference projectRef){
  final projectsSnapshot = projectRef.snapshots();
  final project = 
    projectsSnapshot.map((snapshot) => 
      Project.fromMap(snapshot.data() as Map<String, dynamic> ?? {})
    );

  return project;
});
