import 'package:emilyretailerapp/TabsScreen/homescreen.dart';
import 'package:emilyretailerapp/TabsScreen/morescreen.dart';
import 'package:emilyretailerapp/TabsScreen/payoutscreen.dart';
import 'package:emilyretailerapp/TabsScreen/scanScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Utils/ColorTools.dart';
import '../Utils/PixelTools.dart';

class tabbartController extends StatefulWidget {
  tabbartController({Key? key}) : super(key: key);

  @override
  State<tabbartController> createState() => _tabbart_Controller_State();
}

class _tabbart_Controller_State extends State<tabbartController> {
  List<Widget> data = [
    homeScreen(),
    PayoutsScreen(),
    ScanScreen(),
    MoreScreen()
  ];

  @override
  Widget build(BuildContext context) {
    PixelTools.init(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: const Color(ColorTools.navigationBarColor),
        inactiveColor: Color(0xFFA9A9A9),
        height: 60,
        iconSize: 35,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_dollar),
            label: 'Payouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.qrcode),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          )
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return data[index];
          },
        );
      },
    );
  }
}
