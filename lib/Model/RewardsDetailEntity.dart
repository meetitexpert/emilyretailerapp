// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:emilyretailerapp/Model/Entity.dart';

class RewardsDetailEntity extends Entity {
  var appBackImgURL;
  var appFrontImgURL;
  var backImgURL;
  var cardColor;
  var earnPoints;
  var earnRate;
  var earnStamps;
  var fontColor;
  var frontImgURL;
  var keywords;
  var redeemPoints;
  var redeemRate;
  var redeemStamps;
  var redeemTC;
  var redeemValue;
  var rewardContentId;
  var rewardId;
  var rewardLongDescription;
  var rewardShortDescription;
  var rewardTC;
  var rewardType;
  var ruleFrequency;
  var ruleTime;
  var templateId;
  var templateType;
  var transactionAmount;

  RewardsDetailEntity.fromJson(Map<String, dynamic> json) {
    appBackImgURL = json["appBackImgURL"];
    appFrontImgURL = json["appFrontImgURL"];
    backImgURL = json["backImgURL"];
    cardColor = json["cardColor"];
    earnPoints = json["earnPoints"];
    earnRate = json["earnRate"];
    earnStamps = json["earnStamps"];
    fontColor = json["fontColor"];
    frontImgURL = json["frontImgURL"];
    keywords = json["keywords"];
    redeemPoints = json["redeemPoints"];
    redeemRate = json["redeemRate"];
    redeemStamps = json["redeemStamps"];
    redeemTC = json["redeemTC"];
    redeemValue = json["redeemValue"];
    rewardContentId = json["rewardContentId"];
    rewardId = json["rewardId"];
    rewardLongDescription = json["rewardLongDescription"];
    rewardShortDescription = json["rewardShortDescription"];
    rewardTC = json["rewardTC"];
    rewardType = json["rewardType"];
    ruleFrequency = json["ruleFrequency"];
    ruleTime = json["ruleTime"];
    templateId = json["templateId"];
    templateType = json["templateType"];
    transactionAmount = json["transactionAmount"];
  }
}
