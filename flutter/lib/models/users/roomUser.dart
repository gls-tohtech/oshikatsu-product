import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

typedef User = types.User;
typedef Role = types.Role;

enum RoomUserTableColumn{
  CREATEDAT,
  FIRST_NAME,
  ID,
  IMAGE_URL,
  LAST_NAME,
  LAST_SEEN,
  METADATA,
  ROLE,
  UPDATEDAT
}

extension RoomUserTableColumnEx on RoomUserTableColumn{
  String get name{
    switch(this){
      case RoomUserTableColumn.CREATEDAT: return "createdAt";
      case RoomUserTableColumn.FIRST_NAME: return "firstName";
      case RoomUserTableColumn.ID: return "id";
      case RoomUserTableColumn.IMAGE_URL: return "imageUrl";
      case RoomUserTableColumn.LAST_NAME: return "lastName";
      case RoomUserTableColumn.LAST_SEEN: return "lastSeen";
      case RoomUserTableColumn.METADATA: return "metadata";
      case RoomUserTableColumn.ROLE: return "role";
      case RoomUserTableColumn.UPDATEDAT: return "updatedAt";
    }
  }
}

class RoomUser{
  RoomUser({
    int? createdAt,
    String? firstName,
    String? id,
    String? imageUrl,
    String? lastName,
    int? lastSeen,
    Map<String, dynamic>? metadata,
    Role? role,
    int? updatedAt,
  });

  late final int? createdAt;
  late final String? firstName;
  late final String id;
  late final String? imageUrl;
  late final String? lastName;
  late final int? lastSeen;
  late final Map<String, dynamic>? metadata;
  late final Role? role;
  late final int? updatedAt;

  factory RoomUser.createFromUser({required User userArg}) {
    return RoomUser(
      id: userArg.id,
      firstName: userArg.firstName,
      imageUrl: userArg.imageUrl,
      lastName: userArg.lastName,
      createdAt: userArg.createdAt,
      lastSeen: userArg.lastSeen,
      metadata: userArg.metadata,
      role: userArg.role,
      updatedAt: userArg.updatedAt,
    );
  }

  User toUser(){
    final RoomUser roomUser = this;
    return User(
      id: roomUser.id,
      firstName: roomUser.firstName,
      imageUrl: roomUser.imageUrl,
      lastName: roomUser.lastName,
      createdAt: roomUser.createdAt,
      lastSeen: roomUser.lastSeen,
      metadata: roomUser.metadata,
      role: roomUser.role, 
      updatedAt: roomUser.updatedAt,
    );
  }
  
  factory RoomUser.fromMap({required String idArg ,required Map<String, dynamic> mapArg}){
    return RoomUser(
      id: idArg,
      firstName: mapArg[RoomUserTableColumn.FIRST_NAME.name],
      imageUrl: mapArg[RoomUserTableColumn.IMAGE_URL.name],
      lastName: mapArg[RoomUserTableColumn.LAST_NAME.name],
      createdAt: mapArg[RoomUserTableColumn.CREATEDAT],
      lastSeen: mapArg[RoomUserTableColumn.LAST_SEEN.name],
      metadata: mapArg[RoomUserTableColumn.METADATA.name],
      role: mapArg[RoomUserTableColumn.ROLE.name],
      updatedAt: mapArg[RoomUserTableColumn.UPDATEDAT.name],
    );
  }
}
