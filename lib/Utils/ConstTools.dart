import 'dart:convert';

import 'package:emilyretailerapp/Model/LoginEntity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import '../Intro_vc.dart';
import 'ColorTools.dart';

class ConstTools {
  static SharedPreferences? prefs;
  static bool showingHud = false;

  Widget getScaffold(Widget items) {
    return Scaffold(
        body: ProgressHUD(
            backgroundColor: const Color(ColorTools.primaryColor),
            backgroundRadius: const Radius.circular(8),
            padding: const EdgeInsets.all(24),
            child: Builder(builder: (context) => items)));
  }

/////////////////Multi devices login Error code.///////////////
  static const String multiDevicesErrorCode = "10293";
  static const String multiDevicesErrorCodeTwo = "120300";

////////////////////////////////////////////////////////////////////////////////
  static const String hostURL =
      "https://services.emilyrewards.com/RLP-Service/";

  static const String hostPortForStrip = ":3454/";
  static const String hostPortForImage = ":3471/images/";

  static const String path = "Resource/";
  static const String pathV2 = "ResourceV2/";
  static const String pathV3 = "ResourceV3/";

  static const String apiGetTrackingId = "GetTrackingId";
  static const String apiUserLogin = "RetailerUserLogin";
  static const String apiGetHomeRewards = "getHomeReward.mvc";
  static const String apiGetCustomersFeedbacks = "getSurveyQuestionAnswer.mvc";
////////////////////////////////////////////////////////////////////////////////
  static late double dpi;

  static late double screenWidth;
  static late double screenHeight;

  static late double screenTopBarHeight;
  static late double screenBottomBarHeight;
////////////////////////////////////////////////////////////////////////////////
  static const String spTrackingId = "SP_TRACKING_ID";
  static const String spUser = "SP_USER";
  static const String spUserId = "SP_USER_ID";
  static const String spUserEmail = "SP_USER_EMAIL";
  static const String spUserName = "SP_USER_NAME";
  static const String spUserAuthorization = "SP_USER_AUTHORIZATION";

  static const String spPartnerImage = "SP_PARTNER_IMAGE";
  static const String spCompanyName = "SP_COMPANY_NAME";
  static const String spLocationId = "SP_LOCATION_ID";
  static const String spStoreLocationId = "SP_STORE_LOCATION_ID";

  static const String spOfferId = "SP_OFFER_ID";

  ///////////////// Alert Dialog Messages///////////////////////

  static const String multiLoginMessage =
      "Your account is signed in on multiple devices. Please sign in again. \n Error Code: 10293";

  ////////////////////////////Buttons Labels//////////////////////////////////
  static const String buttonOk = "Ok";

  ///////////////// SignOut handling /////////////
  static signOutHandling(BuildContext context) {
    ConstTools.prefs?.setBool(ConstTools.spUserAuthorization, false);
    ConstTools.prefs?.setString(ConstTools.spUser, "");
    ConstTools.prefs?.setString(ConstTools.spTrackingId, "");
    Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => const IntroVC()));
  }

  LoginEntity retreiveSavedUserDetail() {
    String decodedUser = ConstTools.prefs?.getString(ConstTools.spUser)! ?? "";
    // Read the data, decode it and store it in map structure
    Map<String, dynamic> jsondatais = jsonDecode(decodedUser);
    //convert it into User object
    var user = LoginEntity.fromJson(jsondatais);

    return user;
  }

  showHud(BuildContext context, {String message = "Loading..."}) {
    if (!showingHud) {
      final progress = ProgressHUD.of(context);
      progress?.showWithText(message);
      showingHud = true;
    }
  }

  dismissHud(
    BuildContext context,
  ) {
    if (showingHud) {
      final progress = ProgressHUD.of(context);
      progress?.dismiss();
      showingHud = false;
    }
  }
}
