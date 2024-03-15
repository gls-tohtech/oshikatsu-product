import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/screens/fragments/profileSettingFragment.dart';
import 'package:oshikatsu_product/widgets/relatedProjectList.dart';

class UserProfileComponent extends StatefulWidget {
  final DocumentReference userRef;
  final UserProfile userProfile;
  final bool isLoginedUser;
  UserProfileComponent({required this.userProfile, required this.userRef, required this.isLoginedUser});

  @override
  _UserProfileComponentState createState() => _UserProfileComponentState();
}

class _UserProfileComponentState extends State<UserProfileComponent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late UserProfile _userProfile = widget.userProfile;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          if(widget.isLoginedUser) IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return const ProfileSettingFragment();
              }));
            },
          ),
          if(!widget.isLoginedUser) IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          UserInformationSection(
            userProfile: _userProfile,
          ),
          //if(!widget.isLoginedUser) RelatedProjectList(userRef: widget.userRef)
        ],
      ),
    );
  }
}

class UserInformationSection extends StatelessWidget {
  late UserProfile userProfile;
  UserInformationSection({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    // ダミーのフォロー数とフォロワー数
    final int followersCount = 150;
    final int followingCount = 75;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                child:  userProfile.iconImageUrl != ""
                  ? Image.network(userProfile.iconImageUrl)
                  : const Icon(
                    Icons.person,
                    size: 40,
                  ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(userProfile.name,
                      style: Theme.of(context).textTheme.headline6
                    ),
                    if(userProfile.biography != "") Text(userProfile.biography),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('フォロー', style: Theme.of(context).textTheme.caption),
                  Text('$followingCount',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('フォロワー', style: Theme.of(context).textTheme.caption),
                  Text('$followersCount',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
