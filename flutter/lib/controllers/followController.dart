import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/models/users/userStore.dart';

const FOLLOWED_SUB_COLLECTION_NAME = "followed";
const FOLLOWERS_SUB_COLLECTION_NAME = "followers";

class FollowController{
  final UserController _userController = UserController();
  final db = FirebaseFirestore.instance;

  void followUser({required DocumentReference targetUserRef}) async {
    final myUid = _userController.uid;
    final targetUid = targetUserRef.id;

    db
      .collection("$USERS_TABLE_COLLECTION_NAME/$targetUid/$FOLLOWERS_SUB_COLLECTION_NAME")
      .doc(myUid)
      .set({
        FollowTableColumn.USER_REF.name: _userController.userRef,
      });

    db
      .collection("$USERS_TABLE_COLLECTION_NAME/$myUid/$FOLLOWED_SUB_COLLECTION_NAME")
      .doc(targetUid)
      .set({
        FollowTableColumn.USER_REF.name: targetUserRef,
      });
  }

  void deleteUserFromFollow({required DocumentReference targetUserRef}){
    final myUid = _userController.uid;
    final targetUid = targetUserRef.id;

    db
      .collection("$USERS_TABLE_COLLECTION_NAME/$targetUid/$FOLLOWERS_SUB_COLLECTION_NAME")
      .doc(myUid)
      .delete();

    db
      .collection("$USERS_TABLE_COLLECTION_NAME/$myUid/$FOLLOWED_SUB_COLLECTION_NAME")
      .doc(targetUid)
      .delete();
  }
}

enum FollowTableColumn{
  USER_REF,
}
