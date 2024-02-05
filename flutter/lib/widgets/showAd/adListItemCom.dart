import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/ads/ad.dart';
import 'package:oshikatsu_product/providers/adProvider.dart';
import 'adListItemGoalCom.dart';
import 'adListItemImgCom.dart';
import 'adListItemNumbersCom.dart';
import 'adListItemHashtagCom.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdList extends ConsumerStatefulWidget {
  const AdList({super.key});

  @override
  _AdListItemState createState() => _AdListItemState();
}

class _AdListItemState extends ConsumerState<AdList> {
  late final Function() _adTappedCallback = () {}; 

  @override
  Widget build(BuildContext context) {
    final streamProv = ref.watch(adStreamProvider);
    return Scaffold(
      body: streamProv.when(
        data: (List<Ad> ad){
          return buildAdList(context, ad);
        }, error:((error, stackTrace) {
          return Text("error = \n${error.toString()}");
        }), 
        loading: () => Container()
      )
    );
  }

  Widget buildAdList(BuildContext context, List<Ad> ad){
    return SingleChildScrollView(
      child: Column(
        children: [
          for(var ele in ad) buildAdListItem(context, ele),
        ],
      )
    );
  }

  Widget buildAdListItem(BuildContext context, Ad ad){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.277,
      child: Card(
        elevation: 8,
        child: InkWell(
          onTap: _adTappedCallback(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal:size.width * 0.018),
                child: Text(
                  ad.dbProcessedMap[AdTableColumn.AD_TITLE.name],
                  textScaler: const TextScaler.linear(1.5),
                ),
              ),
              AdListItemHashtagListComponent(ad.dbProcessedMap[AdTableColumn.AD_HASHTAG.name].split(","),),
              Padding(padding: EdgeInsets.all(size.height * 0.01)),
              Row(
                children: [
                  AdListItemImgComponent(ad.dbProcessedMap[AdTableColumn.AD_IMAGE_URL.name],),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdListItemGaolComponent(
                          ad.dbProcessedMap[AdTableColumn.AD_TARGET_MONEY_AMOUNT.name], 
                          ad.dbProcessedMap[AdTableColumn.AD_TOTAL_MONEY_AMOUNT.name],
                        ),
                        AdListItemNumberesConponent(
                          ad.dbProcessedMap[AdTableColumn.AD_AIDER_NUMBERS.name], 
                          ad.dbProcessedMap[AdTableColumn.AD_CREATER_NUMBERS.name],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}