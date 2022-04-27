// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cupertino_table_view/delegate/cupertino_table_view_delegate.dart';
import 'package:cupertino_table_view/table_view/cupertino_table_view.dart';
import 'package:date_format/date_format.dart';
import 'package:emilyretailerapp/EmilyNewtworkService/NetworkSerivce.dart';
import 'package:emilyretailerapp/Model/Jounral/JounralOrder.dart';
import 'package:emilyretailerapp/Model/LoginEntity.dart';
import 'package:emilyretailerapp/Utils/ColorTools.dart';
import 'package:emilyretailerapp/Utils/ConstTools.dart';
import 'package:emilyretailerapp/Utils/DatabaseHelper.dart';
import 'package:emilyretailerapp/Utils/DialogTools.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

class Journal extends StatefulWidget {
  Journal({Key? key}) : super(key: key);

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  DatabaseHelper dbhelper = DatabaseHelper();
  late LoginEntity currentUser;
  bool isJouralDataLoaded = false;
  List<JounralOrder> jounralList = [];
  String currentMonth = '';

  @override
  void initState() {
    super.initState();
    currentUser = ConstTools().retreiveSavedUserDetail();
    currentMonth = formatDate(DateTime.now(), [MM, " ", yyyy]);
    getListFromDB();
    getJounralData();
  }

