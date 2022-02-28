import 'package:flutter/material.dart';

class LoginVc extends StatefulWidget {
  const LoginVc({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LoginVc> createState() => _LoginVcState(email: "", pasword: '');
}

class _LoginVcState extends State<LoginVc> {
  _LoginVcState({required this.email, required this.pasword});

  String email;
  String pasword;

  TextStyle fontStyleSettings(double size) {
    return TextStyle(
      color: Colors.white,
      fontSize: size,
    );
  }

  void login(BuildContext context) {
    if (email.isEmpty) {
      return;
    }

    if (pasword.isEmpty) {
      return;
    }
  }

  void showAlertWithMessage(String msg) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 200,
            ),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
                labelText: 'Username',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                pasword = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
                labelText: 'Password',
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              width: 280,
              height: 40,
              child: TextButton(
                onPressed: (() => login(context)),
                child:
                    Text('Sign in to my account', style: fontStyleSettings(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
