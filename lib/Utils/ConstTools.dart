import 'dart:convert';

import 'package:emilyretailerapp/Model/LoginEntity.dart';
import 'package:emilyretailerapp/Utils/Constants.dart';
import 'package:flutter/material.dart';
import '../EmilyNewtworkService/Entity.dart';
import '../Utils/DialogTools.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

enum HttpErrorType {
  httpTimeout,

  httpException,

  unknowmHost,

  parserException,

  noConnections,
}

class ConstTools {
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

  LoginEntity retreiveSavedUserDetail() {
    String decodedUser = Constants.prefs?.getString(ConstTools.spUser)! ?? "";
    // Read the data, decode it and store it in map structure
    Map<String, dynamic> jsondatais = jsonDecode(decodedUser);
    //convert it into User object
    var user = LoginEntity.fromJson(jsondatais);

    return user;
  }
}
