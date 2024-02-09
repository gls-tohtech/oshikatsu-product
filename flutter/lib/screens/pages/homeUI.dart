import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/models/ads/ad.dart';
import 'package:oshikatsu_product/providers/adProvider.dart';
import 'package:oshikatsu_product/widgets/adListItemComponent/adListItemCom.dart';
import 'package:oshikatsu_product/widgets/standardPadding.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> _adItems;

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return AdList();
  }
}

class AdList extends ConsumerStatefulWidget {
  const AdList({super.key});

  @override
  _AdListState createState() => _AdListState();
}

class _AdListState extends ConsumerState<AdList> {
  @override
  Widget build(BuildContext context) {
    final streamProv = ref.watch(adsStreamProvider);
    return Scaffold(
      body: streamProv.when(
        data: (List<Ad> ad){
          return SingleChildScrollView(
            child: Column(
              children: [
                for(Ad item in ad) Column(
                  children: [
                    StandartPaddingComponent(),
                    AdListItem(adId: item.adId),
                  ],
                )
              ],
            ),
          );
        }, error:((error, stackTrace) {
          return ;
        }), 
        loading: () => Container(),
      )
    );
  }
}

class AdRecommender{

}