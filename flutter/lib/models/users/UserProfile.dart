class UserProfile{
  late final String _name;
  late final int _birthdayYear;
  late final int _birthdayMonth;
  late final String _gender;
  late final String _iconImageUrl;
  late final String _biography;

  late final Map<String, dynamic> _dbProcessedMap;
  Map<String, dynamic> get dbProcessedMap => _dbProcessedMap; 

  String get name => _name;
  int get birthdayYear => _birthdayYear;
  int get birthdayMonth => _birthdayMonth;
  String get gender => _gender;
  String get iconImageUrl => _iconImageUrl;
  String get biography => _biography;

  UserProfile({
    required String nameArg, 
    required int birthdayYearArg,
    required int birthdayMonthArg,
    required String genderArg, 
    required String iconImageUrlArg,
    required String biography,
  }){
    _name = nameArg;
    _birthdayYear = birthdayYearArg;
    _birthdayMonth = birthdayMonthArg;
    _gender = genderArg;
    _iconImageUrl = iconImageUrlArg;
    _biography = biography;

    _dbProcessedMap = {
      UserTableColumn.NAME.name: _name, 
      UserTableColumn.BIRTHDAY_YEAR.name: _birthdayYear,
      UserTableColumn.BIRTHDAY_MONTH.name: _birthdayMonth,
      UserTableColumn.GENDER.name: _gender,
      UserTableColumn.ICON_IMAGE_URL.name: _iconImageUrl,
      UserTableColumn.BIOGRAPHY.name: _biography,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> mapArg){
    return UserProfile(
        nameArg: mapArg[UserTableColumn.NAME.name],
        birthdayYearArg: mapArg[UserTableColumn.BIRTHDAY_YEAR.name],
        birthdayMonthArg: mapArg[UserTableColumn.BIRTHDAY_MONTH.name], 
        genderArg: mapArg[UserTableColumn.GENDER.name],
        iconImageUrlArg: mapArg[UserTableColumn.ICON_IMAGE_URL.name],
        biography: mapArg[UserTableColumn.BIOGRAPHY.name],
      );
  }
}

enum UserTableColumn{
  NAME,                 //req
  BIRTHDAY_YEAR,        //req
  BIRTHDAY_MONTH,       //req
  GENDER,               //req
  ICON_IMAGE_URL,       
  BIOGRAPHY,
}
