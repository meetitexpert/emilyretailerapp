// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emilyretailerapp/Utils/ColorTools.dart';
import 'package:emilyretailerapp/Utils/DialogTools.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SecurityVerification extends StatefulWidget {
  late String selectedOption = '';
  SecurityVerification({Key? key, required this.selectedOption})
      : super(key: key);

  @override
  State<SecurityVerification> createState() =>
      _SecurityVerificationState(sOption: selectedOption);
}

class _SecurityVerificationState extends State<SecurityVerification> {
  String sOption = '';

  _SecurityVerificationState({required this.sOption});

  Widget pinCodefields() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: PinCodeTextField(
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            disabledColor: Colors.white,
            // selectedColor: Color(ColorTools.navigationBarColor),
            selectedFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            inactiveColor: Color(ColorTools.navigationBarColor)),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        onCompleted: (v) {
          print("Completed");
          if (v == '123456') {
            Navigator.pop(context, '1');
          } else {
            DialogTools.alertDialg(
                'Ok', '', 'Entered code is not valid', context);
          }
        },
        onChanged: (value) {
          print(value);
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
        appContext: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2-Step Security PIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Text('Enter the PIN you received via $sOption',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 5,
          ),
          pinCodefields(),
          SizedBox(
            height: 5,
          ),
          MaterialButton(
            child: Text('I Didn\'t Get a PIN'),
            onPressed: () {},
            color: Color(ColorTools.primaryColor),
            textColor: Colors.white,
          )
        ]),
      ),
    );
  }
}
