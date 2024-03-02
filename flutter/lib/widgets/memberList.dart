import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:oshikatsu_product/utils/duplidatesRemover.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';
import 'package:oshikatsu_product/widgets/userIcon.dart';

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.06)),
                        Icon(
                          Icons.person,
                          size: size.width * 0.2,
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.02)),
                        const Text(
                          "メンバ一覧",
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for(types.User user in users) buildAvatar(user),
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
