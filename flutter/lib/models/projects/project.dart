import 'package:cloud_firestore/cloud_firestore.dart';

const PROJECTS_TABLE_COLLECTION_NAME = "projects";

enum ProjectTableColumn{
  CREATED_AT,
  CREATED_BY,
  ADMINS,
  MEMBERS,
  DONATERS,
  TITLE,
  DISCRIPTION,
  DEADLINE,
  HASHTAGS,
  THUMBNAIL_URL,
  MONEY_GOAL,
  MONEY_DONATED
}

class Project{
  final Timestamp createdAt;
  final DocumentReference createdBy;
  final List<DocumentReference> admins;
  final List<DocumentReference> members;
  final List<DocumentReference> donaters;
  final String title;
  final String discription;
  final Timestamp deadline;
  final List<String> hashtags;
  final String thumbnailUrl;
  final int moneyGoal;
  final int moneyDonated;

  String get projectId => "$createdBy-$title-$createdAt";

  const Project({
    required this.createdAt,
    required this.createdBy,
    required this.admins,
    required this.members,
    required this.donaters,
    required this.title,
    required this.discription,
    required this.deadline,
    required this.hashtags,
    required this.thumbnailUrl,
    required this.moneyGoal,
    required this.moneyDonated,
  });

  Map<String, dynamic> getDbProcessedMap(){
    return {
      ProjectTableColumn.CREATED_AT.name: createdAt,
      ProjectTableColumn.CREATED_BY.name: createdBy,
      ProjectTableColumn.ADMINS.name: admins,
      ProjectTableColumn.MEMBERS.name: members,
      ProjectTableColumn.DONATERS.name: donaters,
      ProjectTableColumn.TITLE.name: title,
      ProjectTableColumn.DISCRIPTION.name: discription,
      ProjectTableColumn.DEADLINE.name: deadline,
      ProjectTableColumn.HASHTAGS.name: hashtags,
      ProjectTableColumn.THUMBNAIL_URL.name: thumbnailUrl,
      ProjectTableColumn.MONEY_GOAL.name: moneyGoal,
      ProjectTableColumn.MONEY_DONATED.name: moneyDonated,
    };
  }

  factory Project.fromMap(Map<String, dynamic> mapArg){
    return Project(
      createdAt: mapArg[ProjectTableColumn.CREATED_AT.name] as Timestamp,
      createdBy: mapArg[ProjectTableColumn.CREATED_BY.name] as DocumentReference,
      admins: List<DocumentReference>.from(mapArg[ProjectTableColumn.ADMINS.name] ?? []),
      members: List<DocumentReference>.from(mapArg[ProjectTableColumn.MEMBERS.name] ?? []),
      donaters: List<DocumentReference>.from(mapArg[ProjectTableColumn.DONATERS.name] ?? []),
      title: mapArg[ProjectTableColumn.TITLE.name]  ?? "",
      discription: mapArg[ProjectTableColumn.DISCRIPTION.name]  ?? "",
      deadline: mapArg[ProjectTableColumn.DEADLINE.name] as Timestamp,
      hashtags: List<String>.from(mapArg[ProjectTableColumn.HASHTAGS.name] ?? []),
      thumbnailUrl: mapArg[ProjectTableColumn.THUMBNAIL_URL.name] ?? "",
      moneyGoal: mapArg[ProjectTableColumn.MONEY_GOAL.name] ?? 65536,
      moneyDonated: mapArg[ProjectTableColumn.MONEY_DONATED.name] ?? 0,
    );
  }
}