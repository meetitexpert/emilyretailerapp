import 'package:cupertino_table_view/delegate/cupertino_table_view_delegate.dart';
import 'package:cupertino_table_view/table_view/cupertino_table_view.dart';
import 'package:emilyretailerapp/TabsScreen/MoreSection/webViewScreen.dart';
import 'package:emilyretailerapp/Utils/ColorTools.dart';
import 'package:emilyretailerapp/Utils/DialogTools.dart';
import 'package:emilyretailerapp/Utils/PixelTools.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../Model/LoginEntity.dart';
import '../Utils/ConstTools.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

//
class _MoreScreenState extends State<MoreScreen> {
  late LoginEntity currentUser;
  List<String> moreOptions = [
    ConstTools.journal,
    ConstTools.notifioction,
    ConstTools.security,
    ConstTools.faqs,
    ConstTools.contactUs,
    ConstTools.termsCondition,
    ConstTools.privacyPolicy,
    ConstTools.aboutApp,
    ConstTools.signOUt
  ];
  List<Icon> moreOptionsIcons = [
    const Icon(
      Icons.document_scanner_sharp,
      color: Color(ColorTools.primaryColor),
    ),
    const Icon(
      Icons.notifications,
      color: Color(ColorTools.primaryColor),
    ),
    const Icon(
      Icons.security,
      color: Color(ColorTools.primaryColor),
    ),
    const Icon(
      Icons.document_scanner_sharp,
      color: Color(ColorTools.primaryColor),
    ),
    const Icon(
      Icons.mail,
      color: Color(ColorTools.primaryColor),
    ),
    const Icon(
      Icons.document_scanner_sharp,
      color: Color(ColorTools.primaryColor),
    ),
    const Icon(
      Icons.document_scanner_sharp,
      color: Color(ColorTools.primaryColor),
    ),
    const Icon(
      Icons.document_scanner_sharp,
      color: Color(ColorTools.primaryColor),
    ),
    const Icon(
      Icons.logout,
      color: Color(ColorTools.primaryColor),
    )
  ];

  @override
  void initState() {
    super.initState();
    currentUser = ConstTools().retreiveSavedUserDetail();
  }

  Widget qrCodeWidget() {
    return Container(
      color: Colors.white,
      width: PixelTools.screenWidth,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImage(
            data: "1234567890",
            version: QrVersions.auto,
            size: 200.0,
          ),
          Text(
            currentUser.fullName,
            style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 18),
          )
        ],
      ),
    );
  }

  Widget moreOptionsWidget(int index) {
    return ListTile(
      leading: moreOptionsIcons[index],
      minLeadingWidth: 12,
      title: Text(
        moreOptions[index],
        textAlign: TextAlign.left,
      ),
      trailing: const Icon(Icons.navigate_next),
    );
  }

  CupertinoTableViewDelegate generateDelegate() {
    return CupertinoTableViewDelegate(
        numberOfSectionsInTableView: () => 2,
        numberOfRowsInSection: (section) {
          var rows = moreOptions.length;
          if (section == 0) {
            rows = 1;
          }
          return rows;
        },
        cellForRowAtIndexPath: (context, indexPath) {
          return indexPath.section == 0
              ? qrCodeWidget()
              : moreOptionsWidget(indexPath.row);
        },
        headerInSection: (context, section) => Container(),
        footerInSection: (context, section) => Container(),
        pressedOpacity: 0.4,
        canSelectRowAtIndexPath: (indexPath) => true,
        didSelectRowAtIndexPath: (indexPath) => {
              if (indexPath.section == 1) {handlingAction(indexPath.row)},
              // marginForSection: marginForSection, // set marginForSection when using boxShadow
            });
  }

  handlingAction(int index) {
    if (moreOptions[index] == ConstTools.faqs) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const webViewScreen(
              url: ConstTools.faqURL,
              title: ConstTools.faqs,
            ),
          ));
    } else if (moreOptions[index] == ConstTools.termsCondition) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const webViewScreen(
              url: ConstTools.termsURL,
              title: ConstTools.termsCondition,
            ),
          ));
    } else if (moreOptions[index] == ConstTools.privacyPolicy) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const webViewScreen(
              url: ConstTools.privacyURL,
              title: ConstTools.privacyPolicy,
            ),
          ));
    } else if (index == moreOptions.length - 1) //singout
    {
      DialogTools.alertDialgTwoButtons(ConstTools.signOUt, ConstTools.cancel,
          "Are you sure you want to sign out?", "", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('More'),
          automaticallyImplyLeading: false,
        ),
        body: CupertinoTableView(
          delegate: generateDelegate(),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
        ));
  }
}
