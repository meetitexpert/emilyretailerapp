import 'package:emilyretailerapp/TabsScreen/TabsController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'TabsScreen/homescreen.dart';

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
      showAlert('Please enter your email', context);
      return;
    }

    if (!EmailValidator.validate(email)){
      showAlert('The email address does not appear to be valid. Make sure you enter a valid email address.', context);
      return;
    }
    if (pasword.isEmpty) {
      showAlert('Please enter your password', context);
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => const TabsController(),));

  }

  void showAlert(String msg, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(''),
        content: Text(msg),
        actions: [
          TextButton(
              onPressed: (() => {Navigator.of(context).pop()}),
              child: const Text('OK')),
        ],
      ),
    );
  }

  Widget emailTextInputField() {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Colors.grey)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Image.asset('images/icon-email.png'),
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 1,
            child: Container(
              width: 1,
              height: 30,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your email',
                      contentPadding: EdgeInsets.only(bottom: 15.0)),
                      keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pwdTextInputField() {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Colors.grey)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Image.asset('images/icon-lock.png'),
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 1,
            child: Container(
              width: 1,
              height: 30,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: TextField(
                  onChanged: (value) {
                    pasword = value;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your password',
                      contentPadding: EdgeInsets.only(bottom: 15.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
            emailTextInputField(),
            const SizedBox(
              height: 15,
            ),
            pwdTextInputField(),
            const SizedBox(
              height: 25,
            ),
            MaterialButton(
              onPressed: () => login(context),
              color: Colors.blue,
              height: 40,
              child: const Text(
                'Sign in to my account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
