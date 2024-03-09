import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile{
  final String name;
  final int birthdayYear;
  final int birthdayMonth;
  final String gender;
  final String iconImageUrl;
  final String biography;
  final List<DocumentReference> relatedProjects; 

  const UserProfile({
    required this.name, 
    required this.birthdayYear,
    required this.birthdayMonth,
    required this.gender, 
    required this.iconImageUrl,
    required this.biography,
    required this.relatedProjects
  });

  factory UserProfile.fromMap(Map<String, dynamic> mapArg){
    return UserProfile(
        name: mapArg[UserTableColumn.NAME.name],
        birthdayYear: mapArg[UserTableColumn.BIRTHDAY_YEAR.name],
        birthdayMonth: mapArg[UserTableColumn.BIRTHDAY_MONTH.name], 
        gender: mapArg[UserTableColumn.GENDER.name],
        iconImageUrl: mapArg[UserTableColumn.ICON_IMAGE_URL.name],
        biography: mapArg[UserTableColumn.BIOGRAPHY.name],
        relatedProjects: List<DocumentReference>.from(mapArg[UserTableColumn.RELATED_PROJECTS.name] ?? [])
      );
  }

  Map<String, dynamic> getDbProcessedMap(){
    return {
      UserTableColumn.NAME.name: name, 
      UserTableColumn.BIRTHDAY_YEAR.name: birthdayYear,
      UserTableColumn.BIRTHDAY_MONTH.name: birthdayMonth,
      UserTableColumn.GENDER.name: gender,
      UserTableColumn.ICON_IMAGE_URL.name: iconImageUrl,
      UserTableColumn.BIOGRAPHY.name: biography,
      UserTableColumn.RELATED_PROJECTS.name: relatedProjects
    };
  }
}

enum UserTableColumn{
  NAME,                 //req
  BIRTHDAY_YEAR,        //req
  BIRTHDAY_MONTH,       //req
  GENDER,               //req
  ICON_IMAGE_URL,       
  BIOGRAPHY,
  RELATED_PROJECTS
}
