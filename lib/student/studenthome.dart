import 'package:flutter/material.dart';
import 'package:step/services/auth.dart';
import 'package:step/shared/categorycard.dart';
import 'package:step/shared/textstyle.dart';

class StudentsHomeScreen extends StatefulWidget {
  @override
  _StudentsHomeScreenState createState() => _StudentsHomeScreenState();
}

class _StudentsHomeScreenState extends State<StudentsHomeScreen> {
  String name = "Rishi Krishna";
  String grade = "10";
  String division = "D";
  String role = "Student";

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
                      AuthService.signout();
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
                // shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: .75,
                crossAxisSpacing: 1.5,
                mainAxisSpacing: 10.0,
                children: [
                  CategoryCard(
                    title: "live Classes",
                    svgSrc: "assets/homescreen/students/cards/liveclasses.svg",
                    press: () {},
                  ),
                  CategoryCard(
                    title: "Activities",
                    svgSrc: "assets/homescreen/students/cards/activities.svg",
                    press: () {},
                  ),
                  CategoryCard(
                    title: "Textbook pdfs",
                    svgSrc: "assets/homescreen/students/cards/textbookpdf.svg",
                    press: () {},
                  ),
                  CategoryCard(
                    title: "qanda",
                    svgSrc: "assets/homescreen/students/cards/qanda.svg",
                    press: () {},
                  ),
                  CategoryCard(
                    title: "interact",
                    svgSrc: "assets/homescreen/students/cards/interact.svg",
                    press: () {},
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
