class UserProfile{
  late final String _name;
  late final int _birthdayYear;
  late final int _birthdayMonth;
  late final String _gender;

  late final String _iconImageUrl;
  late final String _userProfileDetail;
  late final String _geometry;

  late final Map<String, dynamic> _dbProcessedMap;
  Map<String, dynamic> get dbProcessedMap => _dbProcessedMap; 

  UserProfile({
    required String nameArg, 
    required int birthdayYearArg,
    required int birthdayMonthArg,
    required String genderArg, 
    required String iconImageUrlArg,
    required String userProfileDetailArg,
    required String geometryArg
  }){
    _name = nameArg;
    _birthdayYear = birthdayYearArg;
    _birthdayMonth = birthdayMonthArg;
    _gender = genderArg;
    _iconImageUrl = iconImageUrlArg;
    _userProfileDetail = userProfileDetailArg;
    _geometry = geometryArg;

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
        genderArg: mapArg[UserTableColumn.GENDER.name],
        iconImageUrlArg: mapArg[UserTableColumn.ICON_IMAGE_URL.name],
        userProfileDetailArg: mapArg[UserTableColumn.USER_PROFILE_DETAIL.name],
        geometryArg: mapArg[UserTableColumn.GEOMETRY.name]
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
