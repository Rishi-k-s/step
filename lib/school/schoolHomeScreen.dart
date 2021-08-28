import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:step/school/adduserFromSchool.dart';
import 'package:step/school/usersList.dart';
import 'package:step/school/which_Class_Selector.dart';
import 'package:step/services/auth.dart';
import 'package:step/shared/categorycard.dart';
import 'package:step/screens/settings.dart';
import 'package:step/shared/textstyle.dart';

class SchoolHomeScreen extends StatefulWidget {
  @override
  _SchoolHomeScreenState createState() => _SchoolHomeScreenState();
}

class _SchoolHomeScreenState extends State<SchoolHomeScreen> {
  String name = "School";
  String grade = "10";
  String division = "D";
  String role = "School";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040812),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 25.0,
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 12.0,
                  ),
                  Container(
                    height: 80.0,
                    width: 80.0,
                    child: CircleAvatar(
                      child: Image.asset('assets/icon/avatar/Avatar.png'),
                    ),
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: bigtextstyle,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              grade,
                              style: bigtextstyle,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              division,
                              style: bigtextstyle,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              role,
                              style: bigtextstyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    color: Colors.white,
                    iconSize: 40.0,
                    //the settings button for now does log oufu
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserSettings()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                // shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: .75,
                crossAxisSpacing: 1.5,
                mainAxisSpacing: 10.0,
                children: [
                  CategoryCard(
                    title: "view users",
                    svgSrc: "assets/homescreen/school/home cards/add user.svg",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddUserFromSchool()),
                      );
                    },
                  ),
                  CategoryCard(
                    title: "add user",
                    svgSrc: "assets/homescreen/school/home cards/create user.svg",
                    press: () {
                      //---/Really what the code is \---
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ListViewOfSchoolUsers()),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ClassDivisionSelection()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
