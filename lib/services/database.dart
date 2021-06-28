import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';
import 'package:step/models/usermodels.dart';

class UserHelper {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore _database = FirebaseFirestore.instance;

  static saveUser(User user) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    Map<String, dynamic> userData = {
      "name": user.displayName,
      "email": user.email,
      "uid": user.uid,
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "build_number": buildNumber,
      "role": "student",
      "standard": "none",
      "division": "none",
      "subject": "none",
      "school": "none",
    };

    final userRef = _database.collection("users1").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "build_number": buildNumber,
      });
    } else {
      await userRef.set(userData);
    }
    await _saveDeviceDetails(user);
  }

  static _saveDeviceDetails(User user) async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String deviceId;
    Map<String, dynamic> deviceData;
    if (Platform.isAndroid) {
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      deviceId = deviceInfo.androidId;
      deviceData = {
        "os_version": deviceInfo.version.sdkInt.toString(),
        "platform": "android",
        "model": deviceInfo.model,
        "device": deviceInfo.device,
      };
    }
    if (Platform.isIOS) {
      final deviceInfo = await deviceInfoPlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceData = {
        "os_version": deviceInfo.systemVersion,
        "platform": "ios",
        "model": deviceInfo.model,
        "device": deviceInfo.name,
      };
    }
    final timeNowInMillisecond = DateTime.now().millisecondsSinceEpoch;

    final deviceRef = _database.collection("users1").doc(user.uid).collection("devices").doc(deviceId);

    if ((await deviceRef.get()).exists) {
      await deviceRef.update({
        "updated_at": timeNowInMillisecond,
        "uninstalled": false,
      });
    } else {
      await deviceRef.set({
        "created_at": timeNowInMillisecond,
        "updated_at": timeNowInMillisecond,
        "uninstalled": false,
        'id': deviceId,
        "device_info": deviceData,
      });
    }
  }

  static Future<String> getuserRole() async {
    final User user = auth.currentUser;
    final uid = user.uid;
    String role = '';
    await FirebaseFirestore.instance.doc('users1/$uid').get().then((value) {
      role = value['role'].toString();
    });
    return role;
  }
}
