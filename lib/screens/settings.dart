import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:step/services/auth.dart';
import 'package:step/shared/textstyle.dart';

class UserSettings extends StatelessWidget {
  String name;
  String changeCity;
  String changeState;
  String changeCountry;
  String studentDivision;
  String studentClass;
  String schoolName;
  String teacherSubject;
  bool isTeacher;
  bool isStudent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        elevation: 0,
        backgroundColor: Color(0xff0a2057),
      ),
      backgroundColor: Color(0xff040812),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.fromLTRB(10, 25, 10, 10),
              color: Colors.cyan[900],
              child: ListTile(
                onTap: () {
                  //edit
                },
                title: Text(
                  name ?? "Name",
                  style: commontextstylewhite,
                ),
                trailing: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                leading: CircleAvatar(
                  child: Image.asset('assets/icon/avatar/Avatar.png'),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.fromLTRB(25, 0, 25, 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              color: Color(0xff0a2057),
              child: Column(
                children: [
                  Align(
                    widthFactor: 30.0,
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.location_city_rounded,
                      color: Colors.cyan[900],
                      size: 40.0,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Change City - $changeCity",
                      style: commontextstylewhite,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.white,
                    ),
                    onTap: () {},
                  ),
                  _buildDivider(),
                  ListTile(
                    title: Text(
                      "Change State - $changeState",
                      style: commontextstylewhite,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.white,
                    ),
                    onTap: () {},
                  ),
                  _buildDivider(),
                  ListTile(
                    title: Text(
                      "Change Country - $changeCountry",
                      style: commontextstylewhite,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.white,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Details",
                style: bigtextstyle,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "School - $schoolName",
                      style: commontextstylewhite,
                    ),
                    onTap: () {},
                  ),
                  _buildDivider(),
                  ListTile(
                    title: Text(
                      "Class - $studentClass",
                      style: commontextstylewhite,
                    ),
                    onTap: () {},
                  ),
                  _buildDivider(),
                  ListTile(
                    title: Text(
                      "Division - $studentDivision",
                      style: commontextstylewhite,
                    ),
                    onTap: () {},
                  ),
                  _buildDivider(),
                  ListTile(
                    title: Text(
                      "Subject - $teacherSubject",
                      style: commontextstylewhite,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              width: 140.0,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red[600]),
                  foregroundColor: MaterialStateProperty.all<Color>(Color(0xffffffff)),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  AuthService.signout();
                },
                child: Text(
                  'Sign Out',
                  style: commontextstyle,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

Container _buildDivider() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10.0),
    width: double.infinity,
    height: 1.0,
    color: Colors.white,
  );
}
