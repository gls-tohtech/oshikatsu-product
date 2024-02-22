import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/providers/userProvider.dart';

class UserIcon extends ConsumerStatefulWidget {
  const UserIcon();

  @override
  UserIconState createState() => UserIconState();
}

class UserIconState extends ConsumerState<UserIcon> {
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    final streamProv = ref.watch(userStreamProvider(_userController.uid));
    return Scaffold(
      body: streamProv.when(
        data: (UserProfile userProfile){
          return buildIcon(userProfile);
        }, error:((error, stackTrace) {
          return ;
        }), 
        loading: () => Container()
      )
    );
  }

  Widget buildIcon(UserProfile userProfile){
    final Size size = MediaQuery.of(context).size;
    final String iconImageUrl = userProfile.dbProcessedMap[UserTableColumn.ICON_IMAGE_URL.name];
    final String userName = userProfile.dbProcessedMap[UserTableColumn.NAME.name];
    return iconImageUrl != "" 
      ? CircleAvatar(
        radius: 256,
        foregroundImage: NetworkImage(iconImageUrl),
      )
      : CircleAvatar(
        radius: 256,
        child: Text(userName),
      );
  }
}