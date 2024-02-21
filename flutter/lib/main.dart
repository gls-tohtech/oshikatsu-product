import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/firebase_options.dart';
import 'package:oshikatsu_product/models/users/UserAuthInfo.dart';
import 'package:oshikatsu_product/models/users/UserProfile.dart';
import 'package:oshikatsu_product/screens/fragments/chatRoomFragment/room.dart';
import 'package:oshikatsu_product/screens/pages/homeUI.dart';
import 'package:oshikatsu_product/screens/pages/myPageUI.dart';
import 'package:oshikatsu_product/screens/pages/submitUI.dart';
import 'package:oshikatsu_product/widgets/adListItemComponent/adListItemCom.dart';
import 'package:oshikatsu_product/widgets/spSuccessPopup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    ));
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
    HomePage(),
    SPSucecssPopupComponent(),
    Text("Submit"),
    RoomsPage(),
    MyPage(),
  ];

  void initState(){
    final _userController = UserController(); 

    var userAuthInfo = UserAuthInfo(
        "rerurateyuto@gmail.com", 
        "qwertyuiop"
    );

    _userController.signInWithEmailAndPassWord(userAuthInfo: userAuthInfo);
    super.initState();
  }

  void _onItemTapped(int indexArg) {
    setState(() {
      _currentPageIndex = indexArg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "ホーム"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "検索"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "投稿"),
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: "応援広告"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "マイページ"),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
      ),
    );
  }
}
