import 'dart:async';

import 'package:emilyretailerapp/Model/LoginEntity.dart';
import 'package:emilyretailerapp/Model/RetailerRewardEntity.dart';
import 'package:emilyretailerapp/Utils/AppTools.dart';
import 'package:emilyretailerapp/Utils/ColorTools.dart';
import 'package:emilyretailerapp/Utils/ConstTools.dart';
import 'package:emilyretailerapp/Utils/DialogTools.dart';
import 'package:emilyretailerapp/Utils/PixelTools.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_table_view/cupertino_table_view.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../EmilyNewtworkService/NetworkSerivce.dart';
import 'package:dio/dio.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

// ignore: camel_case_types
class _homeScreenState extends State<homeScreen>
    with AutomaticKeepAliveClientMixin<homeScreen> {
  final controller = PageController(
    viewportFraction: 0.8,
    keepPage: true,
  );

  List<RetailerRewardEntity> promotionslist = [];
  List<RetailerRewardEntity> rewardsList = [];
  int selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 5), ((Timer t) {
      loadHomePromotionsAndRewardData();
      t.cancel();
    }));
  }

  Future loadHomePromotionsAndRewardData() async {
    Response response;
    HttpService http = HttpService();

    LoginEntity user = ConstTools().retreiveSavedUserDetail();

    Map<String, dynamic> params = {
      "retailerUserId": user.userId,
      "version": "1",
      "type": "B1",
      "lang": "en",
      "clientClass": AppTools.clientClass
    };

    try {
      response = await http.postRequest(
          ConstTools.pathV3 + ConstTools.apiGetHomeRewards, params, context);
      if (response.statusCode == 200) {
        debugPrint("$response");
        final int statuscode = response.data["statusCode"];
        if (statuscode == 0) {
          List<dynamic> returnData = response.data["returnData"];
          if (returnData.isNotEmpty) {
            final List<RetailerRewardEntity> promotionsArray = [];
            for (var i = 0; i < returnData.length; i++) {
              RetailerRewardEntity promotion =
                  RetailerRewardEntity.fromJson(returnData[i]);
              promotionsArray.add(promotion);
            }

            promotionslist = promotionsArray
                .where((element) => element.type == "2")
                .toList();
            rewardsList = promotionsArray
                .where((element) => element.type == "1")
                .toList();

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

  Widget swiperWidget(int section) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        RetailerRewardEntity promotion =
            section == 0 ? promotionslist[index] : rewardsList[index];
        return Image.network(
          promotion.appFrontImgURL,
          fit: BoxFit.fill,
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
        );
      },
      itemCount: section == 0 ? promotionslist.length : rewardsList.length,
      itemHeight: 200,
      itemWidth: PixelTools.screenWidth,
      loop: false,
      onTap: (index) {
        debugPrint('$index');
      },
      onIndexChanged: (index) {
        if (section == 0) {
          setState(() {
            selectedIndex = index;
          });
        }
      },
    );
  }

  Widget promotiontextWidget() {
    RetailerRewardEntity promotion = promotionslist[selectedIndex];
    return Expanded(
      child: Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFE1E1E1),
          child: Text(promotion.rewardShortDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "Roboto-Bold",
                decoration: TextDecoration.none,
              ))),
    );
  }

  Widget paginationWidget() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: AnimatedSmoothIndicator(
            activeIndex: selectedIndex,
            count: promotionslist.length,
            effect: const WormEffect(
              paintStyle: PaintingStyle.stroke,
              strokeWidth: 1,
              activeDotColor: Color(ColorTools.primaryColor),
            ),
          )),
    );
  }

  Widget promotionsWidget(int section) {
    return Column(
      children: [
        Container(
            color: Colors.white,
            width: PixelTools.screenWidth,
            height: 200,
            child: swiperWidget(section)),
        promotiontextWidget(),
        paginationWidget()
      ],
    );
  }

  Widget promotionandRewardWidgets(int section) {
    return SizedBox(
      height: section == 0 ? 280 : 200,
      width: PixelTools.screenWidth,
      child: section == 0 ? promotionsWidget(section) : swiperWidget(section),
    );
  }

  Widget RatingSwiper() {
    return Container(
      color: const Color(0xFFE1E1E1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: RatingBar.builder(
              ignoreGestures: true,
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                debugPrint('$rating');
              },
            ),
          ),
          const Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text('Bilal Hussain'),
          )),
          const Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text('Mar 24, 2022 at 12:23 PM'),
          )),
        ],
      ),
    );
  }

  CupertinoTableViewDelegate generateDelegate() {
    return CupertinoTableViewDelegate(
      numberOfSectionsInTableView: () => 3,
      numberOfRowsInSection: (section) {
        var rows = 1;

        return rows;
      },
      cellForRowAtIndexPath: (context, indexPath) {
        if (indexPath.section == 0 || indexPath.section == 1) {
          return promotionandRewardWidgets(indexPath.section);
        } else {
          return RatingSwiper();
        }
      },
      headerInSection: (context, section) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 5, top: (section == 2 ? 15 : 5)),
        child: Text(
          section == 0
              ? 'Promotions'
              : section == 1
                  ? 'Rewards Program'
                  : 'Customer Feedback',
          style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto-Bold',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),

      pressedOpacity: 0.4,
      canSelectRowAtIndexPath: (indexPath) => false,
      didSelectRowAtIndexPath: (indexPath) => debugPrint('$indexPath'),
      // marginForSection: marginForSection, // set marginForSection when using boxShadow
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: promotionslist.isNotEmpty
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
