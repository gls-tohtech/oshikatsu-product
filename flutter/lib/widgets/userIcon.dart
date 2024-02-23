import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/providers/userProvider.dart';

class UserIcon extends ConsumerStatefulWidget {
  const UserIcon({
    super.key,
    this.uid,
    required this.width,
    required this.height
  });

  final String? uid;
  final double? width;
  final double? height;

  @override
  UserIconState createState() => UserIconState();
}

class UserIconState extends ConsumerState<UserIcon> {
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    late final String? uid;
    widget.uid != null ? uid = widget.uid : uid = _userController.uid;
    
    if(uid == null) return Container();
    final streamProv = ref.watch(userStreamProvider(_userController.uid!));

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: streamProv.when(
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
