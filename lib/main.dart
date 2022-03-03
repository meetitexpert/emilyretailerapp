import 'package:emilyretailerapp/TabsScreen/TabBarController.dart';
import 'package:emilyretailerapp/TabsScreen/TabsController.dart';
import 'package:emilyretailerapp/Utils/Constants.dart';
import 'package:emilyretailerapp/login_vc.dart';
import 'package:flutter/material.dart';
import 'package:emilyretailerapp/Intro_vc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  Constants.prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Emily Retailer',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      routes: <String, WidgetBuilder>{
        '/loginVc':(context) => const LoginVc(),
        '/tabVc':(context) => const TabsController(),
        '/tabbarVc':(context) => tabbartController(),
      },
      home: (Constants.prefs?.getBool("isUserLogedIn") == true) ? tabbartController() : const IntroVC(),
    );
  }
}


