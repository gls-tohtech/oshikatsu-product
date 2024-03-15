import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:oshikatsu_product/models/users/UserStore.dart';

extension convertRefFromUserEx on List<types.User>{
  List<DocumentReference> convertRefFromUser(){
    final List<types.User> users = this;
    List<DocumentReference> usersRef = [];

    for(types.User user in users){
      final userRef = FirebaseFirestore.instance.collection(USERS_TABLE_COLLECTION_NAME).doc(user.id);
      usersRef.add(userRef);
    }

    return usersRef;
  }
}