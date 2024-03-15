import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:oshikatsu_product/utils/convertRefFromUser.dart';
import 'package:oshikatsu_product/utils/duplidatesRemover.dart';
import 'package:oshikatsu_product/widgets/border.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';
import 'package:oshikatsu_product/widgets/userIcon.dart';
import 'package:oshikatsu_product/widgets/userProfileLabel.dart';

class RoomMemberList extends ConsumerStatefulWidget {
  const RoomMemberList({
    super.key,
    required this.room
  });

  final types.Room room;

  @override
  RoomMemberListState createState() => RoomMemberListState();
}

class RoomMemberListState extends ConsumerState<RoomMemberList> {

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    final List<types.User> users = widget.room.users.removeDuplicates as List<types.User>;
    final List<DocumentReference> usersRef = users.convertRefFromUser();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: size.height * 0.1),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(64),
            topRight: Radius.circular(64),
          ),
          child: Card(
            elevation: 256,
            child: Column(
              children: [
                StandartPaddingComponent(),
                Stack(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.06)),
                          Icon(
                            Icons.person,
                            size: size.width * 0.15,
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.02)),
                          const Text(
                            "メンバ一覧",
                            style: TextStyle(fontSize: 32),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.01),
                        child: IconButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          }, 
                          icon: Icon(
                            Icons.close,
                            size: size.width * 0.13,
                          )
                        ),
                      ),
                    )
                  ],
                ),
                StandartPaddingComponent(),
                HorizontalBorderComponent(heightRatio: 0.003),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for(DocumentReference userRef in usersRef) UserProfileLabelComponent(
                          userRef: userRef, 
                          widthRatio: 0.7
                        ),
                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }

  Widget buildAvatar(types.User user){
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        UserIcon(width: size.width * 0.2, height: size.height * 0.1, uid: user.id),
        Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.05)),
        Text(
          user.firstName ?? "",
          style: TextStyle(fontSize: 32),
        )
      ],
    );
  }
}
