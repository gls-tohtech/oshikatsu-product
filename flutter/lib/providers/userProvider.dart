import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';

import 'package:oshikatsu_product/models/users/Users.dart';

final FirebaseFirestore firesotre = FirebaseFirestore.instance;
final usersRef = firesotre.collection(USERS_TABLE_COLLECTION_NAME);

final userStreamProvider = StreamProvider.autoDispose((ref){
  final usersSnapshots = usersRef.snapshots();
  final users = 
    usersSnapshots.map((querySnapshot) => querySnapshot.docs.map((doc){
      return UserProfile.fromMap(doc.data());
    }).toList());

  return users;
});