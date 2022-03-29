import 'dart:convert';

import 'package:emilyretailerapp/Utils/ConstTools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../EmilyNewtworkService/Entity.dart';
import 'DialogTools.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:emilyretailerapp/Model/LoginEntity.dart';

enum HttpErrorType {
  httpTimeout,

  httpException,

  unknowmHost,

  parserException,

  noConnections,
}

class Constants extends State {
  static SharedPreferences? prefs;

  static bool showingHud = false;

  bool checkHttpError(
      BuildContext context, HttpErrorType? error, dynamic result) {
    if (error != null) {
      if (error == HttpErrorType.noConnections) {
        DialogTools.alertDialg(
            "OK",
            "",
            "You don’t seem to be connected to the Internet. Please try again later.\nError Code: 100",
            context);
        return false;
      } else if (error == HttpErrorType.unknowmHost) {
        DialogTools.alertDialg(
            "OK",
            "",
            "Sorry, we are experiencing network problem. Please try again later.\nError Code: 101",
            context);
        return false;
      } else if (error == HttpErrorType.httpTimeout) {
        DialogTools.alertDialg(
            "OK",
            "",
            "Sorry, we are experiencing request time out at this time. Please try again later.\nError Code: 102",
            context);
        return false;
      } else if (error == HttpErrorType.parserException) {
        DialogTools.alertDialg(
            "OK",
            "",
            "Sorry, we are experiencing technical difficulty. Please try again later.\nError Code: 103",
            context);
        return false;
      } else if (error == HttpErrorType.httpException) {
        DialogTools.alertDialg(
            "OK",
            "",
            "Sorry, we are experiencing http ${result} issue at this time. Please try again later.\nError Code: 104",
            context);
        return false;
      }
    }

    return true;
  }

  bool checkEntity(Entity? entity, BuildContext context) {
    if (entity == null || entity.status != "0") {
      DialogTools.alertDialg(
          "OK",
          "",
          "Sorry, we are experiencing technical difficulty. Please try again later.\nError Code: 103",
          context);
      return false;
    }

    return true;
  }

  showHud({String message = "Loading..."}) {
    if (!showingHud) {
      final progress = ProgressHUD.of(context);
      progress?.showWithText(message);
      showingHud = true;
    }
  }

  dismissHud() {
    if (showingHud) {
      final progress = ProgressHUD.of(context);
      progress?.dismiss();
      showingHud = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
