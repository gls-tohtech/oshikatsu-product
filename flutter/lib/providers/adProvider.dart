import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/models/ads/ad.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final adsRef = firestore.collection(ADS_TABLE_COLLECTION_NAME);

final adStreamProvider = StreamProvider.autoDispose.family((ref, String adId){
  final adsSnapshot = adsRef.doc(adId).snapshots();
  final ad = 
    adsSnapshot.map((snapshot) => 
      Ad.fromMap(snapshot.data() ?? {})
    );

  return ad;
});

final adsStreamProvider = StreamProvider.autoDispose((ref){
  final adsSnapshot = adsRef.snapshots();
  final ads = 
    adsSnapshot.map((querySnapshot) => querySnapshot.docs.map((doc){
      return Ad.fromMap(doc.data());
    }).toList());

  return ads;
});