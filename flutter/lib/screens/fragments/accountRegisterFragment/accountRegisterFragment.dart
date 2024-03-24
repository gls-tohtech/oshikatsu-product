import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:oshikatsu_product/models/users/UserAuthInfo.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/screens/fragments/accountRegisterFragment/authRegister.dart';
import 'package:oshikatsu_product/screens/fragments/accountRegisterFragment/checkTerm.dart';
import 'package:oshikatsu_product/screens/fragments/accountRegisterFragment/profileRegister.dart';
import 'package:oshikatsu_product/settings/appColors.dart';
import 'package:oshikatsu_product/widgets/header.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AccountRegisterFragment extends StatefulWidget {
  const AccountRegisterFragment({super.key});

  @override
  _AccountRegisterFragmentState createState() => _AccountRegisterFragmentState();
}

class _AccountRegisterFragmentState extends State<AccountRegisterFragment> {
  final _pageController = PageController(viewportFraction: 1.0, keepPage: true);
  late List<Widget> _pages;

  UserAuthInfo? _auth;
  UserProfile? _profile;

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }

  void _setAuth(UserAuthInfo auth) => _auth = auth;
  void _setProfile(UserProfile profile) => _profile = profile;

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;

    _pages =  [
      AuthRegister(authSetCallback: _setAuth),
      ProfileRegister(profileSetCallback: _setProfile),
      const CheckTerm()
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              HeaderTitleWidget("アカウント 登録"),
              SizedBox(
                width: size.width,
                height: size.height * 0.7,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      child: _pages[index % _pages.length],
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
                effect: WormEffect(
                  activeDotColor: AppColors().primaryColor,
                  dotHeight: 32,
                  dotWidth: 32,
                  type: WormType.thinUnderground,
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}