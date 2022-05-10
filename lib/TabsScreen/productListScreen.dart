// ignore_for_file: prefer_const_constructors_in_immutables, no_logic_in_create_state, prefer_const_constructors

import 'package:date_format/date_format.dart';
import 'package:emilyretailerapp/EmilyNewtworkService/NetworkSerivce.dart';
import 'package:emilyretailerapp/Model/LoginEntity.dart';
import 'package:emilyretailerapp/Model/ProductsEntity/Product.dart';
import 'package:emilyretailerapp/Model/PromotionEntity.dart';
import 'package:emilyretailerapp/Model/RetailerLocationsDetail.dart';
import 'package:emilyretailerapp/Utils/ColorTools.dart';
import 'package:emilyretailerapp/Utils/ConstTools.dart';
import 'package:emilyretailerapp/Utils/DialogTools.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';

class ProducListScreen extends StatefulWidget {
  late String promotionId;
  RetailerLocationsDetail retailerLocationDetail;
  ProducListScreen(
      {Key? key,
      required this.promotionId,
      required this.retailerLocationDetail})
      : super(key: key);

  @override
  State<ProducListScreen> createState() => _ProducListScreenState(
      promotionID: promotionId, rLocationDetail: retailerLocationDetail);
}

class _ProducListScreenState extends State<ProducListScreen> {
  _ProducListScreenState(
      {required this.promotionID, required this.rLocationDetail});

  late String promotionID;
  late LoginEntity currentUser;
  bool isPromotionDetailLoaded = false;
  late PromotionEntity promotionDetail;
  late RetailerLocationsDetail rLocationDetail;
  late int selectedSection = 0;
  List<String> sectionsList = [
    // "",
    // "",
    "Promotion Description",
    "Promotion Terms & Conditions",
    "Rewards Terms & Conditions",
    "Redeem Terms & Conditions",
    "Location"
  ];
  List<Products> productsList = [];

  @override
  void initState() {
    super.initState();
    currentUser = ConstTools().retreiveSavedUserDetail();
    getPrpmotionDetail();
  }

  Future getPrpmotionDetail() async {
    Response response;
    HttpService http = HttpService();

    Map<String, dynamic> params = {
      "userId": currentUser.userId,
      "clientClass": "2",
      "type": "2",
      "promotionId": promotionID,
      "scope": "1",
      "version": "1",
    };

    try {
      response = await http.postRequest(
          ConstTools.pathV2 + ConstTools.apiGetPromotionDetail,
          params,
          context);
      if (response.statusCode == 200) {
        debugPrint("$response");
        final int statuscode = response.data["statusCode"];
        if (statuscode == 0) {
          Map<String, dynamic> returnData = response.data["returnData"];
          if (returnData.isNotEmpty) {
            promotionDetail = PromotionEntity.fromjson(returnData);
            await getProducts();
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

  Future getProducts() async {
    Response response;
    HttpService http = HttpService();

    DateTime firstDayCurrentMonth =
        DateTime.utc(DateTime.now().year, DateTime.now().month, 1);

    DateTime lastDayCurrentMonth = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month + 1,
    ).subtract(Duration(days: 1));

    Map<String, dynamic> params = {
      "retailerUserId": currentUser.userId,
      "type": "B4",
      "promotionId": promotionID,
      "version": "1",
      "lang": "en",
      "startUtcDateTime": "${firstDayCurrentMonth.millisecondsSinceEpoch}",
      "endUtcDateTime": "${lastDayCurrentMonth.millisecondsSinceEpoch}",
    };

    try {
      response = await http.postRequest(
          ConstTools.pathV3 + ConstTools.apiGetProducts, params, context);
      if (response.statusCode == 200) {
        debugPrint("$response");
        final int statuscode = response.data["statusCode"];
        if (statuscode == 0) {
          List<dynamic> returnData = response.data["returnData"];
          if (returnData.isNotEmpty) {
            for (var i = 0; i < returnData.length; i++) {
              Products product = Products.fromJson(returnData[i]);
              productsList.add(product);
            }
            isPromotionDetailLoaded = true;
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

  Widget productListSettings() {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 10) / 2;
    final double itemWidth = size.width / 2;
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemCount: productsList.length,
        itemBuilder: (BuildContext context, int index) {
          Products product = productsList[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Center(
                          child: Image.network(
                    product.logoUrl,
                    width: 200,
                    height: 200,
                  ))),
                  Text(
                    product.productName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.descriptionField,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(50, 20)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "See more",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  Center(
                      child: Text(
                    'Current month Sold: ${product.soldNumber}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
                ],
              ),
            ),
          );
        });
  }

  Widget promotionDateSetting() {
    String startDate = formatDate(
        DateTime.parse(promotionDetail.startDate), [MM, " ", dd, ", ", yyyy]);

    String endDate = formatDate(
        DateTime.parse(promotionDetail.endDate), [MM, " ", dd, ", ", yyyy]);

    return Center(
        child: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Text(
        'Promotion is valid from $startDate until $endDate',
        style: const TextStyle(
            color: Color(ColorTools.primaryColor), fontSize: 13),
      ),
    ));
  }

  Widget promotionDetailsSetting(int section) {
    String detail = getPromotionDetailWithSection(section);
    return ExpandableNotifier(
        child: Column(
      children: <Widget>[
        ScrollOnExpand(
          scrollOnExpand: true,
          scrollOnCollapse: false,
          child: Container(
            color: ColorTools.bgGrey,
            child: ExpandablePanel(
              header: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(
                    sectionsList[section],
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  )),
              collapsed: Container(),
              expanded: section == sectionsList.length - 1
                  ? locationSettings()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              detail,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
              builder: (_, collapsed, expanded) {
                return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    ));
  }

  Widget locationSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentUser.companyName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(rLocationDetail.address + ", " + rLocationDetail.city),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  'Get Direction',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(ColorTools.primaryColor),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  'Call',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(ColorTools.primaryColor),
              ),
            )
          ],
        )
      ],
    );
  }

  String getPromotionDetailWithSection(int section) {
    String detail = "";
    switch (section) {
      case 0:
        detail = promotionDetail.longDescription.isEmpty
            ? "N/A"
            : promotionDetail.longDescription;
        break;
      case 1:
        detail = promotionDetail.restrictionTC.isEmpty
            ? "N/A"
            : promotionDetail.restrictionTC;
        break;
      case 2:
        detail =
            promotionDetail.redeemTC.isEmpty ? "N/A" : promotionDetail.redeemTC;
        ;
        break;
      case 3:
        detail = promotionDetail.rewardsTC.isEmpty
            ? "N/A"
            : promotionDetail.rewardsTC;
        break;
      default:
    }

    return detail;
  }

  Widget productListingWidget() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          productListSettings(),
          SizedBox(
            height: 5,
          ),
          promotionDateSetting(),
          SizedBox(
            height: 5,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: sectionsList.length,
              itemBuilder: (context, index) {
                return promotionDetailsSetting(index);
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(currentUser.companyName),
        ),
        body: isPromotionDetailLoaded
            ? productListingWidget()
            : Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 30),
                    child: const CircularProgressIndicator()),
              ));
  }
}
