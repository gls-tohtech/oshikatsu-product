import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/screens/fragments/accountRegisterFragment/pageTItle.dart';
import 'package:oshikatsu_product/settings/appColors.dart';
import 'package:oshikatsu_product/utils/validate/validate.dart';
import 'package:oshikatsu_product/utils/validate/validateType.dart';
import 'package:oshikatsu_product/widgets/imagePickAndSelect.dart';
import 'package:oshikatsu_product/widgets/radiusText.dart';
import 'package:oshikatsu_product/widgets/textFormField.dart';

class ProfileRegister extends StatefulWidget {
    final Function(UserProfile) profileSetCallback;
    const ProfileRegister({super.key, required this.profileSetCallback});

  @override
  _ProfileRegisterState createState() => _ProfileRegisterState();
}

class _ProfileRegisterState extends State<ProfileRegister> {
  final _nameText = TextEditingController();
  final _bioText = TextEditingController();

  DateTime? _selectedDate;
  
  bool _isShowImagePicker = false;

  ImageProvider? _imageProvider;

  bool _checkEntered(){
    if(!checkValidate(context, Validate(value: _nameText.text, validateType: StringValidateType())).isOk) return false;
    // if(!checkValidate(context, Validate(value: _bioText.text, validateType: StringValidateType())).isOk) return false;
    return true;
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1924),
      lastDate: DateTime(2025),
    );

    if(pickedDate == null) return;
    
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const RegisterPageTitleWidget(title: "アカウントプロフィールの登録"),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
                child: Card(
                  elevation: 16,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000)
                  ),
                  child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors().primaryColor,
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(1000)
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isShowImagePicker = !_isShowImagePicker;
                      });
                    },
                    borderRadius: BorderRadius.circular(1000),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: _imageProvider != null 
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image(image: _imageProvider!)
                      )
                      : const Icon(
                        Icons.image_search,
                        size: 75,
                      ),
                    )
                  ),
                ),
              )
              ),
              TextFieldWidget(
                controller: _nameText, 
                formTitle: '名前',
                textInputType: TextInputType.name,
              ),
              TextFieldWidget(
                controller: _bioText, 
                formTitle: 'アカウントプロフィール', 
                textInputType: TextInputType.text,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        '生年月',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RadiusTextComponent(
                        "生年月を選択",
                        widthRatio: 0.3,
                        textTapped: () => _pickDateTime(context)
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _selectedDate != null 
                        ? Text(
                            '生年月: ${_selectedDate!.year}年 ${_selectedDate!.month.toString().padLeft(2, '0')}月',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          )
                        : const SizedBox.shrink(),
                    // 条件に合わない場合は何も表示しない
                  ),
                ],
              ),
              const SizedBox(height: 20),
              RadiusTextComponent(
                "決定",
                widthRatio: 0.7,
                textTapped: () {
                  if(!_checkEntered()) return;

                  UserProfile profile =UserProfile(
                    name: _nameText.text, 
                    birthdayYear: _selectedDate!.year, 
                    birthdayMonth: _selectedDate!.month, 
                    gender: "none", 
                    iconImageUrl: "", 
                    biography: _bioText.text, 
                    relatedProjects: []
                  );

                  widget.profileSetCallback(profile);
                },
              )
            ]
          ),
        ),
        AnimatedSwitcher(
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
          child: _isShowImagePicker
            ? ImagePickAndselectWidget(
                closeFragmentCallback: (ImageProvider? image) {
                  setState(() {
                    _isShowImagePicker = !_isShowImagePicker;
                    _imageProvider = image;
                  });
                },
              )
            : Container(),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        )
      ],
    );
  }
}