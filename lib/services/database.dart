import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';
import 'package:step/models/usermodels.dart';

class UserHelper {
  final String uid;
  UserHelper({this.uid});

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore _database = FirebaseFirestore.instance;

  static saveUser(User user) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    // Map<String, dynamic> userData = {
    //   "name": user.displayName,
    //   "email": user.email,
    //   "uid": user.uid,
    //   "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
    //   "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
    //   "build_number": buildNumber,
    //   "role": "student",
    //   "standard": "none",
    //   "division": "none",
    //   "subject": "none",
    //   "school": "none",
    // };

    final userRef = _database.collection("users1").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "build_number": buildNumber,
      });
    }
    //  else {
    //   await userRef.set(userData);
    // }
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
  // -------------------------------
  // Get roles from firebase
  // -------------------------------

  //student, teaches and admin and school
  static Future<String> getuserRole() async {
    final User user = auth.currentUser;
    final uid = user.uid;
    String role = '';
    await FirebaseFirestore.instance.doc('roles/$uid').get().then((value) {
      role = value['role'].toString();
    });
    return role;
  }

  // school role
  // static Future<String> getSchoolRole() async {
  //   final User user = auth.currentUser;
  //   final uid = user.uid;
  //   String role = '';
  //   await FirebaseFirestore.instance.doc('schools/$uid').get().then((value) {
  //     role = value['role'].toString();
  //   });
  //   return role;
  // }
// ----------------------------------------------------
// ----------------------------------------------------
// ----------------------------------------------------
  // Get School name From firebase
  static Future<String> getSchoolName() async {
    final User user = auth.currentUser;
    final uid = user.uid;
    String schoolname = '';
    await FirebaseFirestore.instance.doc('users1/$uid').get().then((value) {
      schoolname = value['name'].toString();
    });
    return schoolname;
  }

//Registeration of users
  Future<void> addSchoolDataToFirebase(
    String name,
    String email,
    String role,
    String city,
    String state,
    String country,
    String collectionWhereUserShouldBe,
    //  String standard, String division, String subject
  ) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    return await _database.collection(collectionWhereUserShouldBe).doc(uid).set({
      "name": name,
      "email": email,
      "uid": uid,
      // "last_login": uid.metadata.lastSignInTime.millisecondsSinceEpoch,
      // "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "build_number": buildNumber,
      "role": role,
      "city": city,
      "state": state,
      "country": country,
    });
  }

  //Add user to firebase
  Future<void> addUserDataToFirebase(
    String name,
    String email,
    String role,
    String city,
    String state,
    String country,
    String standard,
    String division,
    String subject,
    String collectionWhereUserShouldBe,
    String school,
  ) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    return await _database.collection(collectionWhereUserShouldBe).doc(uid).set({
      "name": name,
      "email": email,
      "uid": uid,
      // "last_login": uid.metadata.lastSignInTime.millisecondsSinceEpoch,
      // "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "standard": standard,
      "division": division,
      "subject": subject,
      // "build_number": buildNumber,
      "role": role,
      "city": city,
      "state": state,
      "country": country,
      "school": school
    });
  }

  //Adding role data to roles in firebase
  Future<void> addRoleDataToFirebase(
    String collectionWhereRoleShouldBe,
    String role,
    //  String standard, String division, String subject
  ) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return await _database.collection(collectionWhereRoleShouldBe).doc(uid).set({
      "uid": uid,
      "role": role,
    });
  }
}
