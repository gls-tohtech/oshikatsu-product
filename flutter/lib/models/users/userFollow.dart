import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oshikatsu_product/controllers/followController.dart';

class Follow {   
  final DocumentReference ref;

  factory Follow({required DocumentReference ref}) {
    return Follow._internal(ref: ref);
  }

  Follow._internal({required this.ref});

  factory Follow.fromMap({required Map<String, dynamic> mapArg}){
    return Follow(
      ref: mapArg[FollowTableColumn.USER_REF.name]
    );
  }
}

class Followed extends Follow {
  factory Followed.fromMap({required Map<String, dynamic> mapArg}){
    return Followed._internal(
      followed: mapArg[FollowTableColumn.USER_REF.name],
    );
  }

  Followed._internal({required DocumentReference followed})
    : super._internal(ref: followed);
}

class Followers extends Follow {
  factory Followers.fromMap({required Map<String, dynamic> mapArg}){
    return Followers._internal(
      followers: mapArg[FollowTableColumn.USER_REF.name],
    );
  }

  Followers._internal({required DocumentReference followers})
    : super._internal(ref: followers);
}