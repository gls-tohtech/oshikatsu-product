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
    final resitry = AdResistry();
    final ad = Ad(
      creater: "rerurate", 
      imageUrl: "https://firebasestorage.googleapis.com/v0/b/fir-test-58395.appspot.com/o/DL%2FGCG_hGObAAAziDK.jpg?alt=media&token=642b8e45-1802-4a59-af01-2e4eef5b9643",
      title: "これはテスト",
      detail: "vefjk enufviusfhuvewfuivwehgweuvgfwuvfe",
      totalMoneyAmount: 214124,
      targetMoneyAmount: 43243, 
      deadline: DateTime(12,3,1,3), 
      creaters: ["dwa","cewf"], 
      createrNumbers: 2,
      targetIdol: "reru",
      targetPlatform: "X", 
      category: ["32dwa","342f","fewa"],
      hashtag: ["3429ifd3","fewiueo","fves f"], 
      aiders: ["xaw","few","fes"],
      aiderNumbers: 3
    );

    resitry.add(newAdData: ad);
  });
}