import 'package:flutter/material.dart';
import '../Intro_vc.dart';
import '../Utils/ConstTools.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('More screen'),
            ElevatedButton(
                onPressed: () {
                  // Navigator.pushReplacementNamed(context, '/loginVc');
                  ConstTools.prefs
                      ?.setBool(ConstTools.spUserAuthorization, false);
                  ConstTools.prefs?.setString(ConstTools.spUser, "");
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(builder: (context) => const IntroVC()));
                },
                child: const Text('Sing out')),
          ],
        ),
      ),
    );
  }
}
