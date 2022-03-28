import 'package:emilyretailerapp/TabsScreen/homescreen.dart';
import 'package:emilyretailerapp/TabsScreen/morescreen.dart';
import 'package:emilyretailerapp/TabsScreen/payoutscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class tabbartController extends StatefulWidget {
  tabbartController({Key? key}) : super(key: key);

  @override
  State<tabbartController> createState() => _tabbart_Controller_State();
}

class _tabbart_Controller_State extends State<tabbartController> {

  List<Widget> data = [homeScreen(), PayoutsScreen(), MoreScreen()];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Color(0xFFE8E8E8),
          inactiveColor: Color(0xFFA9A9A9),
          height: 50,
          iconSize: 30,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Payouts',
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
        });
  }
}
