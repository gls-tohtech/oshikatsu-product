import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/ad.dart';
import 'package:oshikatsu_product/providers/adProvider.dart';
import 'showAdGoalCom.dart';
import 'showAdImgCom.dart';
import 'showAdNumbersCom.dart';
import 'showAdHashtagCom.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowAdComponent extends StatelessWidget{
  late final String _title;
  late final List<String> _hashtags;
  late final String _imageUrl;
  late final int _targetMoneyAmount;
  late final int _totalMoneyAmount;
  late final int _aiderNumbers;
  late final int _createrNumbers;
  late final Function() _adTappedCallback; 

  ShowAdComponent({
    required String title,
    required List<String> hashtagList,
    required String imageUrl,
    required int targetMoneyAmount,
    required int totalMoneyAmount,
    required int aiderNumbers,
    required int createrNumbers,
    required Function() adTappedCallback,
  }){
    _title = title;
    _hashtags = hashtagList;
    _imageUrl = imageUrl;
    _targetMoneyAmount = targetMoneyAmount;
    _totalMoneyAmount = totalMoneyAmount;
    _aiderNumbers = aiderNumbers;
    _createrNumbers = createrNumbers;
    _adTappedCallback = adTappedCallback;
  }

  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      child: InkWell(
        onTap: _adTappedCallback,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal:size.width * 0.018),
              child: Text(
                _title,
                textScaler: const TextScaler.linear(1.5),
              ),
            ),
            ShowAdHashtagListComponents(_hashtags),
            Padding(padding: EdgeInsets.all(size.height * 0.01)),
            Row(
              children: [
                ShowAdImgComponent(_imageUrl),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShowAdGaolComponent(
                        _targetMoneyAmount, 
                        _totalMoneyAmount
                      ),
                      ShowAdNumberesConponent(
                        _aiderNumbers, 
                        _createrNumbers
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AdListItem extends ConsumerStatefulWidget {
  const AdListItem({super.key});

  @override
  _AdListItemState createState() => _AdListItemState();
}

class _AdListItemState extends ConsumerState<AdListItem> {
  @override
  Widget build(BuildContext context) {
    final streamProv = ref.watch(adStreamProvider("fznuhCFMZjll7svAytxM"));
    return Scaffold(
      body: streamProv.when(
        data: (List<Ad> ad){
          return Text(ad[0].adId);
        }, error:((error, stackTrace) {
          return Text(error.toString());
        }), 
        loading: () => Container()
      )
    );
  }

  // Widget buildComponent(BuildContext context, ){
  //   final Size size = MediaQuery.of(context).size;
  //   return Card(
  //     elevation: 8,
  //     child: InkWell(
  //       onTap: _adTappedCallback(),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.symmetric(horizontal:size.width * 0.018),
  //             child: Text(
  //               _title,
  //               textScaler: const TextScaler.linear(1.5),
  //             ),
  //           ),
  //           ShowAdHashtagListComponents(_hashtags),
  //           Padding(padding: EdgeInsets.all(size.height * 0.01)),
  //           Row(
  //             children: [
  //               ShowAdImgComponent(_imageUrl),
  //               Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     ShowAdGaolComponent(
  //                       _targetMoneyAmount, 
  //                       _totalMoneyAmount
  //                     ),
  //                     ShowAdNumberesConponent(
  //                       _aiderNumbers, 
  //                       _createrNumbers
  //                     )
  //                   ],
  //                 ),
  //               )
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}