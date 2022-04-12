import 'package:emilyretailerapp/TabsScreen/TabBarController.dart';
import 'package:emilyretailerapp/Utils/AppTools.dart';
import 'package:emilyretailerapp/Utils/ConstTools.dart';
import 'package:emilyretailerapp/Utils/DeviceTools.dart';
import 'package:flutter/material.dart';
import 'package:emilyretailerapp/Intro_vc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppTools.init();
  DeviceTools.init();
  ConstTools.prefs = await SharedPreferences.getInstance();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        '/loginVc': (context) => const IntroVC(),
        '/tabbarVc': (context) => tabbartController(),
      },
      home: (ConstTools.prefs?.getBool(ConstTools.spUserAuthorization) == true)
          ? tabbartController()
          : const IntroVC(),
    );
  }
}
