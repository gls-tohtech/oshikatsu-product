import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  late final String _projectId;

  late final Timestamp _createdAt;
  late final Reference _createdBy;
  late final List<Reference> _admins;
  late final List<Reference> _members;
  late final List<Reference> _donaters;
  late final String _title;
  late final String _discription;
  late final Timestamp _deadline;
  late final List<String> _hashtags;
  late final String _thumbnailUrl;
  late final int _moneyGoal;
  late final int _moneyDonated;

  late Map<String, dynamic> _dbProcessedMap;

  String get projectId => _projectId;
  Map<String, dynamic> get dbProcessedMap => _dbProcessedMap; 

  Timestamp get createdAt => _createdAt;
  Reference get createdBy => _createdBy;
  List<Reference> get admins => _admins;
  List<Reference> get members => _members;
  List<Reference> get donaters => _donaters;
  String get title => _title;
  String get discription => _discription;
  Timestamp get deadline => _deadline;
  List<String> get hashtags => _hashtags;
  String get thumbnailUrl => _thumbnailUrl;
  int get moneyGoal => _moneyGoal;
  int get moneyDonated => _moneyDonated;

  Project({
    required Timestamp createdAt,
    required Reference createdBy,
    required List<Reference> admins,
    required List<Reference> members,
    required List<Reference> donaters,
    required String title,
    required String discription,
    required Timestamp deadline,
    required List<String> hashtags,
    required String thumbnailUrl,
    required int moneyGoal,
    required int moneyDonated,
  }){
    _createdAt = createdAt;
    _createdBy = createdBy;
    _admins = admins;
    _members = members;
    _donaters = donaters;
    _title = title;
    _discription = discription;
    _deadline = deadline;
    _hashtags = hashtags;
    _thumbnailUrl = thumbnailUrl;
    _moneyGoal = moneyGoal;
    _moneyDonated = moneyDonated;

    _projectId = "$_createdBy:$_title:${_createdBy.toString()}";

    _dbProcessedMap = _createDbProcessedMap();
  } 

  Map<String, dynamic> _createDbProcessedMap(){
    return {
      ProjectTableColumn.CREATED_AT.name: _createdAt,
      ProjectTableColumn.CREATED_BY.name: _createdBy,
      ProjectTableColumn.ADMINS.name: _admins,
      ProjectTableColumn.MEMBERS.name: _members,
      ProjectTableColumn.DONATERS.name: _donaters,
      ProjectTableColumn.TITLE.name: _title,
      ProjectTableColumn.DISCRIPTION.name: _discription,
      ProjectTableColumn.DEADLINE.name: _deadline,
      ProjectTableColumn.HASHTAGS.name: _hashtags,
      ProjectTableColumn.THUMBNAIL_URL.name: _thumbnailUrl,
      ProjectTableColumn.MONEY_GOAL.name: _moneyGoal,
      ProjectTableColumn.MONEY_DONATED.name: _moneyDonated,
    };
  }

factory Project.fromMap(Map<String, dynamic> mapArg){
  return Project(
    createdAt: mapArg[ProjectTableColumn.CREATED_AT.name] as Timestamp,
    createdBy: mapArg[ProjectTableColumn.CREATED_BY.name] as Reference,
    admins: List<Reference>.from(mapArg[ProjectTableColumn.ADMINS.name] as List),
    members: List<Reference>.from(mapArg[ProjectTableColumn.MEMBERS.name] as List),
    donaters: List<Reference>.from(mapArg[ProjectTableColumn.DONATERS.name] as List),
    title: mapArg[ProjectTableColumn.TITLE.name] as String,
    discription: mapArg[ProjectTableColumn.DISCRIPTION.name] as String,
    deadline: mapArg[ProjectTableColumn.DEADLINE.name] as Timestamp,
    hashtags: List<String>.from(mapArg[ProjectTableColumn.HASHTAGS.name] as List),
    thumbnailUrl: mapArg[ProjectTableColumn.THUMBNAIL_URL.name] as String,
    moneyGoal: mapArg[ProjectTableColumn.MONEY_GOAL.name] as int,
    moneyDonated: mapArg[ProjectTableColumn.MONEY_DONATED.name] as int,
  );
}
}