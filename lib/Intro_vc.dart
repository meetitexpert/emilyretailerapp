import 'package:flutter/material.dart';
import 'package:emilyretailerapp/login_vc.dart';

class IntroVC extends StatelessWidget {
  const IntroVC({Key? key}) : super(key: key);

  TextStyle fontStyleSettings(double size, FontWeight weight) {
    return TextStyle(
      color: Colors.white, 
      fontSize: size, 
      fontWeight: weight,
      );
  }

  void loginWithEmail(BuildContext context) {
    debugPrint('EMILY');
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginVc()));
  }

  void loginWithTouchId(BuildContext context) {
    debugPrint('TOUCHID');
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
    return Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(color: Colors.blue),
              width: 280,
              height: 40,
              child: TextButton(
                onPressed: (() => loginWithTouchId(context)),
                child: Text('User Touch ID',
                    style: fontStyleSettings(16, FontWeight.w500),),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            
            Container(
              decoration: const BoxDecoration(color: Colors.blue),
              width: 280,
              height: 40,
              child: TextButton(
                onPressed: (() => loginWithEmail(context)),
                child: Text('Sign in with EMILY',
                    style: fontStyleSettings(16, FontWeight.w500),),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/emily-retailer.png'), fit: BoxFit.fill),
        ),
        child: ListView(
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
