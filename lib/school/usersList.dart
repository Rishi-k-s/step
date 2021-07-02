import 'package:flutter/material.dart';

class ListViewOfSchoolUsers extends StatefulWidget {
  @override
  _ListViewOfSchoolUsersState createState() => _ListViewOfSchoolUsersState();
}

class _ListViewOfSchoolUsersState extends State<ListViewOfSchoolUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040812),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 50.0,
          )
        ],
      )),
    );
  }
}
