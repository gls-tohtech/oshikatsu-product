import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:oshikatsu_product/models/users/UserStore.dart';
import 'package:oshikatsu_product/models/users/roomUser.dart';

typedef Role = types.Role;

enum RoomsTableColumn {
  CREATEDAT,
  ID,
  IMAGE_URL,
  NAME,
  TYPE,
  METADATA,
  USER_IDS,
  USER_ROLES,
  UPDATEDAT
}

extension RoomsTableColumnEx on RoomsTableColumn {
  String get name {
    switch (this) {
      case RoomsTableColumn.CREATEDAT: return "createdAt";
      case RoomsTableColumn.ID: return "id";
      case RoomsTableColumn.IMAGE_URL: return "imageUrl";
      case RoomsTableColumn.NAME: return "name";
      case RoomsTableColumn.USER_IDS: return "userIds";
      case RoomsTableColumn.METADATA: return "metadata";
      case RoomsTableColumn.USER_ROLES: return "userRoles";
      case RoomsTableColumn.UPDATEDAT: return "updatedAt";
      case RoomsTableColumn.TYPE: return "type";
    }
  }
}

class Rooms {
  Rooms({
    this.createdAt,
    required this.id,
    this.imageUrl,
    this.name,
    this.type,
    this.metadata,
    required this.userIds,
    this.updatedAt,
  });

  late final int? createdAt;
  late final String id;
  late final String? imageUrl;
  late final List<types.Message>? lastMessages;
  late final Map<String, dynamic>? metadata;
  late final String? name;
  late final types.RoomType? type;
  late final int? updatedAt;
  late final List<RoomUser> userIds;

  factory Rooms.createFromRoom({required types.Room roomArg}) {
    List<RoomUser>? roomUsers = [];
    for (var user in roomArg.users) {
      roomUsers.add(RoomUser.createFromUser(userArg: user));
    }

    return Rooms(
      id: roomArg.id,
      createdAt: roomArg.createdAt,
      imageUrl: roomArg.imageUrl,
      name: roomArg.name,
      type: roomArg.type,
      metadata: roomArg.metadata,
      userIds: roomUsers,
      updatedAt: roomArg.updatedAt,
    );
  }

  types.Room toRoom(){
    final List<types.User> users = [];
    for(var roomUser in userIds){
      users.add(roomUser.toUser());
    }

    return types.Room(
      id: id, 
      type: type, 
      users: users,
      createdAt: createdAt,
      updatedAt: updatedAt,
      name: name,
      metadata: metadata,
    );
  }

  // factory Rooms.fromMap({required String idArg, required Map<String, dynamic> mapArg}) {
  //   RoomUserConverter converter = RoomUserConverter();
  //   types.RoomType type = converter.getTypeValue(mapArg[RoomsTableColumn.TYPE.name]);
  //   //List<RoomUser> roomUsers = await converter.convertRoomUserListFromMap(mapArg[RoomsTableColumn.USER_IDS.name]);
  //   List<RoomUser> roomUsers = [];

  //   return Rooms(
  //     id: idArg,
  //     createdAt: mapArg[RoomsTableColumn.CREATEDAT.name]?.millisecondsSinceEpoch,
  //     imageUrl: mapArg[RoomsTableColumn.IMAGE_URL.name],
  //     name: mapArg[RoomsTableColumn.NAME.name],
  //     type: type,
  //     metadata: mapArg[RoomsTableColumn.METADATA.name],
  //     userIds: roomUsers,
  //     updatedAt: mapArg[RoomsTableColumn.UPDATEDAT.name]?.millisecondsSinceEpoch,
  //   );
  // }
}

class RoomsFactory{
  ///[Rooms]ファクトリ内では、[RoomUserConverter]の[RoomUserConverter.convertRoomUserListFromMap]が使用できないため
  Future<Rooms> createRoomsFromMap({required String idArg, required Map<String, dynamic> mapArg}) async {
    RoomUserConverter converter = RoomUserConverter();
    types.RoomType type = converter.getTypeValue(mapArg[RoomsTableColumn.TYPE.name]);
    List<RoomUser> roomUsers = await converter.convertRoomUserListFromMap(mapArg[RoomsTableColumn.USER_IDS.name]);

    return Rooms(
      id: idArg,
      createdAt: mapArg[RoomsTableColumn.CREATEDAT.name]?.millisecondsSinceEpoch,
      imageUrl: mapArg[RoomsTableColumn.IMAGE_URL.name],
      name: mapArg[RoomsTableColumn.NAME.name],
      type: type,
      metadata: mapArg[RoomsTableColumn.METADATA.name],
      userIds: roomUsers,
      updatedAt: mapArg[RoomsTableColumn.UPDATEDAT.name]?.millisecondsSinceEpoch,
    );
  }
}

class RoomUserFetcher{
  final db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetch({required String targetRoomUserId}) async {
    final fetchedRoomUser = await db
      .collection(ROOM_USERS_TABLE_COLLECTION_NAME)
      .doc(targetRoomUserId)
      .get();

    return fetchedRoomUser.data() ?? {};
  }
}

class RoomUserConverter{
  types.RoomType getTypeValue(String str) {
    switch(str){
      case "channel": return types.RoomType.channel;
      case "direct": return types.RoomType.direct;
      case "group": return types.RoomType.group;
      default: throw Exception("Failed to expected value");
    }
  }

  Future<List<RoomUser>> convertRoomUserListFromMap(List<String> uidStr) async {
    final fetcher = RoomUserFetcher();
    List<RoomUser> roomUsers = [];

    for(String uid in uidStr){
      Map<String, dynamic> roomUserMap = await fetcher.fetch(targetRoomUserId: uid);
      RoomUser roomUser = RoomUser.fromMap(idArg: uid, mapArg: roomUserMap);
      roomUsers.add(roomUser);
    }

    return roomUsers;
  }
}
