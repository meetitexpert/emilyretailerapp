import 'package:emilyretailerapp/Utils/AppTools.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appversion = AppTools.appVersion;

    return Scaffold(
      appBar: AppBar(title: const Text("About App")),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            'Current version :$appversion',
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
            ),
          ),
        ]),
      ),
    );
  }
}
