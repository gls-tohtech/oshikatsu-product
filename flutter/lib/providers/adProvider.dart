import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/models/ad.dart';

final FirebaseFirestore firesotre = FirebaseFirestore.instance;
final adsRef = firesotre.collection(ADS_TABLE_COLLECTION_NAME);

final adStreamProvider = StreamProvider.autoDispose.family((ref, String adId) {
  final ads = adsRef.where('adId', isEqualTo: adId).snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((doc) => Ad.fromMap(doc.data())).toList();
  });
  return ads;
});
