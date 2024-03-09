class UserProfile{
  final String name;
  final int birthdayYear;
  final int birthdayMonth;
  final String gender;
  final String iconImageUrl;
  final String biography;

  const UserProfile({
    required this.name, 
    required this.birthdayYear,
    required this.birthdayMonth,
    required this.gender, 
    required this.iconImageUrl,
    required this.biography,
  });

  factory UserProfile.fromMap(Map<String, dynamic> mapArg){
    return UserProfile(
        name: mapArg[UserTableColumn.NAME.name],
        birthdayYear: mapArg[UserTableColumn.BIRTHDAY_YEAR.name],
        birthdayMonth: mapArg[UserTableColumn.BIRTHDAY_MONTH.name], 
        gender: mapArg[UserTableColumn.GENDER.name],
        iconImageUrl: mapArg[UserTableColumn.ICON_IMAGE_URL.name],
        biography: mapArg[UserTableColumn.BIOGRAPHY.name],
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
}
