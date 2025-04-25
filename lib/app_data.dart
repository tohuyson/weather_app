import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppData {
  AppData._();

  static final instance = AppData._();

  String? appVersion;
  String? deviceUDID;
  String? deviceName;
  String? osVersion;
  bool? isPhysicalDevice;

  bool get isIOSSimulator => !(isPhysicalDevice == true) && Platform.isIOS;

  Future getDeviceInfo() async {
    var device = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await device.iosInfo;
      deviceUDID = iosDeviceInfo.identifierForVendor; // unique ID on iOS
      deviceName = iosDeviceInfo.name;
      osVersion = '${iosDeviceInfo.systemName}-${iosDeviceInfo.systemVersion}';
      isPhysicalDevice = iosDeviceInfo.isPhysicalDevice;
    } else if (Platform.isAndroid) {
      const androidIdPlugin = AndroidId();
      deviceUDID = await androidIdPlugin.getId();
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      deviceName = androidInfo.model;
      osVersion = androidInfo.version.release;
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
  }
}
