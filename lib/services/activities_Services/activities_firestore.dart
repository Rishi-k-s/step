import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step/models/activities_Models.dart';

class ActivitiesHelper {
  final String uid;
  ActivitiesHelper({this.uid});

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore _database = FirebaseFirestore.instance;
  static CollectionReference activitiesCollection = FirebaseFirestore.instance.collection('activities');

  Future<void> addChapterToFirebase(
    ActivitiesInfo activitiesInfo,
  ) async {
    final DocumentReference documentReference = activitiesCollection.doc("${activitiesInfo.schoolUid}");
    DocumentReference documentReferencer =
        documentReference.collection("${activitiesInfo.currentClassOnly}").doc('${activitiesInfo.chapterUid}'); // Here the UID should be replaced
    Map<String, dynamic> data = activitiesInfo.toJson();
    print('DATA:\n$data');

    return await documentReferencer.set(data).whenComplete(() => print('Chapter added to the database, id: {${activitiesInfo.chapterUid}}'));
  }
}
