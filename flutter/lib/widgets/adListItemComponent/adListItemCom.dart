import 'package:flutter/material.dart';
import 'package:oshikatsu_product/models/ads/ad.dart';
import 'package:oshikatsu_product/providers/adProvider.dart';
import 'package:oshikatsu_product/screens/fragments/adDetailFragment/adDetailFragment.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';
import 'adListItemGoalCom.dart';
import 'adListItemImgCom.dart';
import 'adListItemNumbersCom.dart';
import 'adListItemHashtagCom.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdListItem extends ConsumerStatefulWidget {
  late final String _adId;

  AdListItem({required String adId}){
    _adId = adId;
  }

  @override
  _AdListItemState createState() => _AdListItemState(_adId);
}

class _AdListItemState extends ConsumerState<AdListItem> {
  late final String _adId;

  _AdListItemState(String adId){
    _adId = adId;
  }

  @override
  Widget build(BuildContext context) {
    final streamProv = ref.watch(adStreamProvider(_adId));
    return streamProv.when(
        data: (Ad ad){
          return buildAdListItem(context, ad);
        }, error:((error, stackTrace) {
          return Text("error = \n${error.toString()}");
        }), 
        loading: () => Container()
      );
  }

  Widget buildAdListItem(BuildContext context, Ad ad){
    final Size size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Card(
        color: Color.fromARGB(255, 255, 255, 255),
        elevation: 4,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return AdDetailFragment(
                ad: ad,
                bookmarkTapped: (){},
              );
            }));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StandartPaddingComponent(),
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
                          ad.dbProcessedMap[AdTableColumn.AD_AIDERS.name].length, 
                          ad.dbProcessedMap[AdTableColumn.AD_CREATERS.name].length,
                        )
                      ],
                    ),
                  )
                ],
              ),
              StandartPaddingComponent()
            ],
          ),
        ),
      ),
    );
  }
}