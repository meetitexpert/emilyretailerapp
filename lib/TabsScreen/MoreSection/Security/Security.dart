// ignore_for_file: prefer_const_constructors

import 'package:emilyretailerapp/TabsScreen/MoreSection/Security/SecurityVerification.dart';
import 'package:emilyretailerapp/Utils/ConstTools.dart';
import 'package:emilyretailerapp/localAuth/local_auth.dart';
import 'package:flutter/material.dart';

class Security extends StatefulWidget {
  const Security({Key? key}) : super(key: key);

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  List<String> options = ['Turn Off 2SSV'];
  int selectedOption = 0;
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkBiometricAvailable();

    options.add('Activate SMS 2SSV');
    options.add('Activate Email 2SSV');
    options.add('Activate Mobile Authenticator App 2SSV');
  }

  void checkBiometricAvailable() async {
    bool value = await LocalAuth.hasBiometric();
    _isBiometricAvailable = value;
    if (_isBiometricAvailable) {
      if (options.length > 1) {
        options.insert(1, 'Activate Biometric 2SSV');
        setState(() {});
      }
    }
  }

  void securityEnableWithTouchId(BuildContext context) async {
    debugPrint('TOUCHID');
    final isAuthenticated = await LocalAuth.authenticate();
    if (isAuthenticated) {
      debugPrint('VERIFIED');
      selectedOption = 1;
      ConstTools.prefs
          ?.setString('selectedSecurityOption', options[selectedOption]);
      setState(() {});
    } else {
      debugPrint('NO VERIFIED');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2-Step Security Vefification')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(children: [
          Text(
            'Add an extra layer of security to protect your account',
            softWrap: true,
            style: TextStyle(
                color: Colors.black26,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'It is an optional security feature for when you sign in through EMILY Retailer Portal. You’ll get an alert to your registered mobile phone on file for every sign-in attempt. You’ll be asked to allow the sign in by using 2-step security verification (2SSV) on your EMILY app. This 2-step security help us know that it\'s really you who sign in to the portal.',
            softWrap: true,
            style: TextStyle(color: Colors.black, fontSize: 15),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black26)),
            padding: EdgeInsets.all(1),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    minLeadingWidth: 5,
                    leading: (ConstTools.prefs
                                    ?.getString('selectedSecurityOption') ==
                                null &&
                            index == 0)
                        ? Icon(Icons.radio_button_on_outlined)
                        : (Icon(options[index] ==
                                ConstTools.prefs
                                    ?.getString('selectedSecurityOption')
                            ? Icons.radio_button_on_outlined
                            : Icons.radio_button_off_outlined)),
                    title: Text(options[index]),
                    onTap: () {
                      if (index == selectedOption) {
                        return;
                      }

                      if (index == 0) {
                        selectedOption = index;
                        ConstTools.prefs?.setString(
                            'selectedSecurityOption', options[index]);
                        setState(() {});
                        return;
                      }

                      if (index == 1 && _isBiometricAvailable) {
                        securityEnableWithTouchId(context);
                        return;
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecurityVerification(
                                    selectedOption: options[index] ==
                                            'Activate Email 2SSV'
                                        ? "Email"
                                        : options[index] == 'Activate SMS 2SSV'
                                            ? "SMS"
                                            : "Mobile Authenticator App",
                                  ))).then((value) => {
                            if (value != null)
                              {
                                setState(() {
                                  // Call setState to refresh the page.
                                  selectedOption = index;
                                  ConstTools.prefs?.setString(
                                      'selectedSecurityOption', options[index]);
                                })
                              }
                          });
                    },
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
