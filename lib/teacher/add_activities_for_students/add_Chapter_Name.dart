import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:step/models/activities_model/activities_Models.dart';
import 'package:step/services/activities_Services/activities_firestore.dart';
import 'package:step/services/database.dart';
import 'package:step/shared/decoration_formatting.dart';
import 'package:step/shared/loading.dart';
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
  String fullClassName;
  String currentClassOnly;
  String schoolUid;

  // String uniqueKeyString;
  // var uniqueKey = UniqueKey();
  //get school details from datbase
  String schoolNameFromDatabase;
  String schoolUidFromDatabase;
  String teacherUid;
  String teacherSubjectFromDatabase;

  TextEditingController textControllerChapterName;
  TextEditingController textControllerDropDown;

  FocusNode textFocusNodeChapterName;
  FocusNode textFocusNodeDropDown;

  final CollectionReference classesCollection = FirebaseFirestore.instance.collection('classes');
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  Future<void> getSchool() async {
    String schoolNameFromFirestore = await UserHelper.getSchoolNameForTeacher();
    String schoolUidFromFirestore = await UserHelper.getSchoolUidForTeacher();
    String teacherSubjectFromFirestore = await UserHelper.getTeachSubject();
    String teacherUidFromFirestore = await UserHelper.getUserUid();
    setState(() {
      schoolNameFromDatabase = schoolNameFromFirestore;
      schoolUidFromDatabase = schoolUidFromFirestore;
      teacherSubjectFromDatabase = teacherSubjectFromFirestore;
      teacherUid = teacherUidFromFirestore;
    });
  }

  @override
  void initState() {
    textControllerDropDown = TextEditingController();
    textControllerChapterName = TextEditingController();

    textFocusNodeChapterName = FocusNode();
    textFocusNodeDropDown = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSchool();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DocumentReference documentReference = classesCollection.doc();
    CollectionReference schoolUidFromClassesCollection = documentReference.collection("$schoolUidFromDatabase");
    var testref = schoolUidFromClassesCollection.doc("class");
    print(testref);
    return Scaffold(
      backgroundColor: Color(0xff040812),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              heightFactor: 2.0,
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
                      'This adds a new chapter for $teacherSubjectFromDatabase',
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
                      focusNode: textFocusNodeChapterName,
                      controller: textControllerChapterName,
                      cursorColor: Colors.blue[800],
                      textCapitalization: TextCapitalization.words,
                      validator: (val) => val.isEmpty ? 'Required' : null,
                      onChanged: (val) {
                        setState(() {
                          chapterName = val;
                        });
                      },
                      onFieldSubmitted: (value) {
                        textFocusNodeChapterName.unfocus();
                        FocusScope.of(context).requestFocus(textFocusNodeDropDown);
                      },
                      readOnly: false,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      decoration: InputDecoration(
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
                    SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.cyan[600], width: 1.0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: schoolUidFromClassesCollection.snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) return Loading();
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: DropdownButtonFormField(
                                focusNode: textFocusNodeDropDown,
                                // onSaved: (value) {
                                //   textFocusNodeDropDown.unfocus();
                                //   FocusScope.of(context).requestFocus(textFocusNodeDropDown);
                                // },
                                hint: Text(
                                  '   eg: class 3, 5, 10, 11...',
                                  style: TextStyle(
                                    color: Colors.grey.withOpacity(0.6),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                dropdownColor: Colors.grey[850],
                                icon: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.white,
                                ),
                                iconSize: 40.0,
                                isExpanded: true,
                                validator: (val) => val.isEmpty ? 'Required' : null,
                                style: TextStyle(fontSize: 17.0, color: Colors.white, fontFamily: 'LexendDeca'),
                                value: currentClassOnly,
                                onChanged: (val) {
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    currentClassOnly = val;
                                  });
                                },
                                items: snapshot.data.docs.map((value) {
                                  return DropdownMenuItem(
                                    value: value.get('class'),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          value.get('class'),
                                          style: commontextstyle,
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          },
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
                            int timeAsString = DateTime(date.year, date.month, date.day, time.hour, time.minute, date.second, date.microsecond,
                                    date.millisecondsSinceEpoch)
                                .millisecondsSinceEpoch;

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
                              teacherSubject: teacherSubjectFromDatabase,
                              teacherUid: teacherUid,
                            );
                            await activitiesHelper.addChapterToFirebase(activitiesInfo).whenComplete(() {
                              // Navigator.pop(context);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => CreateChapterByTeachers(
                                        schoolUid: schoolUid,
                                        teacherUid: teacherUid,
                                        teacherSubject: teacherSubjectFromDatabase,
                                        currentClassOnly: currentClassOnly,
                                        chapterName: chapterName,
                                      )));
                            }).catchError(
                              (e) => print(e),
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Text(
                            'Add Chapter',
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
