// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emilyretailerapp/Utils/ColorTools.dart';
import 'package:emilyretailerapp/Utils/DeviceTools.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class rewardDetail extends StatefulWidget {
  rewardDetail({Key? key}) : super(key: key);

  @override
  State<rewardDetail> createState() => _rewardDetailState();
}

class _rewardDetailState extends State<rewardDetail> {
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

  Widget retailerDetail() {
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
              child: Image.network(
                  'https://cdn.logojoy.com/wp-content/uploads/2018/05/30152416/8_big10-768x591.png'),
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
              const Text(
                'Super Pho',
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
                          navigateTo(43.653225, -79.383184);
                        }),
                        child: Text(
                          'Unit H5, 1070 Major Mackenzie Drive East, Richmond Hill',
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
                      launch("tel:905-237-2288");
                    },
                    child: Text(
                      '905-237-2288',
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
                        launch("https://www.superpho.ca");
                      },
                      child: Text(
                        'https://www.superpho.ca',
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
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d"); //for Android
    if (DeviceTools.devicePlatform == "iOS") {
      //for IOS
      uri = Uri.parse("http://maps.apple.com/?q=${lat},${lng}");
    }

    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  Widget retailerCardImage() {
    return GestureDetector(
      onTap: (() => {isFront = !isFront, setState(() {})}),
      child: Container(
        padding: const EdgeInsets.all(0),
        child: Transform(
          transform: Matrix4.identity(),
          alignment: Alignment.centerLeft,
          child: Image.network(
            isFront == true
                ? 'https://indiaprint.in/wp-content/uploads/2021/12/visiting-card-design-6.jpg'
                : 'https://printlipi.com/images/visiting-card-design/visiting-card-design-8.jpg',
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
          ),
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
            children: const [
              Text(
                'Points',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.grey),
              ),
              Text(
                'Unlimited',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.grey),
              ),
              Text(
                'No time limit',
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
              width: 70,
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
                  Text('9:00 AM'),
                  SizedBox(
                    width: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text('6:00 Pm'),
                  )
                ],
              );
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView(
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
        ),
      ),
    );
  }
}
