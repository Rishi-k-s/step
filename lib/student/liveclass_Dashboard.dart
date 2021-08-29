import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:step/models/class_Calendar_model.dart';
import 'package:step/services/calendar_services/calendar_firestore_storage.dart';
import 'package:step/services/database.dart';
import 'package:step/shared/textstyle.dart';
import 'package:step/teacher/add_classes_for_students/create_class_by_teacher.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewClassByStudent extends StatefulWidget {
  @override
  _ViewClassByStudentState createState() => _ViewClassByStudentState();
}

class _ViewClassByStudentState extends State<ViewClassByStudent> {
  String schoolUidFromDatabase;
  String studentFullClassFromDatabase;
  String studentUidFromDatabase;

  Storage storage = Storage();
  int _currentIndex = 0;
  List<String> uidList = <String>[];

  Future<void> getSchool() async {
    String schoolUidFromFirestore = await UserHelper.getSchoolUidForStudent();
    String studentFullClassFromFirestore = await UserHelper.getStudentFullClass();
    String studentUidFromFirestore = await UserHelper.getUserUid();
    setState(() {
      schoolUidFromDatabase = schoolUidFromFirestore;
      studentUidFromDatabase = studentUidFromFirestore;
      studentFullClassFromDatabase = studentFullClassFromFirestore;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSchool();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040812),
      appBar: AppBar(
        backgroundColor: Color(0xff0a2057),
        title: Text(
          'Virtual Classes',
          style: commontextstylewhite,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: storage.retrieveEventsTeacher(schoolUidFromDatabase, studentUidFromDatabase),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> eventInfo = snapshot.data.docs[index].data() as Map<String, dynamic>;

                      EventInfo event = EventInfo.fromMap(eventInfo);

                      DateTime startTime = DateTime.fromMillisecondsSinceEpoch(event.startTimeInEpoch);
                      DateTime endTime = DateTime.fromMillisecondsSinceEpoch(event.endTimeInEpoch);

                      String startTimeString = DateFormat.jm().format(startTime);
                      String endTimeString = DateFormat.jm().format(endTime);
                      String dateString = DateFormat.yMMMMd().format(startTime);
                      if (event.fullClassName == studentFullClassFromDatabase) {
                        return Padding(
                          padding: EdgeInsets.all(10.0),
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    bottom: 16.0,
                                    top: 16.0,
                                    left: 16.0,
                                    right: 16.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        event.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                        child: InkWell(
                                          onTap: () async {
                                            if (await canLaunch(event.link)) {
                                              CircularProgressIndicator();
                                              await launch(event.link);
                                            } else {
                                              throw 'Could not launch $event.link';
                                            }
                                          },
                                          child: Text(
                                            event.link,
                                            style: TextStyle(
                                              color: Colors.blue[400],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 5,
                                            // color: CustomColor.neon_green,
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                dateString,
                                                style: TextStyle(
                                                  // color: CustomColor.dark_cyan,
                                                  fontFamily: 'OpenSans',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  letterSpacing: 1.5,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                '$startTimeString - $endTimeString',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'No Classes Assigned Today',
                            style: bigtextstyle,
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  );
                }
              } else {
                return Center(
                  child: Text(
                    'No Classes Assigned',
                    style: TextStyle(
                      color: Colors.black38,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
