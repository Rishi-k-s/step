import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddClassFirebaseHelper {
  final String uid;
  AddClassFirebaseHelper({this.uid});

  // static UniqueKey uniqueKey = UniqueKey();
  static FirebaseAuth auth = FirebaseAuth.instance;
  // static FirebaseFirestore _database = FirebaseFirestore.instance;
  static CollectionReference mainCollection = FirebaseFirestore.instance.collection('classes');

  Future<void> addClassDataToFirebase(String studentFullClass, String schoolUid, String classonly) async {
    return await mainCollection.doc(uid).set({
      "class": classonly,
      "fullClassName": studentFullClass,
      // "classUid": uniqueKey,
      "schoolUid": schoolUid,
    });
  }
}
