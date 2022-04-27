// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks
import 'package:emilyretailerapp/Model/Entity.dart';
import 'dart:convert';

class JounralOrder extends Entity {
  late String address;

  late String partnerImage;
  late String partnerName;
  late String phoneNumber;
  late String date_time;
  late String time_stamp;
  late int utcDateTime;
  late String transaction_type;
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
    utcDateTime = json["utcDateTime"];

    time_stamp = json["transactionTimeStamp"];
    transactionRewardType = json["transactionRewardType"];
    transactionRewards = json["transactionRewards"] ?? "";
    transaction_type = json["transactionClass"];

    senderName = json["buyerName"];
    receiverName = json["receiverName"];

    double catalogPrice = json["cardLastPrice"];
    if (catalogPrice != 0) {
      cardLastPrice = catalogPrice.toStringAsFixed(2);
    } else {
      cardLastPrice = "0.00";
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
    String creditAppliedVal = json["creditAppliedAmount"];
    String gratuityValue = json["gratuity"];
    String standardShippingCostVal = json["standardShippingCost"];
    String freeShippingAmountVal = json["freeShippingAmount"];
    String cashDiscount = json["cashDiscountPercentage"];
    String cashDiscountValue = json["cashDiscountAmount"];
    String couponDiscountValue = json["couponAppliedAmount"];

    if (totalBeforetax.isNotEmpty &&
        totalTax.isNotEmpty &&
        creditAppliedVal.isNotEmpty &&
        gratuityValue.isNotEmpty &&
        standardShippingCostVal.isNotEmpty &&
        freeShippingAmountVal.isNotEmpty &&
        cashDiscount.isNotEmpty &&
        cashDiscountValue.isNotEmpty &&
        couponDiscountValue.isNotEmpty) {
      standardShippingCost = standardShippingCostVal;
      freeShippingAmount = freeShippingAmountVal;
      orderTotalTax = totalTax;
      creditApplied = creditAppliedVal;
      cashDiscountPercentage = cashDiscount;
      cashDiscountAmount = cashDiscountValue;
      couponAppliedValue = couponDiscountValue;

      dynamic couponsData = json["couponData"];
      if (couponsData.isNotEmpty) {
        appliedCouponsArray = couponsData;
      } else {
        appliedCouponsArray = [];
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

  JounralOrder.fromDBJson(Map<String, dynamic> json) {
    date_time = json["transactionDateTime"];
    partnerName = json["partnerName"];
    partnerImage = json["partnerImage"];
    address = json["shortAddress"];
    phoneNumber = json["phoneNumber"];
    utcDateTime = json["utcDateTime"];

    time_stamp = json["transactionTimeStamp"];
    transactionRewardType = json["transactionRewardType"];
    transactionRewards = json["transactionRewards"] ?? "";
    transaction_type = json["transactionClass"];

    senderName = json["buyerName"];
    receiverName = json["receiverName"];

    String catalogPrice = json["cardLastPrice"];
    if (catalogPrice.isNotEmpty) {
      cardLastPrice = catalogPrice;
    } else {
      cardLastPrice = "0.00";
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
    String creditAppliedVal = json["creditAppliedAmount"];
    String gratuityValue = json["gratuity"];
    String standardShippingCostVal = json["standardShippingCost"];
    String freeShippingAmountVal = json["freeShippingAmount"];
    String cashDiscount = json["cashDiscountPercentage"];
    String cashDiscountValue = json["cashDiscountAmount"];
    String couponDiscountValue = json["couponAppliedAmount"];

    if (totalBeforetax.isNotEmpty &&
        totalTax.isNotEmpty &&
        creditAppliedVal.isNotEmpty &&
        gratuityValue.isNotEmpty &&
        standardShippingCostVal.isNotEmpty &&
        freeShippingAmountVal.isNotEmpty &&
        cashDiscount.isNotEmpty &&
        cashDiscountValue.isNotEmpty &&
        couponDiscountValue.isNotEmpty) {
      standardShippingCost = standardShippingCostVal;
      freeShippingAmount = freeShippingAmountVal;
      orderTotalTax = totalTax;
      creditApplied = creditAppliedVal;
      cashDiscountPercentage = cashDiscount;
      cashDiscountAmount = cashDiscountValue;
      couponAppliedValue = couponDiscountValue;

      dynamic couponsData = json["couponData"];
      if (couponsData.isNotEmpty) {
        appliedCouponsArray = jsonDecode(couponsData);
      } else {
        appliedCouponsArray = [];
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

    catalogsData = jsonDecode(json["catalogs"]);

    Map<String, dynamic> expressDict = jsonDecode(json["expressData"]);

    expressData = expressDict;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["transactionDateTime"] = date_time;
    map["partnerName"] = partnerName;
    map["partnerImage"] = partnerImage;
    map["shortAddress"] = address;
    map["phoneNumber"] = phoneNumber;
    map["utcDateTime"] = utcDateTime;
    map["transactionTimeStamp"] = time_stamp;
    map["transactionRewardType"] = transactionRewardType;
    map["transactionRewards"] = transactionRewards;
    map["transactionClass"] = transaction_type;
    map["buyerName"] = senderName;
    map["receiverName"] = receiverName;
    map["cardLastPrice"] = double.parse(cardLastPrice);
    map["cardDescription"] = cardName;
    map["oldCardImageUrl"] = oldCardImageUrl;
    map["oldCardName"] = oldCardImageUrl;
    map["payNo"] = orderReferenceNo;
    map["serverUUID"] = orderReceiptNo;
    map["transactionNumber"] = orderNo;
    map["payCardName"] = paymentCardName;
    map["payCardNumber"] = paymentCardNo;
    map["transactionAmountExclusiveTax"] = ordertotalBeforeTax;
    map["transactionTaxAmount"] = orderTotalTax;
    map["creditAppliedAmount"] = creditApplied;
    map["gratuity"] = orderGratuityPrice;
    map["standardShippingCost"] = standardShippingCost;
    map["freeShippingAmount"] = freeShippingAmount;
    map["cashDiscountPercentage"] = cashDiscountPercentage;
    map["cashDiscountAmount"] = cashDiscountAmount;
    map["couponAppliedAmount"] = couponAppliedValue;
    map["couponData"] = jsonEncode(appliedCouponsArray);
    map["gratuityPercentage"] = gratuityPercentage;
    map["giftCardsAppliedValue"] = giftCardsAppliedValue;
    map["redeemQuantity"] = orderRdeemValue;

    switch (transactionRewardType) {
      case "201":
        map["transactionRewardValue"] = earnedStamp;
        break;
      case "202":
        map["transactionRewardValue"] = earnedPoints;
        break;
      case "203":
        map["transactionRewardValue"] = savedCashBack;
        break;
      default:
        break;
    }
    map["catalogs"] = jsonEncode(catalogsData);
    map["expressData"] = jsonEncode(expressData);
    return map;
  }
}
