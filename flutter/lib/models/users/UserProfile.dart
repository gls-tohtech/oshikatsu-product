// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfile{
  late final String _name;
  late final int _birthdayYear;
  late final int _birthdayMonth;
  late final String _gender;

  late final String _iconImageUrl = "";
  late final String _userProfileDetail = "";
  late final String _geometry = "";

  late final Map<String, dynamic> _dbProcessedMap;
  Map<String, dynamic> get dbProcessedMap => _dbProcessedMap; 

  UserProfile({
    required String nameArg, 
    required int birthdayYearArg,
    required int birthdayMonthArg,
    required String genderArg, 
  }){
    _name = nameArg;
    _birthdayYear = birthdayYearArg;
    _birthdayMonth = birthdayMonthArg;
    _gender = genderArg;

    _dbProcessedMap = {
      UserTableColumn.NAME.name: _name, 
      UserTableColumn.BIRTHDAY_YEAR.name: _birthdayYear,
      UserTableColumn.BIRTHDAY_MONTH.name: _birthdayMonth,
      UserTableColumn.GENDER.name: _gender,
      UserTableColumn.ICON_IMAGE_URL.name: _iconImageUrl,
      UserTableColumn.USER_PROFILE_DETAIL.name: _userProfileDetail,
      UserTableColumn.GEOMETRY.name: _geometry
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> mapArg){
    return UserProfile(
        nameArg: mapArg[UserTableColumn.NAME.name],
        birthdayYearArg: mapArg[UserTableColumn.BIRTHDAY_YEAR.name],
        birthdayMonthArg: mapArg[UserTableColumn.BIRTHDAY_MONTH.name], 
        genderArg: mapArg[UserTableColumn.GENDER.name]
      );
  }
}

enum UserTableColumn{
  NAME,                 //req
  BIRTHDAY_YEAR,        //req
  BIRTHDAY_MONTH,       //req
  GENDER,               //req
  ICON_IMAGE_URL,       
  USER_PROFILE_DETAIL,
  GEOMETRY,
}
