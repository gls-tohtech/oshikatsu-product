import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';

import 'package:oshikatsu_product/models/users/UserStore.dart';
import 'package:oshikatsu_product/models/users/roomUser.dart';

final FirebaseFirestore firesotre = FirebaseFirestore.instance;
final usersRef = firesotre.collection(USERS_TABLE_COLLECTION_NAME);
final roomUsersRef = firesotre.collection(ROOM_USERS_TABLE_COLLECTION_NAME);

final userStreamProvider = StreamProvider.autoDispose.family((ref, String userId){
  final usersSnapshot = usersRef.doc(userId).snapshots();
  final user = 
    usersSnapshot.map((snapshot) => 
      UserProfile.fromMap(snapshot.data() ?? {})
    );

  return user;
});

final roomUserStreamProvider = FutureProvider.autoDispose.family((ref, String userId){
  final roomUsersSnapshot = roomUsersRef.doc(userId).snapshots();
  final roomUser = 
    roomUsersSnapshot.map((snapshot) => 
      RoomUser.fromMap(
        idArg: userId, 
        mapArg: snapshot.data() ?? {}
      )
    );

  return roomUser;
});
