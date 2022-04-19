// ignore_for_file: unused_import, must_be_immutable, prefer_const_constructors
import 'dart:async';
import 'package:emilyretailerapp/Utils/ColorTools.dart';
import 'package:emilyretailerapp/Utils/PixelTools.dart';
import 'package:flutter/material.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:app_settings/app_settings.dart';

class Notifications extends StatefulWidget {
  bool isNotification = true;

  Notifications({Key? key, required this.isNotification}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>
    with WidgetsBindingObserver {
  late Future<String> permissionStatusFuture;

  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";

  @override
  void initState() {
    super.initState();
    // set up the notification permissions class
    // set up the future to fetch the notification data
    permissionStatusFuture = getCheckNotificationPermStatus();
    // With this, we will be able to check if the permission is granted or not
    // when returning to the application
    WidgetsBinding.instance?.addObserver(this);
  }

  /// When the application has a resumed status, check for the permission
  /// status
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      updateView();
    } else if (state == AppLifecycleState.paused) {
      updateView();
    } else if (state == AppLifecycleState.detached) {
      updateView();
    } else if (state == AppLifecycleState.inactive) {
      updateView();
    }
  }

  void updateView() {
    if (mounted) {
      setState(() {
        permissionStatusFuture = getCheckNotificationPermStatus();
      });
    }
  }

  /// Checks the notification permission status
  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return permDenied;
        case PermissionStatus.granted:
          return permGranted;
        case PermissionStatus.unknown:
          return permUnknown;
        case PermissionStatus.provisional:
          return permProvisional;
        default:
          return permDenied;
      }
    });
  }

  Widget notificaitonDetail(bool isEnabled) {
    var enabledTextWidget = Text(
      'Push notification allow you to receive alerts of sales orders.',
      style: const TextStyle(fontSize: 18),
      softWrap: true,
      textAlign: TextAlign.left,
    );

    var disableTextWidget = Text(
      isEnabled == false
          ? 'You wont be able to receive notification when order are placed because you currently have opush notifications disabled.'
          : "",
      style: const TextStyle(fontSize: 14, color: Colors.red),
      softWrap: true,
      textAlign: TextAlign.left,
    );

    // else, we'll show a button to ask for the permissions
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        enabledTextWidget,
        const SizedBox(
          height: 10,
        ),
        disableTextWidget,
        const SizedBox(
          height: 20,
        ),
        MaterialButton(
          minWidth: PixelTools.screenWidth - 40,
          color: Color(ColorTools.primaryColor),
          child: const Text(
            "Change Settings",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            AppSettings.openAppSettings();
            // Navigator.pop(context);
            // show the dialog/open settings screen
            // NotificationPermissions.requestNotificationPermissions(
            //         iosSettings: const NotificationSettingsIos(
            //             sound: true, badge: true, alert: true))
            //     .then((_) {
            //   // when finished, check the permission status
            //   setState(() {
            //     permissionStatusFuture = getCheckNotificationPermStatus();
            //   });
            // });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: permissionStatusFuture,
          builder: (context, snapshot) {
            // if we are waiting for data, show a progress indicator
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return notificaitonDetail(false);
            }

            if (snapshot.hasData) {
              if (snapshot.data == permGranted) {
                return notificaitonDetail(true);
              }
              return notificaitonDetail(false);
            }
            return notificaitonDetail(false);
          },
        ),
      ),
    );
  }
}
