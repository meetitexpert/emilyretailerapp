import 'package:emilyretailerapp/TabsScreen/homescreen.dart';
import 'package:emilyretailerapp/TabsScreen/morescreen.dart';
import 'package:emilyretailerapp/TabsScreen/payoutscreen.dart';
import 'package:flutter/material.dart';

class TabsController extends StatefulWidget {
  const TabsController({Key? key}) : super(key: key);

  @override
  _TabsControllerState createState() => _TabsControllerState();
}

class _TabsControllerState extends State<TabsController>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Color(0xFFE8E8E8),
          child: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Color(0xFFA9A9A9),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Color(0xFFE8E8E8),
              controller: _controller,
              tabs: const  <Widget>[
                Tab(
                  text: 'Home',
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: 'Payouts',
                  icon: Icon(Icons.payment_outlined),
                ),
                Tab(
                  text: 'More',
                  icon: Icon(Icons.more_horiz),
                ),
              ]),
        ),
        body: TabBarView(controller: _controller, children: const <Widget>[
          homeScreen(),
          PayoutsScreen(),
          MoreScreen(),
        ]),
      ),
    );
  }
}
