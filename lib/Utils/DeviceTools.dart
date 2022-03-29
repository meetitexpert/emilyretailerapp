import 'package:device_info_plus/device_info_plus.dart';

import 'dart:io';
import 'AppTools.dart';

/*
    * @description:  获取设备信息
    * @return {type} 设备信息
    */
Future<dynamic> getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  var device;
  if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    device = iosInfo;
  } else if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    device = androidInfo;
  }
  return device;
}

//  获取设备的指定信息
class DeviceTools {
  static late String devicePlatform;
  static late String deviceMake;
  static late String deviceModel;
  static late String devicePin;
  static late String osVersion;

  static void init() async {
    var device = await getDeviceInfo();

    if (Platform.isIOS) {
      devicePlatform = "iOS";
      deviceModel = device.model;
      devicePin = device.identifierForVendor;
      deviceMake = device.systemName;
      osVersion = device.systemVersion;

      AppTools.clientClass = "1";
    } else if (Platform.isAndroid) {
      devicePlatform = "Android";
      deviceMake = device.manufacturer;
      deviceModel = device.model;
      devicePin = device.androidId;
      osVersion = device.version.sdkInt.toString();

      AppTools.clientClass = "2";
    }
  }
}
