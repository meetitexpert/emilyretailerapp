import 'dart:io';

import 'package:cupertino_table_view/delegate/cupertino_table_view_delegate.dart';
import 'package:cupertino_table_view/refresh/refresh_config.dart';
import 'package:cupertino_table_view/refresh/refresh_indicator.dart';
import 'package:cupertino_table_view/table_view/cupertino_table_view.dart';
import 'package:date_format/date_format.dart';
import 'package:emilyretailerapp/EmilyNewtworkService/NetworkSerivce.dart';
import 'package:emilyretailerapp/Model/Payouts.dart';
import 'package:emilyretailerapp/Utils/ColorTools.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../Model/LoginEntity.dart';
import '../Utils/ConstTools.dart';
import '../Utils/DialogTools.dart';

class PayoutsScreen extends StatefulWidget {
  const PayoutsScreen({Key? key}) : super(key: key);

  @override
  _PayoutsScreenState createState() => _PayoutsScreenState();
}

class _PayoutsScreenState extends State<PayoutsScreen>
    with AutomaticKeepAliveClientMixin<PayoutsScreen> {
  @override
  bool get wantKeepAlive => true;

  late LoginEntity currentUser;

  List<Payouts> payoutslist = [];
  int payoutDataPageNo = 0;

  @override
  void initState() {
    super.initState();
    currentUser = ConstTools().retreiveSavedUserDetail();
    getPayoutsFromServer();
  }

  Future getPayoutsFromServer() async {
    Response response;
    HttpService http = HttpService();

    Map<String, dynamic> params = {
      "version": "1",
      "type": "B1",
      "pageNumber": "$payoutDataPageNo",
      "retailerUserId": currentUser.userId,
      "count": "10",
      "lastSyncTime": ""
    };

    try {
      response = await http.postRequest(
          ConstTools.pathV3 + ConstTools.apiGetRetailerPayouts,
          params,
          context);
      if (response.statusCode == 200) {
        debugPrint("$response");
        final int statuscode = response.data["statusCode"];
        if (statuscode == 0) {
          Map<String, dynamic> returnData = response.data["returnData"];
          if (returnData.isNotEmpty) {
            List<dynamic> resultData = returnData["datas"];
            debugPrint('$resultData');
            for (var data in resultData) {
              Payouts payout = Payouts.fromJson(data);
              payoutslist.add(payout);
            }

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

  TextStyle fontStyle(FontWeight weigt, Color txtColor) {
    return TextStyle(fontFamily: 'Roboto', fontWeight: weigt, color: txtColor);
  }

  Widget payoutDetailSetting(Payouts payout) {
    DateTime date = DateTime.parse(payout.dateTime);
    String payoutDateTime =
        formatDate(date, [M, ' ', dd, ', ', yyyy, ' at ', hh, ':', nn, am]);
    String amount = "\$${payout.payoutAmount.toStringAsFixed(2)}";
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount :',
                style: fontStyle(FontWeight.bold, Colors.black),
              ),
              Text(
                'Recipt ID :',
                style: fontStyle(FontWeight.bold, Colors.black),
              ),
              Text(
                'Transaction Count :',
                style: fontStyle(FontWeight.bold, Colors.black),
              ),
              Text(
                'Payout On :',
                style: fontStyle(FontWeight.bold, Colors.black),
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amount,
                style: fontStyle(FontWeight.normal, Colors.black),
              ),
              Text(
                payout.receiptId,
                style: fontStyle(FontWeight.normal, Colors.black),
              ),
              Text(
                '${payout.transactionCount}',
                style: fontStyle(FontWeight.normal, Colors.black),
              ),
              Text(
                payoutDateTime,
                style: fontStyle(
                    FontWeight.normal, const Color(ColorTools.primaryColor)),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  CupertinoTableViewDelegate generateDelegate() {
    return CupertinoTableViewDelegate(
      numberOfSectionsInTableView: () => 1,
      numberOfRowsInSection: (section) {
        var rows = payoutslist.length;

        return rows;
      },
      cellForRowAtIndexPath: (context, indexPath) {
        Payouts payout = payoutslist[indexPath.row];
        return payoutDetailSetting(payout);
      },
      headerInSection: (context, section) => Container(),
      footerInSection: (context, section) => Container(),
      pressedOpacity: 0.4,
      canSelectRowAtIndexPath: (indexPath) => false,
      didSelectRowAtIndexPath: (indexPath) => debugPrint('$indexPath'),
      // marginForSection: marginForSection, // set marginForSection when using boxShadow
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payouts'),
          automaticallyImplyLeading: false,
        ),
        body: payoutslist.isNotEmpty
            ? CupertinoTableView(
                delegate: generateDelegate(),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                refreshConfig: generateRefreshConfig(),
              )
            : Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 30),
                    child: const CircularProgressIndicator()),
              ));
  }

  RefreshConfig generateRefreshConfig() {
    return RefreshConfig(
      refreshHeaderBuilder: (context, status) {
        return Container();
      },
      refreshFooterBuilder: (context, status) {
        return DefaultRefreshIndicator(
          text: textFromStatus(status),
          icon: iconFromStatus(status),
        );
      },
      onRefreshHeaderStatusChange: (controller, status) {
        if (status == RefreshStatus.refreshing) {
          Future.delayed(const Duration(seconds: 0), () {
            controller.refreshHeaderStatus = RefreshStatus.completed;
          });
        }
      },
      onRefreshFooterStatusChange: (controller, status) {
        if (status == RefreshStatus.refreshing) {
          Future.delayed(const Duration(seconds: 3), () {
            controller.refreshFooterStatus = RefreshStatus.completed;
          });
        }
      },
    );
  }

  EdgeInsets get marginForSection => const EdgeInsets.only(left: 10, right: 10);

  String textFromStatus(RefreshStatus status) {
    switch (status) {
      case RefreshStatus.idle:
        return 'idle';
      case RefreshStatus.prepared:
        return 'prepared';
      case RefreshStatus.refreshing:
        return 'refreshing';
      case RefreshStatus.completed:
        return 'completed';
    }
  }

  Widget iconFromStatus(RefreshStatus status) {
    switch (status) {
      case RefreshStatus.idle:
        return const Icon(Icons.arrow_upward, color: Colors.grey);
      case RefreshStatus.prepared:
        return const Icon(Icons.arrow_downward, color: Colors.grey);
      case RefreshStatus.refreshing:
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2.0),
        );
      case RefreshStatus.completed:
        return const Icon(Icons.done, color: Colors.grey);
    }
  }
}
