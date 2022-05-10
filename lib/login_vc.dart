import 'dart:convert';

import 'package:emilyretailerapp/Model/LoginEntity.dart';
import 'package:emilyretailerapp/TabsScreen/TabBarController.dart';
import 'package:emilyretailerapp/Utils/AppTools.dart';
import 'package:emilyretailerapp/Utils/ConstTools.dart';
import 'package:emilyretailerapp/Utils/DeviceTools.dart';
import 'package:emilyretailerapp/Utils/DialogTools.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:email_validator/email_validator.dart';
import 'package:dio/dio.dart';
import 'package:emilyretailerapp/EmilyNewtworkService/NetworkSerivce.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';

class LoginVc extends StatefulWidget {
  const LoginVc({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LoginVc> createState() => _LoginVcState(email: "", pasword: '');
}

class _LoginVcState extends State<LoginVc> {
  _LoginVcState({
    required this.email,
    required this.pasword,
  });

  String email;
  String pasword;

  bool _visible = false;

  @override
  void initState() {
    super.initState();

    //get tracking id if empty
    final trackingID = ConstTools.prefs?.getString(ConstTools.spTrackingId);
    if (trackingID == null || trackingID == "") {
      getTrackingID();
    }
  }

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

    if (!EmailValidator.validate(email)) {
      showAlert(
          'The email address does not appear to be valid. Make sure you enter a valid email address.',
          context);
      return;
    }
    if (pasword.isEmpty) {
      showAlert('Please enter your password', context);
      return;
    }

    loginWithEmail(email, pasword);
  }

  Future loginWithEmail(String email, String pwd) async {
    Response response;
    HttpService http = HttpService();

    String md5Password = md5.convert(utf8.encode(pwd)).toString();
    showhideProgressHud(true);
    Map<String, dynamic> params = {
      "user_name": email,
      "password": md5Password,
      "role": "21"
    };

    try {
      response = await http.postRequest(
          ConstTools.path + ConstTools.apiUserLogin, params, context);
      if (response.statusCode == 200) {
        debugPrint("$response");
        showhideProgressHud(false);
        if (response.data["status"] == "0") {
          LoginEntity loginUser = LoginEntity.fromJson(response.data);

          ConstTools.prefs?.setBool(ConstTools.spUserAuthorization, true);
          String user = jsonEncode(loginUser);
          //save the user data into sharedPreferences using key-value pairs
          ConstTools.prefs?.setString(ConstTools.spUser, user);

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => tabbartController()));
        } else if (response.data["status"] == "10247") {
          String desc = response.data["details"]["description"];
          DialogTools.alertDialg("Ok", "", desc, context);
        }
      } else {
        debugPrint('some thing went wrong');
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getTrackingID() async {
    Response response;
    HttpService http = HttpService();
    //String params = "device_type=iPhone&app_version=1&device_pin=123&device_os=iOS&access_token=09b16acba64e1929875605b3c657404e&device_os_version=1&device_model=234&device_make=Apple";
    Map<String, dynamic> params = {
      "device_type": DeviceTools.deviceModel,
      "app_version": AppTools.appVersion,
      "device_pin": DeviceTools.devicePin,
      "device_os": DeviceTools.deviceMake,
      "device_os_version": DeviceTools.osVersion,
      "device_model": DeviceTools.deviceModel,
      "device_make": DeviceTools.deviceMake
    };

    try {
      response = await http.postRequest(
          ConstTools.path + ConstTools.apiGetTrackingId, params, context);
      if (response.statusCode == 200) {
        debugPrint("$response");
        if (response.data["status"] == "0") {
          ConstTools.prefs
              ?.setString(ConstTools.spTrackingId, response.data["trackingId"]);
        }
      } else {
        debugPrint('some thing went wrong');
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  void showhideProgressHud(bool isallow) {
    setState(() {
      _visible = isallow;
    });
  }

  void showAlert(String msg, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(msg),
        actions: [
          ElevatedButton(
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
            padding: const EdgeInsets.only(left: 5, right: 5),
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
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 2),
              child: Center(
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your email',
                    // contentPadding: EdgeInsets.only(bottom: 15.0)
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
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
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 2),
              child: Center(
                child: TextField(
                  onChanged: (value) {
                    pasword = value;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your password',
                    // contentPadding: EdgeInsets.only(bottom: 15.0)
                  ),
                  autofillHints: const [AutofillHints.password],
                  onEditingComplete: () => TextInput.finishAutofillContext(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget progressHud() {
    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _visible,
        child: Container(
            margin: EdgeInsets.only(top: 50, bottom: 30),
            child: CircularProgressIndicator()));
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
        child: Stack(
          children: [
            Center(child: progressHud()),
            ListView(
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
            )
          ],
        ),
      ),
    );
  }
}
