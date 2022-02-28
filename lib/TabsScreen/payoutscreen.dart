import 'package:flutter/material.dart';

class PayoutsScreen extends StatefulWidget {
  const PayoutsScreen({Key? key}) : super(key: key);

  @override
  _PayoutsScreenState createState() => _PayoutsScreenState();
}

class _PayoutsScreenState extends State<PayoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payouts'),
        automaticallyImplyLeading: false,
      ),
      body: Center(child: const Text('Pyouts screen')),
    );
  }
}
