import 'package:emilyretailerapp/Utils/DialogTools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometric() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      // TODO
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometric();
    if (!isAvailable) {
      return false;
    }

    try {
      return await _auth.authenticate(
        localizedReason: 'Scan your fingerprint authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      // TODO
      debugPrint('$e');
      return false;
    }
  }
}
