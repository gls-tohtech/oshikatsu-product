import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/models/rooms.dart';
import 'package:oshikatsu_product/screens/fragments/chatRoomFragment/chat.dart';

class RoomController{
  final FirebaseChatCore CHAT_CORE = FirebaseChatCore.instance;
  final FirebaseFirestore FIRESTORE = FirebaseFirestore.instance;


  final UserController _userController = UserController();

  Future<types.Room> createRoom() async {
    final String uid;

    if(_userController.uid != null) { uid = _userController.uid!; }
    else { throw Exception("Failed to create room in createRoom method of RoomController class, uid[${_userController.uid}] is null"); }

    final types.User user = types.User(id: uid);
    return await CHAT_CORE.createRoom(user);
  }

  Future<types.Room> createGroupRoom(String roomName, List<String> uidList) async {
    final List<types.User> users = uidList.map((e) {
      return types.User(id: e);
    }).toList();

    return CHAT_CORE.createGroupRoom(
      name: roomName,
      users: users
    );
  }

  Future deleteUserFromRoom(types.Room room) async {
    DocumentReference<Map<String, dynamic>> docRef = FIRESTORE.collection(ROOM_TABLE_COLLECTION_NAME).doc(room.id);
    await docRef.update({
      'userIds': FieldValue.arrayRemove([_userController.uid])
    });
  }

  Future enterChatRoom(String roomId, BuildContext context) async {
    CHAT_CORE.room(roomId).listen((catchedRoom) {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
        return ChatPage(room: catchedRoom);
      }));
    });
  }
}