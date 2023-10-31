import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/tracking.dart';

Future<String> getInitialRoute() async {
  return TrackingPage.routeName;
}

void showSnackbar(String message, {int? duration}) {
  Get.showSnackbar(GetSnackBar(
    message: message,
    duration: Duration(
      seconds: duration ?? 3,
    ),
  ));
}

Future<String> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceId = '';

  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }
    debugPrint('deviceId: $deviceId');
  } catch (e) {
    deviceId = 'Error: $e';
  }
  return deviceId;
}
