import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

// typedef User = types.User;
typedef Role = types.Role;

enum RoomUserTableColumn{
  CREATEDAT,
  FIRST_NAME,
  ID,
  IMAGE_URL,
  LAST_NAME,
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
      case RoomUserTableColumn.METADATA: return "metadata";
      case RoomUserTableColumn.ROLE: return "role";
      case RoomUserTableColumn.UPDATEDAT: return "updatedAt";
    }
  }
}

class RoomUser{
  RoomUser({
    this.createdAt,
    this.firstName,
    required String id,
    this.imageUrl,
    this.lastName,
    this.metadata,
    this.role,
    this.updatedAt,
  });

  late final int? createdAt;
  late final String? firstName;
  late final String id;
  late final String? imageUrl;
  late final String? lastName;
  late final Map<String, dynamic>? metadata;
  late final Role? role;
  late final int? updatedAt;

  factory RoomUser.createFromUser({required types.User userArg}) {
    return RoomUser(
      id: userArg.id,
      firstName: userArg.firstName,
      imageUrl: userArg.imageUrl,
      createdAt: userArg.createdAt,
      metadata: userArg.metadata,
      role: userArg.role,
      updatedAt: userArg.updatedAt,
    );
  }

  types.User toUser(){
    final RoomUser roomUser = this;
    return types.User(
      id: roomUser.id,
      firstName: roomUser.firstName,
      imageUrl: roomUser.imageUrl,
      createdAt: roomUser.createdAt,
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
      createdAt: mapArg[RoomUserTableColumn.CREATEDAT]?.millisecondsSinceEpoch,
      metadata: mapArg[RoomUserTableColumn.METADATA.name],
      role: mapArg[RoomUserTableColumn.ROLE.name],
      updatedAt: mapArg[RoomUserTableColumn.UPDATEDAT.name]?.millisecondsSinceEpoch,
    );
  }
}
