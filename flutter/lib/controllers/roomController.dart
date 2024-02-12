import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:oshikatsu_product/controllers/UserController.dart';

class RoomController{
  final FirebaseChatCore CHAT_CORE = FirebaseChatCore.instance;

  final UserController _userController = UserController();

  Future<types.Room> createRoom() async {
    final types.User user = types.User(id: _userController.uid);
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
}