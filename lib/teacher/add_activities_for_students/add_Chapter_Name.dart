import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:step/models/activities_Models.dart';
import 'package:step/services/activities_Services/activities_firestore.dart';
import 'package:step/services/database.dart';
import 'package:step/shared/decoration_formatting.dart';
import 'package:step/shared/textstyle.dart';
import 'package:step/teacher/add_activities_for_students/create_chapter_screen.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class AddChapterName extends StatefulWidget {
  @override
  _AddChapterNameState createState() => _AddChapterNameState();
}

class _AddChapterNameState extends State<AddChapterName> {
  final _formKey = GlobalKey<FormState>();

  ActivitiesHelper activitiesHelper = ActivitiesHelper();

  String chapterName;
  String fullClassName = "10 A";
  String currentClassOnly = "10";
  String schoolUid;

  // String uniqueKeyString;
  // var uniqueKey = UniqueKey();
  //get school details from datbase
  String platformVersionUid = 'Unknown';
  String schoolNameFromDatabase;
  String schoolUidFromDatabase;

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  Future<void> getSchool() async {
    String schoolNameFromFirestore = await UserHelper.getSchoolNameForTeacher();
    String schoolUidFromFirestore = await UserHelper.getSchoolUidForTeacher();
    setState(() {
      schoolNameFromDatabase = schoolNameFromFirestore;
      schoolUidFromDatabase = schoolUidFromFirestore;
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              heightFactor: 4.0,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                      text: 'Chapter Name',
                      style: teacherRichTextStyle,
                      children: theRedStarAboveName,
                    )),
                    Text(
                      'This adds a new chapter with this name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      cursorColor: Colors.blue[800],
                      textCapitalization: TextCapitalization.characters,
                      validator: (value) => value == null ? 'Required' : null,
                      onChanged: (changedValue) {
                        setState(() {
                          chapterName = changedValue;
                        });
                      },
                      readOnly: false,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      decoration: new InputDecoration(
                        disabledBorder: inputDisabaledWithEnabledBorderDecoration,
                        enabledBorder: inputDisabaledWithEnabledBorderDecoration,
                        focusedBorder: inputFocusedBorderDecoration,
                        errorBorder: inputErrorBorderDecoration,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 16,
                          bottom: 16,
                          top: 16,
                          right: 16,
                        ),
                        hintText: 'eg: September 10, 2020',
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue[600]),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            int timeAsString = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            ).millisecondsSinceEpoch;

                            setState(() {
                              print('the chapter name is $chapterName');
                              print("uid is $timeAsString");

                              // uniqueKey = uniqueKeyString as UniqueKey;
                            });

                            ActivitiesInfo activitiesInfo = ActivitiesInfo(
                              chapterName: chapterName,
                              chapterUid: timeAsString,
                              fullClassName: fullClassName,
                              currentClassOnly: currentClassOnly,
                              schoolUid: schoolUidFromDatabase,
                            );
                            await activitiesHelper
                                .addChapterToFirebase(activitiesInfo)
                                .whenComplete(() => Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CreateChapterByTeachers()),
                                    ))
                                .catchError(
                                  (e) => print(e),
                                );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Text(
                            'Add Class',
                            style: commontextstylewhite,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
