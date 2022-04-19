import 'package:emilyretailerapp/localAuth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:emilyretailerapp/login_vc.dart';

import 'Utils/PixelTools.dart';

class IntroVC extends StatefulWidget {
  const IntroVC({Key? key}) : super(key: key);

  @override
  State<IntroVC> createState() => _IntroVCState();
}

class _IntroVCState extends State<IntroVC> {
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    checkBiometricAvailable();
  }

  void checkBiometricAvailable() async {
    bool value = await LocalAuth.hasBiometric();
    _isBiometricAvailable = value;
    setState(() {});
  }

  TextStyle fontStyleSettings(double size, FontWeight weight) {
    return TextStyle(
      color: Colors.white,
      fontSize: size,
      fontWeight: weight,
    );
  }

  void loginWithEmail(BuildContext context) {
    debugPrint('EMILY');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginVc()));
  }

  void loginWithTouchId(BuildContext context) async {
    debugPrint('TOUCHID');
    final isAuthenticated = await LocalAuth.authenticate();
    if (isAuthenticated) {
      debugPrint('VERIFIED');
    } else {
      debugPrint('NO VERIFIED');
    }
  }

  Widget textUnderLogo() {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 100),
      child: Text(
        'We help you manage your rewards points in one place.',
        style: fontStyleSettings(18, FontWeight.normal),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buttonsHandling(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(color: Colors.blue),
              width: 280,
              height: _isBiometricAvailable ? 40 : 0,
              child: TextButton(
                onPressed: (() => loginWithTouchId(context)),
                child: Text(
                  'User Touch ID',
                  style: fontStyleSettings(16, FontWeight.w500),
                ),
              ),
            ),
            _isBiometricAvailable
                ? const SizedBox(
                    height: 10,
                  )
                : const SizedBox(
                    height: 0,
                  ),
            Container(
              decoration: const BoxDecoration(color: Colors.blue),
              width: 280,
              height: 40,
              child: TextButton(
                onPressed: (() => loginWithEmail(context)),
                child: Text(
                  'Sign in with EMILY',
                  style: fontStyleSettings(16, FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PixelTools.init(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/emily-retailer.png'), fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //logo contatiner
            textUnderLogo(),
            //Buttons contatiner
            buttonsHandling(context)
          ],
        ),
      ),
    );
  }
}
