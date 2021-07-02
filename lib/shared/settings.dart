import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:step/shared/textstyle.dart';

class UserSettings extends StatelessWidget {
  final String name;
  final String studentClass;
  final String division;
  final String city;
  final String state;
  final String country;
  final String schoolname;
  final String buttonText;
  final Function onPressedSignout;
  final Function onpressedFunc;
  final Color textcolor;
  final Color buttonColor;
  final int timeInMillis;

  const UserSettings(
      {Key key,
      this.name,
      this.studentClass,
      this.division,
      this.city,
      this.state,
      this.country,
      this.schoolname,
      this.buttonText,
      this.onPressedSignout,
      this.onpressedFunc,
      this.textcolor,
      this.buttonColor,
      this.timeInMillis})
      : super(key: key);
  //  var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
  //  var formattedDate = DateFormat('MM/dd, hh:mm a').format(date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040812),
      body: Center(
          child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              // margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 5.0, offset: Offset(0.0, 5.0))]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //StudentClass
                  Text(
                    studentClass ?? "",
                    style: commontextstyle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //Division
                  Text(
                    division ?? "",
                    style: commontextstyle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //schoolname
                  Text(
                    schoolname ?? "",
                    style: commontextstyle,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lime[900]),
                          foregroundColor: MaterialStateProperty.all<Color>(Color(0xffffffff)),
                        ),
                        onPressed: onPressedSignout,
                        child: Text(
                          buttonText,
                          style: commontextstyle,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
                          foregroundColor: MaterialStateProperty.all<Color>(Color(0xffffffff)),
                        ),
                        onPressed: onpressedFunc,
                        child: Text(
                          buttonText,
                          style: commontextstyle,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
