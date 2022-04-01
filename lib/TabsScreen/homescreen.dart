import 'package:emilyretailerapp/Utils/ColorTools.dart';
import 'package:emilyretailerapp/Utils/ConstTools.dart';
import 'package:emilyretailerapp/Utils/PixelTools.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_table_view/cupertino_table_view.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  List<String> promotionslist = [
    "https://as2.ftcdn.net/v2/jpg/02/62/03/53/1000_F_262035364_gGi8uJsPl9uljis8C6oxI0w6AM7MKDLq.jpg",
    "https://as1.ftcdn.net/v2/jpg/03/13/66/88/1000_F_313668868_PjtPd0e77e1BtfkxvWieCKeY6vedGQeW.jpg",
    "https://as2.ftcdn.net/v2/jpg/03/03/76/11/1000_F_303761193_e6FwzIXsujF73NTN120W0qosvrluPYgt.jpg"
  ];

  List<String> promotionsText = [
    "Support your local businesses. Order & pick up at the store. Earn rewards points",
    "Support your local businesses. Order & pick up at the store. Earn rewards cash back.",
    "Support your local businesses. Order & pick up at the store. Earn rewards stamp."
  ];

  int selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  Widget swiperWidget(int section) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          promotionslist[index],
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
      itemCount: 3,
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
    return Expanded(
      child: Container(
          padding: const EdgeInsets.all(8),
          color: const Color(0xFFE1E1E1),
          child: Text(promotionsText[selectedIndex],
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
              glow: false,
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
              updateOnDrag: false,
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
    debugPrint('${ConstTools().retreiveSavedUserDetail()}');

    return Scaffold(
      body: CupertinoTableView(
        delegate: generateDelegate(),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      ),
    );
  }
}
