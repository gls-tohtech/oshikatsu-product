import 'package:flutter/material.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/models/users/UserAuthInfo.dart';
import 'package:oshikatsu_product/utils/showDialog.dart';
import 'package:oshikatsu_product/widgets/header.dart';
import 'package:oshikatsu_product/widgets/radiusText.dart';

class AuthRegister extends StatefulWidget {
  const AuthRegister({super.key});

  @override
  _AuthRegisterState createState() => _AuthRegisterState();
}

class _AuthRegisterState extends State<AuthRegister> {
final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  final _userContoroller = UserController();

  Future<bool> _login() async {
    if(!_checkEntered()) return false;
    final userAuthInfo = UserAuthInfo(_emailText.text, _passwordText.text);
    await _userContoroller.signInWithEmailAndPassWord(userAuthInfo: userAuthInfo);
    if(!_checkLogined()) return false;
    return true;
  }

  //todo:未実装
  bool _checkLogined(){
    return true;
  }

  bool _checkEntered(){
    if(_emailText.text == ""){
      showWarnDialog(context, "メールアドレスが入力されていません。");
      return false;
    }
    if(_passwordText.text == ""){
      showWarnDialog(context, "パスワードが入力されていません。");
      return false;
    }
    return true;
  }

  void _showSnackBar(){
    const snackBar = SnackBar(content: Text('ログインに成功しました！'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  FittedBox(
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: const Text(
                        "アカウント基本情報の登録",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  buildForm(
                    _emailText, 
                    'メールアドレスを入力', 
                    TextInputType.emailAddress
                  ),
                  buildForm(
                    _passwordText,
                    'パスワードを入力', 
                    TextInputType.visiblePassword
                  ),
                ],
              )
            ),
          ]
        ),
      ),
    );
  }
  
  Widget buildForm(TextEditingController controller, String hintText, TextInputType textInputType){
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 8.0
          ),
          border: const OutlineInputBorder(),
          hintText: hintText,
        ),
        keyboardType: textInputType
      ),
    );
  }
}