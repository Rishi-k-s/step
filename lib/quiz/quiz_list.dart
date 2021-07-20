import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class QuizList extends StatefulWidget {

  @override
  _DummyListState createState() => _DummyListState();
}

class _DummyListState extends State<QuizList> {
  List<String> list=[];

  Future<void> fetchFromFirebase() async {
    getDocs();
  }
  Future getDocs() async {

    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("quiz").get();
    for(int a=0;a<querySnapshot.docs.length;a++){

     list.add(querySnapshot.docs[a].data().toString());
    }
    setState(() {

    });
  }

  @override
  void initState() {
    getDocs();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz List'),
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
