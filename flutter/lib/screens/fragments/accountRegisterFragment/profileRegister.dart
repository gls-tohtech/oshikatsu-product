import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/screens/fragments/accountRegisterFragment/pageTItle.dart';
import 'package:oshikatsu_product/settings/appColors.dart';

class ProfileRegister extends StatefulWidget {
    final Function(UserProfile) profileSetCallback;
    const ProfileRegister({super.key, required this.profileSetCallback});

  @override
  _ProfileRegisterState createState() => _ProfileRegisterState();
}

class _ProfileRegisterState extends State<ProfileRegister> {
  final _nameText = TextEditingController();
  final _bioText = TextEditingController();

  // var a = UserProfile(
  //   name: name, 
  //   birthdayYear: birthdayYear, 
  //   birthdayMonth: birthdayMonth, 
  //   gender: gender, 
  //   iconImageUrl: iconImageUrl, 
  //   biography: biography, 
  //   relatedProjects: relatedProjects
  // );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            child: Column(
              children: [
                const RegisterPageTitleWidget(title: "アカウントプロフィールの登録"),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors().primaryColor,
                        width: 2
                      ),
                      borderRadius: BorderRadius.circular(256)
                    ),
                    child: InkWell(
                      onTap: () {
                        
                      },
                      borderRadius: BorderRadius.circular(256),
                      child: const SizedBox(
                        height: 150,
                        width: 150,
                        child: Icon(
                          Icons.image_search,
                          size: 75,
                        ),
                      )
                    ),
                  ),
                ),
                buildForm(
                  _nameText, 
                  '名前を入力', 
                  TextInputType.name
                ),
                buildForm(
                  _bioText,
                  'アカウントプロフィール', 
                  TextInputType.text
                ),
                
              ],
            )
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
        ]
      ),
    );
  }

  Widget buildForm(TextEditingController controller, String hintText, TextInputType textInputType){
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
      child: TextFormField(
        controller: controller,
        maxLines: null,
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