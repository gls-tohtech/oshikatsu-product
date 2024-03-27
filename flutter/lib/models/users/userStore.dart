import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oshikatsu_product/models/users/UserStore.dart';
import 'package:oshikatsu_product/models/users/roomUser.dart';
import './UserProfile.dart';

///このデータベースでのdocumentId(uid)はFirebase Authenticationで取得できるuidとなる。
class UserStoreInfo{
  late final String _uid;
  late final UserProfile _profile;

  String get uid => _uid;
  Map<String, dynamic> get dbProcessedMap => _profile.getDbProcessedMap(); 

  UserStoreInfo({
    required String uidArg,
    required UserProfile profileArg
  }){
    _uid = uidArg;
    _profile = profileArg;
  }
}

class UserRegistry{
  final db = FirebaseFirestore.instance;

  Future add({required UserStoreInfo newUserDataArg}) async{
    await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(newUserDataArg.uid)
      .set(newUserDataArg.dbProcessedMap);
  }

  Future update({required UserStoreInfo newUserDataArg}) async{
    await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(newUserDataArg.uid)
      .update(newUserDataArg.dbProcessedMap);
  }
}

class UserDataFetcher{
  final db = FirebaseFirestore.instance;

  ///Mapデータを取得するときは、取得した変数[UsersTableColumn.カラム名（データベースの項目名）.name]と記述する。
  Future<UserProfile> fetchUserProfile({required String targetUidArg}) async{
    final fetchedUser = await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(targetUidArg)
      .get();

    return UserProfile.fromMap(fetchedUser.data() ?? {});
  }

    ///Mapデータを取得するときは、取得した変数[UsersTableColumn.カラム名（データベースの項目名）.name]と記述する。
  Future<RoomUser> fetchRoomUserData({required String targetUidArg}) async{
    final fetchedUser = await db
      .collection(ROOM_USERS_TABLE_COLLECTION_NAME)
      .doc(targetUidArg)
      .get();

    return RoomUser.fromMap(
      idArg: targetUidArg, 
      mapArg: fetchedUser.data() ?? {}
    );
  }

  Future<UserProfile> fetchUserProfileFromRef({required DocumentReference userRef}) async {
    final userSnapshot = await userRef.get();
    final userData = userSnapshot.data() as Map<String, dynamic>;
    return UserProfile.fromMap(userData);
  }
}
