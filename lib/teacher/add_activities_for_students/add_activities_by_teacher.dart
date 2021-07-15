import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:step/services/database.dart';
import 'package:step/shared/loading.dart';
import 'package:step/shared/textstyle.dart';
import 'package:step/teacher/add_activities_for_students/add_Chapter_Name.dart';
import 'package:step/teacher/add_activities_for_students/create_chapter_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AddActivitesForStudents extends StatefulWidget {
  @override
  _AddActivitesForStudentsState createState() => _AddActivitesForStudentsState();
}

class _AddActivitesForStudentsState extends State<AddActivitesForStudents> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  String fullClassName;
  String standard;
  String schoolUidFromDatabase;
  String teacherNameFromDatabase;
  AnimationController _animationController;
  bool floatingActionButtonVisible = true;
  final _formKey = GlobalKey<FormBuilderState>();
  final CollectionReference classesCollection = FirebaseFirestore.instance.collection('classes');

  Future<void> getSchool() async {
    String schoolUidFromFirestore = await UserHelper.getSchoolUidForTeacher();
    String teacherNameFromFirestore = await UserHelper.getTeacherName();
    setState(() {
      schoolUidFromDatabase = schoolUidFromFirestore;
      teacherNameFromDatabase = teacherNameFromFirestore;
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOutSine, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

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
          'Add Activities',
          style: commontextstylewhite,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ListView(
          shrinkWrap: true,
          key: _formKey,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan[600], width: 1.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: classesCollection.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) return Loading();
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: DropdownButtonFormField(
                            hint: Text(
                              '   eg: 1A, 2B, 3D, 4F...',
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            dropdownColor: Colors.blue[900],
                            icon: Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.white,
                            ),
                            iconSize: 40.0,
                            isExpanded: true,
                            validator: (value) => value == null ? 'Required' : null,
                            style: TextStyle(fontSize: 17.0, color: Colors.white, fontFamily: 'LexendDeca'),
                            value: fullClassName,
                            onChanged: (changedValue) {
                              setState(() {
                                fullClassName = changedValue;
                              });
                            },
                            items: snapshot.data.docs.map((value) {
                              return DropdownMenuItem(
                                value: value.get('fullClassName'),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      value.get('fullClassName'),
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
                // only class
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan[600], width: 1.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: classesCollection.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) return Loading();
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: DropdownButtonFormField(
                            hint: Text(
                              '   eg: 1, 2, 3, 4...',
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            dropdownColor: Colors.blue[900],
                            icon: Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.white,
                            ),
                            iconSize: 40.0,
                            isExpanded: true,
                            validator: (value) => value == null ? 'Required' : null,
                            style: TextStyle(fontSize: 17.0, color: Colors.white, fontFamily: 'LexendDeca'),
                            value: standard,
                            onChanged: (changedValue) {
                              setState(() {
                                standard = changedValue;
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
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: floatingActionButtonVisible,
        child: FloatingActionBubble(
          items: <Bubble>[
            // Floating action menu items
            // Bubble(
            //   title: "View Chapter",
            //   iconColor: Colors.white,
            //   bubbleColor: Colors.cyan[800],
            //   icon: Icons.view_agenda_outlined,
            //   titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            //   onPress: () {
            //     _animationController.reverse();
            //   },
            // ),
            Bubble(
              title: "Add Chapter",
              iconColor: Colors.white,
              bubbleColor: Colors.cyan[800],
              icon: Icons.book_outlined,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController.reverse();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddChapterName()),
                );
              },
            ),
          ],
          onPress: () {
            _animationController.isCompleted ? _animationController.reverse() : _animationController.forward();
          },
          iconColor: Colors.white,
          backGroundColor: Colors.cyan[800],
          animation: _animation,
          // iconData: Icons.add,
          animatedIconData: AnimatedIcons.menu_close,
        ),
      ),
    );
  }
}
