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

  Future<void> addClassDataToFirebase(String fullClassName, String schoolUid, String classOnly, String division) async {
    final DocumentReference documentReference = mainCollection.doc("$classOnly");
    DocumentReference documentReferencer = documentReference.collection("$schoolUid").doc('$division');
    return await documentReferencer.set({
      "class": classOnly,
      "division": division,
      "fullClassName": fullClassName,
      // "classUid": uniqueKey,
      "schoolUid": schoolUid,
    });
  }
}
