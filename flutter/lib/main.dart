import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oshikatsu_product/controllers/UserController.dart';
import 'package:oshikatsu_product/firebase_options.dart';
import 'package:oshikatsu_product/models/users/UserAuthInfo.dart';
import 'package:oshikatsu_product/screens/fragments/chatRoomFragment/room.dart';
import 'package:oshikatsu_product/screens/fragments/loginFragment.dart';
import 'package:oshikatsu_product/screens/pages/homeUI.dart';
import 'package:oshikatsu_product/screens/pages/myPageUI.dart';
import 'package:oshikatsu_product/screens/pages/supportUI.dart';
import 'package:oshikatsu_product/screens/pages/swipeUI.dart';
import 'package:oshikatsu_product/settings/appColors.dart';
import 'package:oshikatsu_product/widgets/spSuccessPopup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // try {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8088);
  //   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //   FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  // } catch (e) {
  //   // ignore: avoid_print
  //   print(e);
  // }

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
  final _userController = UserController();
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SwipeUI(),
    const SupportUI(),
    MyPageUI()
  ];

  void initState() {
    super.initState();
    //if(!_userController.isLogin) _moveLoginFragment();
  }

  void _moveLoginFragment(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return const LoginFragment();
    }));
  }

  void _onItemTapped(int indexArg) {
    setState(() {
      _currentPageIndex = indexArg;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!_userController.isLogin) _moveLoginFragment();
    });
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red, // 背景色を赤に設定
        selectedItemColor: AppColors().primaryColor,
        unselectedItemColor: Colors.black,
        currentIndex: _currentPageIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "ホーム"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hail),
            label: "みんなの推し広告"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: "応援"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "マイページ"
          ),
        ],
      ),
    );
  }
}
