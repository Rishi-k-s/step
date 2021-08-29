import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:step/models/class_Calendar_model.dart';
import 'package:flutter/material.dart';

final CollectionReference mainCollection = FirebaseFirestore.instance.collection('liveclasses');
// final DocumentReference documentReference = mainCollection.doc('test');

class Storage {
  Future<void> storeEventData(EventInfo eventInfo, String schoolUid, String fullClassName) async {
    final DocumentReference documentReference = mainCollection.doc("classes");
    DocumentReference documentReferencer = documentReference.collection("$schoolUid").doc(eventInfo.id);

    Map<String, dynamic> data = eventInfo.toJson();

    print('DATA:\n$data');

    await documentReferencer.set(data).whenComplete(() {
      print("Event added to the database, id: {${eventInfo.id}}");
    }).catchError((e) => print(e));
  }

  Future<void> updateEventData(EventInfo eventInfo, String schoolUid, String fullClassName) async {
    final DocumentReference documentReference = mainCollection.doc("classes");
    DocumentReference documentReferencer = documentReference.collection("$schoolUid").doc(eventInfo.id);

    Map<String, dynamic> data = eventInfo.toJson();

    print('DATA:\n$data');

    await documentReferencer.update(data).whenComplete(() {
      print("Event updated in the database, id: {${eventInfo.id}}");
    }).catchError((e) => print(e));
  }

  Future<void> deleteEvent({@required String id, String schoolUid, String fullClassName}) async {
    final DocumentReference documentReference = mainCollection.doc("classes");
    DocumentReference documentReferencer = documentReference.collection('$schoolUid').doc(id);

    await documentReferencer.delete().catchError((e) => print(e));

    print('Event deleted, id: $id');
  }

  Stream<QuerySnapshot> retrieveEventsTeacher(String schoolUid, String teacherUid) {
    final DocumentReference documentReferencees = mainCollection.doc("classes");
    Stream<QuerySnapshot> liveClassTeacherData = documentReferencees.collection("$schoolUid").orderBy('start').snapshots();
    return liveClassTeacherData;
  }

  Stream<QuerySnapshot> retrieveEventsStudent(String schoolUid, String fullClassName) {
    final DocumentReference documentReferencees = mainCollection.doc("classes");
    Stream<QuerySnapshot> liveClassStudentData = documentReferencees.collection("$schoolUid").orderBy('start').snapshots();
    return liveClassStudentData;
  }

// want to cont. frm here

  // Future<void> fetchClassDataFromFirebase() async {
  //   getDocs();
  // }

  // Future getDocs(String schoolUid) async {
  //   var querySnapshot = await FirebaseFirestore.instance.collection("liveclasses").get();
  //   for (int a = 0; a < querySnapshot.docs.length; a++) {
  //     var data = querySnapshot.docs[a].data();

  //     var secondquery = await FirebaseFirestore.instance
  //         .collection("liveclasses")
  //         .doc(querySnapshot.docs[a].data().toString())
  //         // .doc(querySnapshot.docs[a].data()['id'].toString())
  //         .collection("$schoolUid")
  //         .get();
  //     for (int a = 0; a < secondquery.docs.length; a++) {
  //       print("->>>>>>> data " + secondquery.docs[a].data().toString());
  //       print("---------------");
  //       // activityDataOfTheTeacher = secondquery.docs[a].data()['teacherUid'].toString();
  //       // if(secondquery.docs[a].data()['teacherUid'].toString()=='z4jJrG4x4yWIcnQfn6vU8WDFaaq2'){
  //       //   list.add(secondquery.docs[a].data().toString());
  //       //    }

  //     }
  //   }
  // }
}
