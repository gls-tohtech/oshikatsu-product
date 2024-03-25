import 'package:flutter/material.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/models/users/UserAuthInfo.dart';
import 'package:oshikatsu_product/screens/fragments/accountRegisterFragment/accountRegisterFragment.dart';
import 'package:oshikatsu_product/utils/result.dart';
import 'package:oshikatsu_product/utils/showDialog.dart';
import 'package:oshikatsu_product/widgets/header.dart';
import 'package:oshikatsu_product/widgets/radiusText.dart';

class LoginFragment extends StatefulWidget {
  const LoginFragment({super.key});

  @override
  _LoginFragmentState createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  final _userContoroller = UserController();

  Future<bool> _login() async {
    if(!_checkEntered()) return false;
    final userAuthInfo = UserAuthInfo(_emailText.text, _passwordText.text);
    Result result = await _userContoroller.signInWithEmailAndPassWord(userAuthInfo: userAuthInfo);
    if(result.isOk == false) return false;
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
        padding: EdgeInsets.symmetric(vertical: size.height * 0.05, horizontal: size.width * 0.03),
        child: Column(
          children: [
            HeaderTitleWidget("ログイン"),
            Form(
              child: Column(
                children: [
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
                  const SizedBox(height: 30),
                  RadiusTextComponent(
                    "ログイン",
                    widthRatio: 0.6,
                    textTapped: () async {
                      bool isLogin = await _login();
                      _showSnackBar();
                      if(isLogin) Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                        return AccountRegisterFragment();
                      }));
                    },
                    child: const Text("アカウント登録していない場合はこちらへ")
                  )
                ],
              )
            )
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