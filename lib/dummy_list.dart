import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class DummyList extends StatefulWidget {

  @override
  _DummyListState createState() => _DummyListState();
}

class _DummyListState extends State<DummyList> {
  List<String> list=[];

  Future<void> fetchFromFirebase() async {
    getDocs();
  }
  Future getDocs() async {


    var querySnapshot =
    await FirebaseFirestore.instance.collection("liveclasses").get();
    for(int a=0;a<querySnapshot.docs.length;a++){
      var data=querySnapshot.docs[a].data();

      var secondquery =
      await FirebaseFirestore.instance.collection("liveclasses").
      doc(querySnapshot.docs[a].data()['id'].toString()).collection('M0KFbdydm7OxyzBtXughpPwcEgq2').get();
      for(int a=0;a<secondquery.docs.length;a++){
        print("->>>>>>> data "+secondquery.docs[a].data().toString());
        print("---------------");
        if(secondquery.docs[a].data()['teacherUid'].toString()=='z4jJrG4x4yWIcnQfn6vU8WDFaaq2'){
          list.add(secondquery.docs[a].data().toString());
          setState(() {

          });
        }

      }
    }
  }

  @override
  void initState() {
    fetchFromFirebase();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // fetchFromFirebase();
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context,i){
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(list[i],style: TextStyle(
              color: Colors.black
            ),),
          );
      }),
    );
  }
}
