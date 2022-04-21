// ignore_for_file: non_constant_identifier_names

import 'package:emilyretailerapp/Model/Entity.dart';

class PromotionEntity extends Entity {
  late String customCard;
  late String earnRate;
  late String endDate;
  late String exclusivity;
  late String frequency;
  late String includedProducts;
  late String keywords;
  late String longDescription;
  late String promotionContentId;
  late int promotionId;
  late String promotionType;
  late String redeemRate;
  late String redeemTC;
  late String redeemValue;
  late String restrictionTC;
  late String rewardsTC;
  late String shortDescription;
  late String startDate;
  late int startDateEffective;
  late String timeLimit;
  late String transactionAmount;
  late String userType;

  PromotionEntity();

  PromotionEntity.fromjson(Map<String, dynamic> json) {
    customCard = json["customCard"];
    endDate = json["endDate"];
    exclusivity = json["exclusivity"];
    frequency = json["frequency"];
    includedProducts = json["includedProducts"];
    keywords = json["keywords"];
    longDescription = json["longDescription"];
    promotionContentId = json["promotionContentId"];
    promotionId = json["promotionId"];
    promotionType = json["promotionType"];
    redeemRate = json["redeemRate"] ?? "";
    redeemTC = json["redeemTC"];
    redeemValue = json["redeemValue"];
    restrictionTC = json["restrictionTC"];
    rewardsTC = json["rewardsTC"];
    shortDescription = json["shortDescription"];
    startDate = json["startDate"];
    startDateEffective = json["startDateEffective"];
    status = json["status"];
    timeLimit = json["timeLimit"];
    transactionAmount = json["transactionAmount"];
    userType = json["userType"];
  }
}