  void getListFromDB() {
    final Future<Database> dbFuture = dbhelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<JounralOrder>> jounralListFuture = dbhelper.getJournalList();
      jounralListFuture.then((list) {
        setState(() {
          jounralList = list;
          if (jounralList.isNotEmpty) {
            isJouralDataLoaded = true;
          }
        });
      });
    });
  }

  Future getJounralData() async {
    Response response;
    HttpService http = HttpService();

    DateTime firstDayCurrentMonth =
        DateTime.utc(DateTime.now().year, DateTime.now().month, 1);

    String orientation = "1";
    String count = "50";
    String utcDateTime = "";
    String serverUUID = "";
    String startUtcDateTime = "${firstDayCurrentMonth.millisecondsSinceEpoch}";

    Map<String, dynamic> params = {
      "retailerUserId": currentUser.userId,
      "version": "3",
      "type": "B6",
      "startUtcDateTime": startUtcDateTime,
      "rewardTypes": "101,201,202,203",
      "count": count,
      "orientation": orientation,
      "utcDateTime": utcDateTime, //optional
      "serverUUID": serverUUID //optional
    };

    try {
      response = await http.postRequest(
          ConstTools.pathV3 + ConstTools.apiGetTransactionData,
          params,
          context);
      if (response.statusCode == 200) {
        debugPrint("$response");
        final int statuscode = response.data["statusCode"];
        if (statuscode == 0) {
          List<dynamic> returnData = response.data["returnData"];
          if (returnData.isNotEmpty) {
            for (var i = 0; i < returnData.length; i++) {
              JounralOrder order = JounralOrder.fromJson(returnData[i]);
              var filertedorder =
                  jounralList.map((e) => e.orderNo == order.orderNo);
              if (filertedorder.isEmpty) {
                await dbhelper.insertJournal(order);
              }
            }
            getListFromDB();
            isJouralDataLoaded = true;
            setState(() {});
          }
        } else if (statuscode == int.parse(ConstTools.multiDevicesErrorCode)) {
          DialogTools.alertMultiloginDialg(
              ConstTools.buttonOk, "", ConstTools.multiLoginMessage, context);
        } else if (statuscode ==
            int.parse(ConstTools.multiDevicesErrorCodeTwo)) {
          DialogTools.alertMultiloginDialg(
              ConstTools.buttonOk, "", ConstTools.multiLoginMessage, context);
        }
      } else {
        http.checkHttpError(context, HttpErrorType.other, response);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget rewardTypeAndVlaueSettings(JounralOrder orderDetail) {
    String type = '';
    String value = '';
    switch (orderDetail.promotiontype) {
      case "1":
        type = 'Stamps';
        value = orderDetail.earnedStamp;
        break;
      case '2':
        type = 'Points';
        value = orderDetail.earnedPoints;
        break;
      case '3':
        type = 'Cashback';
        value = orderDetail.savedCashBack;
        break;
      default:
    }
    return Text('$type:\n$value');
  }

  Widget jouralOrderSetting(int index) {
    JounralOrder orderDetail = jounralList[index];
    return Container(
      color: Colors.white, //index.isEven ? Colors.greenAccent : Colors.white,
      child: Row(
        children: [
          Column(
            //retailer image
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.network(orderDetail.partnerImage),
                ),
              )
            ],
          ),
          Expanded(
            child: Column(
              //user detail
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  //user name
                  children: [
                    Text(orderDetail.senderName,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  //order detail
                  children: [
                    Column(
                      //product image
                      children: [
                        SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(
                                orderDetail.catalogsData[0]["catalogImageUrl"]))
                      ],
                    ),
                    Expanded(
                      child: Column(
                        // product detail
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderDetail.catalogsData[0]['catalogName'],
                            maxLines: 1,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(50, 20)),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(0)),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "view more",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Column(
                      //reward earned
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: rewardTypeAndVlaueSettings(orderDetail),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        orderDetail.date_time,
                        style: TextStyle(color: Color(ColorTools.primaryColor)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: orderStatusSetting(orderDetail),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget orderStatusSetting(JounralOrder orderdetail) {
    String status = '';

    String expresstype = orderdetail.expressData["expressType"];
    String acceptTime = orderdetail.expressData["acceptTime"];
    String estimatedDeliveryTime =
        orderdetail.expressData["estimatedDeliveryTime"];
    String receiveTime = orderdetail.expressData["receiveTime"];
    String pincode = orderdetail.expressData["expressNumber"];

    if (receiveTime.isNotEmpty) {
      status = 'Done';
    } else if (estimatedDeliveryTime.isNotEmpty || pincode != "") {
      if (expresstype == "1") {
        status = 'Pickup';
      } else if (expresstype == "2") {
        status = 'Delivery';
      }
    } else if (acceptTime.isNotEmpty) {
      status = 'Accepted';
    } else {
      status = 'New';
    }

    return Text(status);
  }

  Widget journalListing() {
    return Container(
      color: ColorTools.bgGrey,
      child: ExpandablePanel(
        header: Padding(
            padding: EdgeInsets.only(left: 5, right: 10, top: 5),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_view_day_sharp,
                  color: Color(
                    ColorTools.primaryColor,
                  ),
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  currentMonth,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            )),
        collapsed: Container(),
        expanded: Container(
          color: Colors.white,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: jounralList.length,
              itemBuilder: (context, index) {
                return jouralOrderSetting(index);
              }),
        ),
        builder: (_, collapsed, expanded) {
          return Expandable(
            collapsed: collapsed,
            expanded: expanded,
            theme: const ExpandableThemeData(
              crossFadePoint: 0,
            ),
          );
        },
      ),
    );
  }

  CupertinoTableViewDelegate generateDelegate() {
    return CupertinoTableViewDelegate(
      numberOfSectionsInTableView: () => 1,
      numberOfRowsInSection: (section) {
        return 1;
      },
      cellForRowAtIndexPath: (context, indexPath) {
        return journalListing();
      },
      headerInSection: (context, section) => Container(
        width: double.infinity,
        height: 5, //section == sectionsList.length - 1 ? 35 : 0,
        padding: const EdgeInsets.all(0),
      ),

      pressedOpacity: 0.4,
      canSelectRowAtIndexPath: (indexPath) => false,
      didSelectRowAtIndexPath: (indexPath) => {},
      // marginForSection: marginForSection, // set marginForSection when using boxShadow
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Journal'),
        ),
        body: isJouralDataLoaded
            ? CupertinoTableView(
                delegate: generateDelegate(),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
              )
            : Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 30),
                    child: const CircularProgressIndicator()),
              ));
  }
}
