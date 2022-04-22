// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_logic_in_create_state, camel_case_types
import 'package:emilyretailerapp/EmilyNewtworkService/NetworkSerivce.dart';
import 'package:emilyretailerapp/Model/RetailerLocationsDetail.dart';
import 'package:emilyretailerapp/Model/RewardsDetailEntity.dart';
import 'package:emilyretailerapp/Utils/ColorTools.dart';
import 'package:emilyretailerapp/Utils/DeviceTools.dart';
import 'package:emilyretailerapp/Utils/PixelTools.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';

import '../Model/LoginEntity.dart';
import '../Utils/ConstTools.dart';
import 'package:flip_card/flip_card.dart';

class rewardDetail extends StatefulWidget {
  String rewardId = '';
  RetailerLocationsDetail retailerLocationDetail;
  rewardDetail(
      {Key? key, required this.rewardId, required this.retailerLocationDetail})
      : super(key: key);

  @override
  State<rewardDetail> createState() => _rewardDetailState(
      rewardID: rewardId, rLocationDetail: retailerLocationDetail);
}

class _rewardDetailState extends State<rewardDetail> {
  _rewardDetailState({required this.rewardID, required this.rLocationDetail});
  String rewardID = '';
  late LoginEntity currentUser;
  late RewardsDetailEntity retailerRewardDetail;
  late RetailerLocationsDetail rLocationDetail;
  bool isRewardDetailLoaded = false;
  bool isFront = true;
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  void initState() {
    super.initState();
    currentUser = ConstTools().retreiveSavedUserDetail();
    getRetailerRewardDetail();
  }

