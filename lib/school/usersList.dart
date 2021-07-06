import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:step/services/database.dart';

class ListViewOfSchoolUsers extends StatefulWidget {
  @override
  _ListViewOfSchoolUsersState createState() => _ListViewOfSchoolUsersState();
}

class _ListViewOfSchoolUsersState extends State<ListViewOfSchoolUsers> {
  var teachers;
  //Fetch the school uid
  String schoolUidFromDatabase;
  String currentUserUid;
  Future<void> getSchool() async {
    String schoolUidFromFirestore = await UserHelper.getSchoolUid();
    String currentUserUidFromFirestore = await UserHelper.getUserUid();
    setState(() {
      schoolUidFromDatabase = schoolUidFromFirestore;
      currentUserUid = currentUserUidFromFirestore;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSchool();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040812),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 50.0,
          ),
          Container(
            height: 200,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('teacher').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                print(snapshot.data.docs.toString() + 'data');
                // Safety check to ensure that snapshot contains data
                // without this safety check, StreamBuilder dirty state warnings will be thrown
                if (!snapshot.hasData) return Container();
                teachers = snapshot.data.docs[0].get('name');

                // Set this value for default,
                // setDefault will change if an item was selected
                // First item from the List will be displayed
                return DropdownButton(
                  isExpanded: false,
                  value: teachers,
                  items: snapshot.data.docs.map((value) {
                    return DropdownMenuItem(
                      value: value.get('name'),
                      child: Text('${value.get('name')}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    debugPrint('selected onchange: $value');
                    setState(
                      () {
                        debugPrint('make selected: $value');
                        // Selected value will be stored
                        teachers = value;
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
