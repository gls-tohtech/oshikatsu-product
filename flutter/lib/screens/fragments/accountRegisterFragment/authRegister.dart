import 'package:flutter/material.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/models/users/UserAuthInfo.dart';
import 'package:oshikatsu_product/screens/fragments/accountRegisterFragment/pageTItle.dart';
import 'package:oshikatsu_product/utils/validate/validate.dart';
import 'package:oshikatsu_product/utils/validate/validateType.dart';
import 'package:oshikatsu_product/widgets/radiusText.dart';
import 'package:oshikatsu_product/widgets/textFormField.dart';

class AuthRegister extends StatefulWidget {
  final Function(UserAuthInfo) authSetCallback;
  const AuthRegister({super.key, required this.authSetCallback});

  @override
  _AuthRegisterState createState() => _AuthRegisterState();
}

class _AuthRegisterState extends State<AuthRegister> {
final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  final _userContoroller = UserController();

  bool _checkEntered(){
    if(!checkValidate(context, Validate(value: _emailText.text, validateType: AddressValidateType())).isOk) return false;
    if(!checkValidate(context, Validate(value: _passwordText.text, validateType: PasswordValidateType())).isOk) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
      child: Column(
        children: [
          const RegisterPageTitleWidget(title: "アカウント基本情報の登録"),
          TextFieldWidget(
            controller: _emailText, 
            formTitle: 'メールアドレス',
            textInputType: TextInputType.emailAddress,
          ),
          TextFieldWidget(
            controller: _passwordText, 
            formTitle: 'パスワード', 
            textInputType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 32),
          RadiusTextComponent(
            "決定",
            widthRatio: 0.7,
            textTapped: () {
              if(!_checkEntered()) return;

              UserAuthInfo auth = UserAuthInfo(
                _emailText.text,
                _passwordText.text 
              );

              widget.authSetCallback(auth);
            },
          )
        ]
      ),
    );
  }
}