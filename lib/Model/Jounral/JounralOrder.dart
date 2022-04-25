// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'package:date_format/date_format.dart';
import 'package:emilyretailerapp/Model/Entity.dart';
import 'package:emilyretailerapp/Model/Jounral/Rule.dart';
import 'package:emilyretailerapp/Utils/ConstTools.dart';

class JounralOrder extends Entity {
  late String address;
  late String buttonLabel;
  late String categoryCode;
  late double dist;
  late String favourite;
  late String latitude;
  late String longitude;
  late String offerEndDate;
  late String offerId;
  late String offerShortDescription;
  late String offerStartDate;
  late String offerType;
  late String offerUrl;
  late String partnerClass;
  late String partnerImage;
  late String partnerName;
  late String partnerWebsite;
  late String phoneNumber;
  late String phoneType;
  late String urlSuffix;
  late String imgBackUrl;
  late String imgFrontUrl;
  late int redeem_value;
  late int reward_points;
  late int rewards_value;
  late List<dynamic> locationsArray;
  late String randomBuy;
  late String date_time;
  late String partnerID;
  late String storeLocationID;
  late String restriction;
  late String time_stamp;
  late String utcDateTime;
  late String transaction_type;
  late String sun_open_status;
  late String sun_start_time;
  late String sun_end_time;
  late String mon_open_status;
  late String mon_start_time;
  late String mon_end_time;
  late String tue_open_status;
  late String tue_start_time;
  late String tue_end_time;
  late String wed_open_status;
  late String wed_start_time;
  late String wed_end_time;
  late String thu_open_status;
  late String thu_start_time;
  late String thu_end_time;
  late String fri_open_status;
  late String fri_start_time;
  late String fri_end_time;
  late String sat_open_status;
  late String sat_start_time;
  late String sat_end_time;

  late String transactionCount;
  late String transactionLastDate;
  late List<Rule> rules;

  late double offerPrice;
  late int quantityLimit;

  late String promotiontype;
  late String savedCashBack;
  late String earnedPoints;
  late String earnedStamp;
  late String totalTransaction;
  late String transactionRewardType;
  late String transactionRewardValue;
  late String transactionRewards;
  late String receiverName;
  late String senderName;
  late String cardType;
  late String newCardImageUrl;
  late String cardName;
  late String oldCardName;
  late String oldCardDescription;
  late String oldCardImageUrl;
  late String cardLastPrice;
  late String cardDisplayPrice;
  late List<dynamic> catalogsData;
  late String orderNo;
  late String ordertotalBeforeTax;
  late String orderGratuityPrice;
  late String gratuityPercentage;
  late String standardShippingCost;
  late String freeShippingAmount;
  late String orderTotalTax;
  late String orderTotalPrice;
  late String orderReferenceNo;
  late String orderReceiptNo;
  late String orderRdeemValue;
  late String creditApplied;
  late String paymentCardNo;
  late String paymentCardName;

  late String orderDispatchStatus;
  late Map<String, dynamic> expressData;
  late String cellBackgroundColor;
  late String cashDiscountAmount;
  late String cashDiscountPercentage;
  late String giftCardsAppliedValue;
  late String couponAppliedValue;
  late String couponCode;
  late List<dynamic> appliedCouponsArray;

