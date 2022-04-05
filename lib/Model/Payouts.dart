// ignore_for_file: file_names

import 'package:emilyretailerapp/Model/Entity.dart';

class Payouts extends Entity {
  late int retailerId;
  late String retailerUserName;
  late String retailerName;
  late int payoutId;
  late double grossAmount;
  late double taxes;
  late String receiptId;
  late int transactionCount;
  late double shipingHandling;
  late double processingFee;
  late double payoutAmount;
  late String deducted;
  late String dateTime;
  late int utcDateTime;

  Payouts();

  Payouts.fromJson(Map<String, dynamic> json) {
    retailerId = json["retailerId"];
    retailerUserName = json["retailerUserName"];
    retailerName = json["retailerName"];
    payoutId = json["payoutId"];
    grossAmount = json["grossAmount"];
    taxes = json["taxes"];
    receiptId = json["receiptId"];
    transactionCount = json["transactionCount"];
    shipingHandling = json["shipingHandling"];
    processingFee = json["processingFee"];
    payoutAmount = json["payoutAmount"];
    deducted = json["deducted"];
    dateTime = json["dateTime"];
    utcDateTime = json["utcDateTime"];
  }
}
