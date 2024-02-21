import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oshikatsu_product/firebase_options.dart';
import 'package:oshikatsu_product/models/ads/ad.dart';
import 'package:oshikatsu_product/models/ads/adStore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  test("ad-store", () {
    final resitry = AdRegistry();
    final ad = Ad(
      creater: "rerurate", 
      imageUrl: "https://firebasestorage.googleapis.com/v0/b/fir-test-58395.appspot.com/o/DL%2FGCG_hGObAAAziDK.jpg?alt=media&token=642b8e45-1802-4a59-af01-2e4eef5b9643",
      title: "これはテストAdfs",
      detail: "f ewf ewf ewf ew fwe fewf ",
      totalMoneyAmount: 100000,
      targetMoneyAmount: 10000, 
      deadline: DateTime(2024,12,31), 
      creaters: ["dwa","cewf"], 
      targetIdol: "reru",
      targetPlatform: "X, Instagram", 
      category: ["32dwa","342f","fewa"],
      hashtag: ["3429ifd3","fewiueo","fves f", "dawd"], 
      aiders: ["xaw","few","fes"],
      created: Timestamp.now()
    );

    resitry.add(newAdData: ad);
  });
}