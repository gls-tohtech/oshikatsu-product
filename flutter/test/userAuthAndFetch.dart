import 'package:test/test.dart';
import 'package:oshikatsu_product/models/users/UserAuthInfo.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/utils/UserController.dart';

void main(){
  test("user-store", () {
    final userController = UserController(
      UserAuthInfo(
        "rerurateyuto@gmail.com", 
        "qwertyuiop"
      ), 
      UserProfile(
        nameArg: "reru", 
        birthdayYearArg: 23, 
        birthdayMonthArg: 32, 
        genderArg: "male"
      )
    );

    userController.createUserWithEmailAndPassWord();
    userController.signInWithEmailAndPassWord();
    userController.addToStore();

    expect(userController.isLogin, true);
  });
}