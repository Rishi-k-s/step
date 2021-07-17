import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step/models/activities_model/activities_Models.dart';

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
    DocumentReference documentReferencer = documentReference.collection("${activitiesInfo.currentClassOnly}").doc('${activitiesInfo.chapterUid}');
    Map<String, dynamic> data = activitiesInfo.toJson();
    print('DATA:\n$data');

    return await documentReferencer.set(data).whenComplete(() => print('Chapter added to the database, id: {${activitiesInfo.chapterUid}}'));
  }

  //Get Basic Activities Data From Firebase

  static Future<ActivitiesInfo> getBasicChapterDetalis(String schoolUid, String chapterUid, String currentClassUid) async {
    final DocumentReference documentReference = activitiesCollection.doc(schoolUid);
    DocumentReference documentReferencer = documentReference.collection(currentClassUid).doc(chapterUid);
    final User user = auth.currentUser;
    final uid = user.uid;
    String schoolname = '';
    await documentReferencer.get().then((value) {
      schoolname = value['subject'].toString();
    });
  }
}
