import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/widgets/userProfileComponent.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserProfileComponent(
      userProfile: UserProfile(
          nameArg: "arashi",
          birthdayYearArg: 2023,
          birthdayMonthArg: 2,
          genderArg: "male",
          iconImageUrlArg: "https://placekitten.com/200/200",
          userProfileDetailArg: "ここにはユーザ情報が入ります",
          geometryArg: "geometryArg"),
    );
  }
}
