import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';

import 'package:oshikatsu_product/models/users/Users.dart';

final FirebaseFirestore firesotre = FirebaseFirestore.instance;
final usersRef = firesotre.collection(USERS_TABLE_COLLECTION_NAME);

final userStreamProvider = StreamProvider.autoDispose.family((ref, String userId){
  final usersSnapshot = usersRef.doc(userId).snapshots();
  final user = 
    usersSnapshot.map((snapshot) => 
      UserProfile.fromMap(snapshot.data() ?? {})
    );

  return user;
});