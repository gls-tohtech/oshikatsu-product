import 'package:flutter/widgets.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/widgets/userProfile.dart';

class MyPageUI extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final UserController userController = UserController();
    return UserProfileComponent(
      userProfile: userController.userProfile!,
      userRef: userController.userRef,
      isLoginedUser: true,
    );
  }
}