  Future getRetailerRewardDetail() async {
    Response response;
    HttpService http = HttpService();

    Map<String, dynamic> params = {
      "retailerUserId": currentUser.userId,
      "version": "1",
      "type": "B1",
      "rewardId": rewardID,
      "lan": "en"
    };

    try {
      response = await http.postRequest(
          ConstTools.pathV3 + ConstTools.apiGetRewardsDetail, params, context);
      if (response.statusCode == 200) {
        debugPrint("$response");
        final int statuscode = response.data["statusCode"];
        if (statuscode == 0) {
          Map<String, dynamic> returnData = response.data["returnData"];
          if (returnData.isNotEmpty) {
            retailerRewardDetail = RewardsDetailEntity.fromJson(returnData);
            isRewardDetailLoaded = true;
            setState(() {});
          }
        }
      } else {
        http.checkHttpError(context, HttpErrorType.other, response);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget retailerDetail() {
    String pNo = rLocationDetail.phoneNum;
    String webSite = rLocationDetail.webSite;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(2),
              child: Image.network(rLocationDetail.logoURL),
            ),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentUser.companyName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_city,
                    color: Color(ColorTools.primaryColor),
                    size: 25,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: (() {
                          navigateTo(double.parse(rLocationDetail.latitude),
                              double.parse(rLocationDetail.longitude));
                        }),
                        style: ButtonStyle(alignment: Alignment.centerLeft),
                        child: Text(
                          '${rLocationDetail.address}, ${rLocationDetail.city}',
                          softWrap: true,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        )),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: Color(ColorTools.primaryColor),
                    size: 25,
                  ),
                  TextButton(
                    onPressed: () {
                      launch("tel:$pNo");
                    },
                    child: Text(
                      pNo,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.web,
                    color: Color(ColorTools.primaryColor),
                    size: 25,
                  ),
                  TextButton(
                      onPressed: () {
                        launch(webSite);
                      },
                      child: Text(
                        webSite,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  static void navigateTo(double lat, double lng) async {
    String mapOptions = [
      'saddr=43.653225,-79.383184',
      'daddr=$lat,$lng',
      'avoid=highway&language=en'
    ].join('&');
    final uri = Uri.parse("https://www.google.com/maps?$mapOptions");

    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  Widget retailerCardImage() {
    return FlipCard(
      fill: Fill
          .fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL, // default
      front: Container(
        width: PixelTools.screenWidth,
        height: 200,
        child: Image.network(
          retailerRewardDetail.appFrontImgURL,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          fit: BoxFit.fitHeight,
        ),
      ),
      back: Container(
        width: PixelTools.screenWidth,
        height: 200,
        child: Image.network(
          retailerRewardDetail.appBackImgURL,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget rewardOptionSetting() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Reward Type',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
            Text(
              'Frequencey',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
            Text(
              'Time Limit',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                rewardType(retailerRewardDetail.rewardType),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.grey),
              ),
              Text(
                retailerRewardDetail.ruleFrequency > 0
                    ? retailerRewardDetail.ruleFrequency.toString()
                    : "Unlimited",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.grey),
              ),
              Text(
                retailerRewardDetail.ruleTime > 0
                    ? retailerRewardDetail.ruleTime.toString()
                    : "No time limit",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.grey),
              ),
            ],
          ),
        )
      ],
    );
  }

  String rewardType(String rtype) {
    String type = "";
    switch (rtype) {
      case "1":
        type = "Stamps";
        break;
      case "2":
        type = "Points";
        break;
      case "3":
        type = "Cashback";
        break;
      default:
    }

    return type;
  }

  Widget storeOperatingHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Store Operating Hours',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: Text('')),
            Text(
              'Start Time',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 75,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'End Time',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        ListView.builder(
            itemCount: days.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, i) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Text(
                    days[i],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  Text(storeOpenTime(days[i])),
                  SizedBox(
                    width: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(storeEndTime(days[i])),
                  )
                ],
              );
            })
      ],
    );
  }

  String storeOpenTime(String day) {
    String openTime = "Closed";
    switch (day) {
      case "Monday":
        if (rLocationDetail.monClose == 1) {
          openTime = ConstTools.convertDateFromString(
              rLocationDetail.monStart, context);
        }
        break;
      case "Tuesday":
        if (rLocationDetail.tueClose == 1) {
          openTime = ConstTools.convertDateFromString(
              rLocationDetail.tueStart, context);
        }
        break;
      case "Wednesday":
        if (rLocationDetail.wedClose == 1) {
          openTime = ConstTools.convertDateFromString(
              rLocationDetail.wedStart, context);
        }
        break;
      case "Thursday":
        if (rLocationDetail.thuClose == 1) {
          openTime = ConstTools.convertDateFromString(
              rLocationDetail.thuStart, context);
        }
        break;
      case "Friday":
        if (rLocationDetail.friClose == 1) {
          openTime = ConstTools.convertDateFromString(
              rLocationDetail.friStart, context);
        }
        break;
      case "Saturday":
        if (rLocationDetail.satClose == 1) {
          openTime = ConstTools.convertDateFromString(
              rLocationDetail.satStart, context);
        }
        break;
      case "Sunday":
        if (rLocationDetail.sunClose == 1) {
          openTime = ConstTools.convertDateFromString(
              rLocationDetail.sunStart, context);
        }
        break;
      default:
    }
    return openTime;
  }

  String storeEndTime(String day) {
    String endTime = "";
    switch (day) {
      case "Monday":
        if (rLocationDetail.monClose == 1) {
          endTime =
              ConstTools.convertDateFromString(rLocationDetail.monEnd, context);
        }
        break;
      case "Tuesday":
        if (rLocationDetail.tueClose == 1) {
          endTime =
              ConstTools.convertDateFromString(rLocationDetail.tueEnd, context);
        }
        break;
      case "Wednesday":
        if (rLocationDetail.wedClose == 1) {
          endTime =
              ConstTools.convertDateFromString(rLocationDetail.wedEnd, context);
        }
        break;
      case "Thursday":
        if (rLocationDetail.thuClose == 1) {
          endTime =
              ConstTools.convertDateFromString(rLocationDetail.thuEnd, context);
        }
        break;
      case "Friday":
        if (rLocationDetail.friClose == 1) {
          endTime =
              ConstTools.convertDateFromString(rLocationDetail.friEnd, context);
        }
        break;
      case "Saturday":
        if (rLocationDetail.satClose == 1) {
          endTime =
              ConstTools.convertDateFromString(rLocationDetail.satEnd, context);
        }
        break;
      case "Sunday":
        if (rLocationDetail.sunClose == 1) {
          endTime =
              ConstTools.convertDateFromString(rLocationDetail.sunEnd, context);
        }
        break;
      default:
    }
    return endTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: isRewardDetailLoaded == true
              ? ListView(
                  children: [
                    retailerDetail(),
                    retailerCardImage(),
                    SizedBox(
                      height: 10,
                    ),
                    rewardOptionSetting(),
                    SizedBox(
                      height: 10,
                    ),
                    storeOperatingHours()
                  ],
                )
              : Center(
                  child: Container(
                      margin: const EdgeInsets.only(top: 50, bottom: 30),
                      child: const CircularProgressIndicator()),
                )),
    );
  }
}