  JounralOrder.fromJson(Map<String, dynamic> json) {
    date_time = json["transactionDateTime"];
    partnerName = json["partnerName"];
    partnerImage = json["partnerImage"];
    address = json["shortAddress"];
    phoneNumber = json["phoneNumber"];
    int utcDate = json["utcDateTime"];
    if (utcDate != 0) {
      var strToDateTime = ConstTools.utcToDateTime(utcDate);
      final convertLocal = strToDateTime.toLocal();

      String date = formatDate(convertLocal, [
        M,
        " ",
        d,
        ", ",
        yyyy
      ]); //Utils.getDateFrom(unixTimeStamp: utcDatetime, inFormat: "MMM d, yyyy")
      String time = formatDate(convertLocal, [
        hh,
        ":",
        n,
        " ",
        am
      ]); //Utils.getDateFrom(unixTimeStamp: utcDatetime, inFormat: "hh:mm a")
      utcDateTime = date + " at " + time;
    }

    time_stamp = json["transactionTimeStamp"];
    transactionRewardType = json["transactionRewardType"];
    transactionRewards = json["transactionRewards"] ?? "";
    transaction_type = json["transactionClass"];

    senderName = json["buyerName"];
    receiverName = json["receiverName"];

    double catalogPrice = json["cardLastPrice"];
    if (catalogPrice != 0) {
      cardLastPrice = catalogPrice.toStringAsFixed(2);
    }
    cardName = json["cardDescription"];
    oldCardImageUrl = json["oldCardImageUrl"];
    oldCardName = json["oldCardName"];

    String orderRef = json["payNo"];
    if (orderRef == "") {
      orderReferenceNo = "N/A";
    } else {
      orderReferenceNo = orderRef;
    }

    String orderRecieptNo = json["serverUUID"];
    if (orderRecieptNo == "") {
      orderReceiptNo = "N/A";
    } else {
      orderReceiptNo = orderRecieptNo;
    }

    orderNo = json["transactionNumber"];

    paymentCardName = json["payCardName"];
    paymentCardNo = json["payCardNumber"];

    String totalBeforetax = json["transactionAmountExclusiveTax"];
    String totalTax = json["transactionTaxAmount"];
    String creditApplied = json["creditAppliedAmount"];
    String gratuityValue = json["gratuity"];
    String standardShippingCost = json["standardShippingCost"];
    String freeShippingAmount = json["freeShippingAmount"];
    String cashDiscount = json["cashDiscountPercentage"];
    String cashDiscountValue = json["cashDiscountAmount"];
    String couponDiscountValue = json["couponAppliedAmount"];

    if (totalBeforetax.isNotEmpty &&
        totalTax.isNotEmpty &&
        creditApplied.isNotEmpty &&
        gratuityValue.isNotEmpty &&
        standardShippingCost.isNotEmpty &&
        freeShippingAmount.isNotEmpty &&
        cashDiscount.isNotEmpty &&
        cashDiscountValue.isNotEmpty &&
        couponDiscountValue.isNotEmpty) {
      standardShippingCost = standardShippingCost;
      freeShippingAmount = freeShippingAmount;
      orderTotalTax = totalTax;
      creditApplied = creditApplied;
      cashDiscountPercentage = cashDiscount;
      cashDiscountAmount = cashDiscountValue;
      couponAppliedValue = couponDiscountValue;

      dynamic couponsData = json["couponData"];
      if (couponsData.isNotEmpty) {
        appliedCouponsArray = couponsData;
      }

      orderGratuityPrice = gratuityValue;
      gratuityPercentage = json["gratuityPercentage"];

      double total = double.parse(totalBeforetax);
      ordertotalBeforeTax = total.toStringAsFixed(2);

      String giftAppliedValue = json["giftCardsAppliedValue"];
      giftCardsAppliedValue = giftAppliedValue;

      double totalPrice =
          (total + double.parse(totalTax) + double.parse(gratuityValue));
      totalPrice = totalPrice - double.parse(creditApplied);
      totalPrice = totalPrice - double.parse(giftAppliedValue);
      orderTotalPrice = totalPrice.toStringAsFixed(2);
    }
    orderRdeemValue = json["redeemQuantity"] ?? "";

    switch (transactionRewardType) {
      case "101":
        promotiontype = "1";
        break;
      case "201":
        promotiontype = "1";
        earnedStamp = json["transactionRewardValue"];
        break;
      case "202":
        earnedPoints = json["transactionRewardValue"];
        promotiontype = "2";
        break;
      case "203":
        savedCashBack = json["transactionRewardValue"];
        promotiontype = "3";
        break;
      default:
        break;
    }

    catalogsData = json["catalogs"];

    Map<String, dynamic> expressDict = json["expressData"];

    expressData = expressDict;
  }
}
