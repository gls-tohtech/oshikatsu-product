class UserProfile{
  late final String _name;
  late final int _birthdayYear;
  late final int _birthdayMonth;
  late final String _sex;

  late final String _iconImageUrl = "";
  late final String _userProfileDetail = "";
  late final String _geometry = "";

  late final Map<String, dynamic> _dbProcessedMap;
  Map<String, dynamic> get dbProcessedMap => _dbProcessedMap; 

  UserProfile({
    required String nameArg, 
    required int birthdayYearArg,
    required int birthdayMonthArg,
    required String sexArg, 
  }){
    _name = nameArg;
    _birthdayYear = birthdayYearArg;
    _birthdayMonth = birthdayMonthArg;
    _sex = sexArg;

    _dbProcessedMap = {
      UserTableColumn.NAME.name: _name, 
      UserTableColumn.BIRTHDAY_YEAR.name: _birthdayYear,
      UserTableColumn.BIRTHDAY_MONTH.name: _birthdayMonth,
      UserTableColumn.SEX.name: _sex,
      UserTableColumn.ICON_IMAGE_URL.name: _iconImageUrl,
      UserTableColumn.USER_PROFILE_DETAIL.name: _userProfileDetail,
      UserTableColumn.GEOMETRY.name: _geometry
    };
  }
}

enum UserTableColumn{
  NAME,                 //req
  BIRTHDAY_YEAR,        //req
  BIRTHDAY_MONTH,       //req
  SEX,                  //req
  ICON_IMAGE_URL,       
  USER_PROFILE_DETAIL,
  GEOMETRY,
}