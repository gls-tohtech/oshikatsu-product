import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oshikatsu_product/controllers/followController.dart';
import 'package:oshikatsu_product/models/users/roomUser.dart';
import 'package:oshikatsu_product/models/users/userFollow.dart';
import './UserProfile.dart';

const USERS_TABLE_COLLECTION_NAME = "users";
const ROOM_USERS_TABLE_COLLECTION_NAME = "room_users";

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

  Future<UserProfile> fetchUserProfile({required String targetUidArg}) async{
    final fetchedUser = await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(targetUidArg)
      .get();

    return UserProfile.fromMap(fetchedUser.data() ?? {});
  }

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

  Future<List<Followed>> fetchFollowedList({required String targetUidArg}) async {
    final querySnapshot = await db
      .collection("$USERS_TABLE_COLLECTION_NAME/$targetUidArg/$FOLLOWED_SUB_COLLECTION_NAME")
      .get();

    final followedList = querySnapshot.docs.map((doc) =>
      Followed.fromMap(mapArg: doc.data())
    ).toList();

    return followedList;
  }

  
  Future<List<Followers>> fetchFollowersList({required String targetUidArg}) async {
    final querySnapshot = await db
      .collection("$USERS_TABLE_COLLECTION_NAME/$targetUidArg/$FOLLOWERS_SUB_COLLECTION_NAME")
      .get();

    final followersList = querySnapshot.docs.map((doc) =>
      Followers.fromMap(mapArg: doc.data())
    ).toList();

    return followersList;
  }
}
