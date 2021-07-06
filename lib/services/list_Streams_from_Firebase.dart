// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:step/services/database.dart';

//   //get school details from datbase
//   String schoolNameFromDatabase;
//   String schoolUidFromDatabase;
// class ListHelper {
//   Future<void> getSchool() async {
//     String schoolUidFromFirestore = await UserHelper.getSchoolUid();
//     setState(() {
//       schoolUidFromDatabase = schoolUidFromFirestore;
//     });
//   }

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       getSchool();
//     });
//     // TODO: implement initState
//     super.initState();
//   }
//   final String uid;
//   ListHelper({this.uid});

//   static FirebaseAuth auth = FirebaseAuth.instance;
//   static FirebaseFirestore _teacherList = FirebaseFirestore.instance.collection('teachers').firestore;

//   Stream<QuerySnapshot> get teacherList {
//     return _teacherList.snapshotsInSync();
//   }

//   void setState(Null Function() param0) {}
// }
