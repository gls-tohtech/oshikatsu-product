import 'package:cloud_firestore/cloud_firestore.dart';
import './UserProfile.dart';

const USERS_TABLE_COLLECTION_NAME = "users";

///このデータベースでのdocumentId(uid)はFirebase Authenticationで取得できるuidとなる。
class UserStoreInfo{
  late final String _uid;
  late final UserProfile _profile;

  late final Map<String, dynamic> _dbProcessedMap;

  String get uid => _uid;
  Map<String, dynamic> get dbProcessedMap => _profile.dbProcessedMap; 

  UserStoreInfo({
    required String uidArg,
    required UserProfile profileArg
  }){
    _uid = uidArg;
    _profile = profileArg;
  }
}

class UserResistry{
  final db = FirebaseFirestore.instance;

  Future add({required UserStoreInfo newUserDataArg}) async{
    await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(newUserDataArg.uid)
      .set(newUserDataArg.dbProcessedMap);
  }

  Future update({required UserStoreInfo newUserDataArg, required UserTableColumn columnArg}) async{
    await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(newUserDataArg.uid)
      .update(newUserDataArg.dbProcessedMap);
  }
}

class UserDataFetcher{
  final db = FirebaseFirestore.instance;

  ///Mapデータを取得するときは、取得した変数[UsersTableColumn.カラム名（データベースの項目名）.name]と記述する。
  Future<Map<String, dynamic>> fetch({required String targetUidArg}) async{
    final fetchedUser = await db
      .collection(USERS_TABLE_COLLECTION_NAME)
      .doc(targetUidArg)
      .get();

    return fetchedUser.data() ?? {};
  }
}