import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:step/models/class_Calendar_model.dart';
import 'package:flutter/material.dart';

final CollectionReference mainCollection = FirebaseFirestore.instance.collection('liveclasses');
// final DocumentReference documentReference = mainCollection.doc('test');

class Storage {
  Future<void> storeEventData(EventInfo eventInfo, String schoolUid, String fullClassName) async {
    final DocumentReference documentReference = mainCollection.doc("$fullClassName");
    DocumentReference documentReferencer = documentReference.collection("$schoolUid").doc(eventInfo.id);

    Map<String, dynamic> data = eventInfo.toJson();

    print('DATA:\n$data');

    await documentReferencer.set(data).whenComplete(() {
      print("Event added to the database, id: {${eventInfo.id}}");
    }).catchError((e) => print(e));
  }

  Future<void> updateEventData(EventInfo eventInfo, String schoolUid, String fullClassName) async {
    final DocumentReference documentReference = mainCollection.doc("$fullClassName");
    DocumentReference documentReferencer = documentReference.collection("$schoolUid").doc(eventInfo.id);

    Map<String, dynamic> data = eventInfo.toJson();

    print('DATA:\n$data');

    await documentReferencer.update(data).whenComplete(() {
      print("Event updated in the database, id: {${eventInfo.id}}");
    }).catchError((e) => print(e));
  }

  Future<void> deleteEvent({@required String id, String schoolUid, String fullClassName}) async {
    final DocumentReference documentReference = mainCollection.doc("$fullClassName");
    DocumentReference documentReferencer = documentReference.collection('$schoolUid').doc(id);

    await documentReferencer.delete().catchError((e) => print(e));

    print('Event deleted, id: $id');
  }

  Stream<QuerySnapshot> retrieveEvents(String schoolUid, String fullClassName) {
    final DocumentReference documentReference = mainCollection.doc("$schoolUid");
    Stream<QuerySnapshot> myClasses = documentReference.collection("$fullClassName").orderBy('start').snapshots();

    return myClasses;
  }
}
