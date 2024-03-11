import 'package:flutter/material.dart';
import 'package:oshikatsu_product/screens/fragments/supportProcessFragment/spBorderCom.dart';
import 'package:oshikatsu_product/widgets/radiusText.dart';

class ProfileSettingFragment extends StatefulWidget {
  const ProfileSettingFragment({super.key});

  @override
  _ProfileSettingFragmentState createState() => _ProfileSettingFragmentState();
}

class _ProfileSettingFragmentState extends State<ProfileSettingFragment> {
  final _nameEditController = TextEditingController();
  final _discriptionEditController = TextEditingController();

  void changeProfile(){
    
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Column(
            children: [
              buildHeader(context),
              SpBorderComponent(),
              SizedBox(height: size.height * 0.02),
              CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: size.height * 0.1
                ),
                radius: 64,
              ),
              SizedBox(height: size.height * 0.06),
              buildNameField(),
              SizedBox(height: size.height * 0.06),
              buildDiscriptionField(),
              SizedBox(height: size.height * 0.06),
              RadiusTextComponent(
                "保存",
                widthRatio: 0.7,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: size.height * 0.01),
            child: const Text(
              "アカウントの設定",
              textScaler: TextScaler.linear(1.5),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ),
        Align(
          alignment: Alignment.centerRight,
          child:  IconButton(
            onPressed: () => { 
              Navigator.of(context).pop(),
            }, 
            icon: const Icon(Icons.close)
          ),
        )
      ],
    );
  }

  Widget buildNameField(){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        const Text(
          '名前',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: size.height * 0.015,
        ),
        SizedBox(
          height: 40.0,
          child: TextFormField(
            controller: _nameEditController,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 8.0
              ),
              border: OutlineInputBorder(),
              hintText: '名前を入力',
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDiscriptionField(){
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        const Text(
          'プロフィール',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: size.height * 0.015,
        ),
        TextFormField(
          controller: _discriptionEditController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 8.0
            ),
            border: OutlineInputBorder(),
            hintText: 'プロフィールを入力',
          ),
          maxLines: null,
        ),
      ],
    );
  }
}