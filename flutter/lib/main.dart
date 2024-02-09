import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/firebase_options.dart';
import 'package:oshikatsu_product/widgets/adListItemComponent/adListItemCom.dart';
import 'package:oshikatsu_product/widgets/spSuccessPopup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child:  MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPageIndex = 0;

  List<Widget> _pages = [
    AdListItem(adId: "rerurate:これはテスト:Timestamp(seconds=1707152278, nanoseconds=366325000)",),
    SPSucecssPopupComponent(),
    Text("submit"),
    Text("support"),
    Text("profile"),
  ];

  void _onItemTapped(int indexArg){
    setState(() {
      _currentPageIndex = indexArg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_currentPageIndex],),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "ホーム"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "検索"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "投稿"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: "応援広告"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "マイページ"
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
      ),
    );
  }
}