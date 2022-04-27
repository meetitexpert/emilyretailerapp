// ignore_for_file: non_constant_identifier_names

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:emilyretailerapp/Model/Jounral/JounralOrder.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  //table and keys names
  String JournalTable = 'Journal_table';
  String colId = 'colId';
  String transactionDateTime = 'transactionDateTime';
  String partnerName = 'partnerName';
  String partnerImage = 'partnerImage';
  String shortAddress = 'shortAddress';
  String phoneNumber = 'phoneNumber';
  String utcDateTime = 'utcDateTime';
  String transactionTimeStamp = 'transactionTimeStamp';
  String transactionRewardType = 'transactionRewardType';
  String transactionRewards = 'transactionRewards';
  String transactionClass = 'transactionClass';
  String buyerName = 'buyerName';
  String receiverName = 'receiverName';
  String cardLastPrice = 'cardLastPrice';
  String cardDescription = 'cardDescription';
  String oldCardImageUrl = 'oldCardImageUrl';
  String oldCardName = 'oldCardName';
  String payNo = 'payNo';
  String serverUUID = 'serverUUID';
  String transactionNumber = 'transactionNumber';
  String payCardName = 'payCardName';
  String payCardNumber = 'payCardNumber';
  String transactionTaxAmount = 'transactionTaxAmount';
  String creditAppliedAmount = 'creditAppliedAmount';
  String gratuity = 'gratuity';
  String standardShippingCost = 'standardShippingCost';
  String freeShippingAmount = 'freeShippingAmount';
  String cashDiscountPercentage = 'cashDiscountPercentage';
  String cashDiscountAmount = 'cashDiscountAmount';
  String couponAppliedAmount = 'couponAppliedAmount';
  String couponData = 'couponData';
  String gratuityPercentage = 'gratuityPercentage';
  String giftCardsAppliedValue = 'giftCardsAppliedValue';
  String redeemQuantity = 'redeemQuantity';
  String transactionRewardValue = 'transactionRewardValue';
  String catalogs = 'catalogs';
  String expressData = 'expressData';
  String orderNo = 'orderNo';
  String transactionAmountExclusiveTax = 'transactionAmountExclusiveTax';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'journal.db';

    // Open/create the database at a given path
    var journalDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return journalDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $JournalTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $transactionDateTime TEXT,'
        '$partnerName TEXT, $partnerImage TEXT, $shortAddress TEXT, $phoneNumber TEXT, $utcDateTime INTEGER, $transactionTimeStamp TEXT,'
        '$transactionRewardType TEXT, $transactionRewards TEXT, $transactionClass TEXT, $buyerName TEXT, $receiverName TEXT, $cardLastPrice TEXT,'
        '$cardDescription TEXT, $oldCardImageUrl TEXT, $oldCardName TEXT, $payNo TEXT, $serverUUID TEXT, $transactionNumber TEXT, $payCardName TEXT,'
        '$payCardNumber TEXT, $transactionTaxAmount TEXT, $creditAppliedAmount TEXT, $gratuity TEXT, $standardShippingCost TEXT, $freeShippingAmount TEXT,'
        '$cashDiscountPercentage TEXT, $cashDiscountAmount TEXT, $couponAppliedAmount TEXT, $couponData TEXT, $gratuityPercentage TEXT, $giftCardsAppliedValue TEXT,'
        '$redeemQuantity TEXT, $transactionRewardValue TEXT, $catalogs TEXT, $expressData TEXT, $orderNo TEXT, $transactionAmountExclusiveTax TEXT)');
  }

  // Fetch Operation: Get all Journal objects from database
  Future<List<Map<String, dynamic>>> getJournalMapList() async {
    Database db = await database;

//		var result = await db.rawQuery('SELECT * FROM $JournalTable order by $colPriority ASC');
    var result = await db.query(JournalTable, orderBy: '$utcDateTime ASC');
    return result;
  }

  // Insert Operation: Insert a Journal object to database
  Future<int> insertJournal(JounralOrder Journal) async {
    Database db = await database;
    var result = await db.insert(JournalTable, Journal.toMap());
    return result;
  }

  // Update Operation: Update a Journal object and save it to database
  Future<int> updateJournal(JounralOrder Journal) async {
    var db = await this.database;
    var result = await db.update(JournalTable, Journal.toMap(),
        where: '$orderNo = ?', whereArgs: [Journal.orderNo]);
    return result;
  }

  // Delete Operation: Delete a Journal object from database
  /*Future<int> deleteJournal(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $JournalTable WHERE $colId = $id');
		return result;
	}*/

  // Get number of Journal objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $JournalTable');
    int result = Sqflite.firstIntValue(x) ?? 0;
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Journal List' [ List<Journal> ]
  Future<List<JounralOrder>> getJournalList() async {
    var JournalMapList =
        await getJournalMapList(); // Get 'Map List' from database
    int count =
        JournalMapList.length; // Count the number of map entries in db table

    List<JounralOrder> JournalList = [];
    // For loop to create a 'Journal List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      JournalList.add(JounralOrder.fromDBJson(JournalMapList[i]));
    }

    return JournalList;
  }
}
