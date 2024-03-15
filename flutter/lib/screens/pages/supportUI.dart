import 'package:flutter/material.dart';
import 'package:oshikatsu_product/screens/fragments/submitFragment.dart';
import 'package:oshikatsu_product/widgets/relatedProjectList.dart';

class SupportUI extends StatefulWidget {
  const SupportUI({Key? key}) : super(key: key);

  @override
  State<SupportUI> createState() => _SupportUIState();
}

class _SupportUIState extends State<SupportUI>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '投稿一覧', icon: Icon(Icons.list)),
            Tab(text: '投稿作成', icon: Icon(Icons.create)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          RelatedProjectList(),
          SubmitFragment()
        ],
      ),
    );
  }
}

