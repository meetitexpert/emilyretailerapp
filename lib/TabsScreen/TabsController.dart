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
              tabs: <Widget>[
                _individualTab(const Icon(Icons.home), "home"),
                _individualTab(const Icon(Icons.payment_outlined), "Payouts"),
                const Tab(
                  icon: Icon(Icons.more_horiz),
                  text: "More",
                )
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

  Widget _individualTab(Icon icon, String title) {
    return Container(
      // height: 50 + MediaQuery.of(context).padding.bottom,
      padding: const EdgeInsets.only(right: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid))),
      child: Tab(
        icon: icon,
        text: title,
      ),
    );
  }
}
