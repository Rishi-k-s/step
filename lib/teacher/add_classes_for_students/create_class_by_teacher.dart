import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:step/services/calendar_services/calendar_client.dart';
import 'package:step/services/database.dart';
import 'package:step/shared/decoration_formatting.dart';
import 'package:step/shared/textstyle.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:intl/intl.dart';
import 'package:step/models/class_Calendar_model.dart';
import 'package:step/services/calendar_services/calendar_firestore_storage.dart';

class CreateClassPage extends StatefulWidget {
  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  Storage storage = Storage();
  CalendarClient calendarClient = CalendarClient();

  TextEditingController textControllerDate;
  TextEditingController textControllerStartTime;
  TextEditingController textControllerEndTime;
  TextEditingController textControllerTitle;
  TextEditingController textControllerDescription;
  TextEditingController textControllerLocation;
  TextEditingController textControllerAttendee;
  TextEditingController textControllerCurrentFullClass;
  TextEditingController textControllerStandard;
  TextEditingController textControllerSchoolUid;

  FocusNode textFocusNodeTitle;
  FocusNode textFocusNodeDescription;
  FocusNode textFocusNodeLocation;
  FocusNode textFocusNodeAttendee;
  FocusNode textFocusNodeCurrentFullClass;
  FocusNode textFocusNodeStandard;
  FocusNode textFocusNodeSchoolUid;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  String currentTitle;
  String currentDescription;
  String currentLocation;
  String currentEmail;
  String currentFullClass;
  String standard;
  String division;
  // String schoolUid;
  String teacherName;
  String errorString = '';
  // Get School UID from
  String schoolUidFromDatabase;
  String teacherNameFromDatabase;

  Future<void> getSchool() async {
    String schoolUidFromFirestore = await UserHelper.getSchoolUidForTeacher();
    String teacherNameFromFirestore = await UserHelper.getTeacherName();
    setState(() {
      schoolUidFromDatabase = schoolUidFromFirestore;
      teacherNameFromDatabase = teacherNameFromFirestore;
    });
  }

  // List<String> attendeeEmails = [];
  List<calendar.EventAttendee> attendeeEmails = [];
  // List of class and Division
  List dropdownClass = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];
  List dropdownDivision = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"];

  bool isEditingDate = false;
  bool isEditingStartTime = false;
  bool isEditingEndTime = false;
  bool isEditingBatch = false;
  bool isEditingTitle = false;
  bool isEditingEmail = false;
  bool isEditingLink = false;
  bool isEditingStandard = false;
  bool isEditingDivision = false;
  bool isErrorTime = false;
  bool shouldNofityAttendees = false;
  bool hasConferenceSupport = false;

  bool isDataStorageInProgress = false;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        textControllerDate.text = DateFormat.yMMMMd().format(selectedDate);
      });
    }
  }

  _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
        textControllerStartTime.text = selectedStartTime.format(context);
      });
    } else {
      setState(() {
        textControllerStartTime.text = selectedStartTime.format(context);
      });
    }
  }

  _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );
    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
        textControllerEndTime.text = selectedEndTime.format(context);
      });
    } else {
      setState(() {
        textControllerEndTime.text = selectedEndTime.format(context);
      });
    }
  }

  String _validateTitle(String value) {
    if (value != null) {
      value = value?.trim();
      if (value.isEmpty) {
        return 'Title can\'t be empty';
      }
    } else {
      return 'Title can\'t be empty';
    }

    return null;
  }

  String _validateEmail(String value) {
    if (value != null) {
      value = value.trim();

      if (value.isEmpty) {
        return 'Can\'t add an empty email';
      } else {
        final regex = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
        final matches = regex.allMatches(value);
        for (Match match in matches) {
          if (match.start == 0 && match.end == value.length) {
            return null;
          }
        }
      }
    } else {
      return 'Can\'t add an empty email';
    }

    return 'Invalid email';
  }

  @override
  void initState() {
    textControllerDate = TextEditingController();
    textControllerStartTime = TextEditingController();
    textControllerEndTime = TextEditingController();
    textControllerTitle = TextEditingController();
    textControllerDescription = TextEditingController();
    textControllerLocation = TextEditingController();
    textControllerAttendee = TextEditingController();
    textControllerSchoolUid = TextEditingController();
    textControllerStandard = TextEditingController();
    textControllerCurrentFullClass = TextEditingController();

    textFocusNodeTitle = FocusNode();
    textFocusNodeDescription = FocusNode();
    textFocusNodeLocation = FocusNode();
    textFocusNodeAttendee = FocusNode();
    textFocusNodeCurrentFullClass = FocusNode();
    textFocusNodeStandard = FocusNode();
    textFocusNodeSchoolUid = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSchool();
    });

    super.initState();
  }

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0a2057),
        title: Text('Add Class'),
      ),
      backgroundColor: Color(0xff040812),
      body: ListView(
        key: _formKey,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15.0),
        children: [
          FormBuilder(
              child: Column(
            children: [
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  'This will add a new class to the given Date',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    fontSize: 17.0,
                  ),
                ),
              ),
              Center(child: SizedBox(height: 10)),
              Text(
                'You will have access to modify or remove the classes afterwards',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Theme(
                data: new ThemeData(
                  primaryColor: Colors.white,
                  primaryColorDark: Colors.white,
                ),
                child: Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  color: Color(0xff0a2057),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      FormBuilderTextField(
                        enabled: true,
                        cursorColor: Colors.blue[800],
                        focusNode: textFocusNodeTitle,
                        controller: textControllerTitle,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        name: 'title',
                        onChanged: (value) {
                          setState(() {
                            isEditingTitle = true;
                            currentTitle = value;
                          });
                        },
                        onSubmitted: (value) {
                          textFocusNodeTitle.unfocus();
                          FocusScope.of(context).requestFocus(textFocusNodeDescription);
                        },
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.title_rounded,
                            color: Colors.white70,
                            size: 30.0,
                          ),
                          hintText: "Add Title (Required)",
                          hintStyle: TextStyle(color: Colors.white70, fontSize: 15.0),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 48.0),
                          errorText: isEditingTitle ? _validateTitle(currentTitle) : null,
                          errorStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.redAccent, width: 2),
                          ),
                        ),
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.white,
                        indent: 25.0,
                        endIndent: 25.0,
                      ),
                      FormBuilderTextField(
                        enabled: true,
                        name: 'description',
                        cursorColor: Colors.blue[800],
                        focusNode: textFocusNodeDescription,
                        controller: textControllerDescription,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          setState(() {
                            currentDescription = value;
                          });
                        },
                        onSubmitted: (value) {
                          textFocusNodeDescription.unfocus();
                          FocusScope.of(context).requestFocus(textFocusNodeLocation);
                        },
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                        decoration: InputDecoration(
                          hintText: "Add Description",
                          hintStyle: TextStyle(color: Colors.white70, fontSize: 15.0),
                          prefixIcon: Icon(
                            Icons.short_text,
                            color: Colors.white70,
                            size: 30.0,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 48.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.redAccent, width: 2),
                          ),
                        ),
                        maxLines: 5,
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.white,
                        indent: 25.0,
                        endIndent: 25.0,
                      ),
                      FormBuilderTextField(
                        enabled: true,
                        name: 'location',
                        cursorColor: Colors.blue[800],
                        focusNode: textFocusNodeLocation,
                        controller: textControllerLocation,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          setState(() {
                            currentLocation = value;
                          });
                        },
                        onSubmitted: (value) {
                          textFocusNodeDescription.unfocus();
                          FocusScope.of(context).requestFocus(textFocusNodeCurrentFullClass);
                        },
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                        decoration: InputDecoration(
                          hintText: "Location",
                          hintStyle: TextStyle(color: Colors.white70, fontSize: 15.0),
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.white70,
                            size: 30.0,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 48.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.redAccent, width: 2),
                          ),
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                      text: 'Select Class',
                      style: teacherRichTextStyle,
                      children: theRedStarAboveName,
                    )),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.cyan[600], width: 1.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                        items: dropdownClass.map((changedItem) {
                          return DropdownMenuItem(
                            value: changedItem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  changedItem,
                                  style: commontextstyle,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RichText(
                        text: TextSpan(
                      text: 'Select Division',
                      style: teacherRichTextStyle,
                      children: theRedStarAboveName,
                    )),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.cyan[600], width: 1.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonFormField(
                        hint: Text(
                          '   eg: A, B, C, D...',
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
                        value: division,
                        onChanged: (changedValue) {
                          setState(() {
                            division = changedValue;
                          });
                        },
                        items: dropdownDivision.map((changedItem) {
                          return DropdownMenuItem(
                            value: changedItem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  changedItem,
                                  style: commontextstyle,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    // RichText(
                    //     text: TextSpan(
                    //   text: 'Add existing class',
                    //   style: teacherRichTextStyle,
                    //   children: theRedStarAboveName,
                    // )),
                    SizedBox(
                      height: 10.0,
                    ),
                    RichText(
                        text: TextSpan(
                      text: 'Select Date',
                      style: teacherRichTextStyle,
                      children: theRedStarAboveName,
                    )),
                    SizedBox(height: 10),
                    TextField(
                      cursorColor: Colors.blue[800],
                      controller: textControllerDate,
                      textCapitalization: TextCapitalization.characters,
                      onTap: () => _selectDate(context),
                      readOnly: true,
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
                          color: Colors.grey.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        errorText: isEditingDate && textControllerDate.text != null
                            ? textControllerDate.text.isNotEmpty
                                ? null
                                : 'Date can\'t be empty'
                            : null,
                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    RichText(
                        text: TextSpan(
                      text: 'Start Time',
                      style: teacherRichTextStyle,
                      children: theRedStarAboveName,
                    )),
                    SizedBox(height: 10),
                    TextField(
                      cursorColor: Colors.blue[800],
                      controller: textControllerStartTime,
                      textCapitalization: TextCapitalization.characters,
                      onTap: () => _selectStartTime(context),
                      readOnly: true,
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
                        hintText: 'eg: 09:30 AM',
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        errorText: isEditingStartTime && textControllerStartTime.text != null
                            ? textControllerStartTime.text.isNotEmpty
                                ? null
                                : 'Start time can\'t be empty'
                            : null,
                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    //end Time
                    RichText(
                        text: TextSpan(
                      text: 'End Time',
                      style: teacherRichTextStyle,
                      children: theRedStarAboveName,
                    )),
                    SizedBox(height: 10),
                    TextField(
                      cursorColor: Colors.blue[800],
                      controller: textControllerEndTime,
                      textCapitalization: TextCapitalization.characters,
                      onTap: () => _selectEndTime(context),
                      readOnly: true,
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
                        hintText: 'eg: 11:30 AM',
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        errorText: isEditingEndTime && textControllerEndTime.text != null
                            ? textControllerEndTime.text.isNotEmpty
                                ? null
                                : 'End Time can\'t be empty'
                            : null,
                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    RichText(
                        text: TextSpan(
                      text: 'Attendees',
                      style: teacherRichTextStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 28,
                          ),
                        ),
                      ],
                    )),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: PageScrollPhysics(),
                      itemCount: attendeeEmails.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                attendeeEmails[index].email,
                                style: TextStyle(
                                  color: Colors.greenAccent[700],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    attendeeEmails.removeAt(index);
                                  });
                                },
                                color: Colors.red,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            enabled: true,
                            cursorColor: Colors.blue[800],
                            focusNode: textFocusNodeAttendee,
                            controller: textControllerAttendee,
                            textCapitalization: TextCapitalization.none,
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              setState(() {
                                currentEmail = value;
                              });
                            },
                            onSubmitted: (value) {
                              textFocusNodeAttendee.unfocus();
                            },
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              letterSpacing: 0.6,
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
                              hintText: 'Enter attendee email',
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                              errorText: isEditingEmail ? _validateEmail(currentEmail) : null,
                              errorStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.blue[800],
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              isEditingEmail = true;
                            });
                            if (_validateEmail(currentEmail) == null) {
                              setState(() {
                                textFocusNodeAttendee.unfocus();
                                calendar.EventAttendee eventAttendee = calendar.EventAttendee();
                                eventAttendee.email = currentEmail;

                                attendeeEmails.add(eventAttendee);

                                textControllerAttendee.text = '';
                                currentEmail = null;
                                isEditingEmail = false;
                              });
                            }
                          },
                        ),
                      ],
                    ),

                    Visibility(
                      visible: attendeeEmails.isNotEmpty,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Notify attendees',
                                style: TextStyle(
                                  color: Colors.cyan[600],
                                  fontFamily: 'LexendDeca',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Switch(
                                value: shouldNofityAttendees,
                                onChanged: (value) {
                                  setState(() {
                                    shouldNofityAttendees = value;
                                  });
                                },
                                activeColor: Colors.blue[800],
                                inactiveTrackColor: Colors.grey[600],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    // FormBuilderSwitch(
                    //   decoration: InputDecoration(border: InputBorder.none),
                    //   name: 'addvidconf',
                    //   title: Text(
                    //     'Add Virtual Class',
                    //     style: commontextstylewhite,
                    //   ),
                    //   initialValue: true,
                    //   inactiveTrackColor: Colors.grey[600],

                    //   onChanged: (value){
                    //     setState(() {
                    //       hasConferenceSupport = value;
                    //     });
                    //   },
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Virtual Class',
                          style: TextStyle(
                            color: Colors.cyan[600],
                            fontFamily: 'LexendDeca',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Switch(
                          inactiveTrackColor: Colors.grey[600],
                          value: hasConferenceSupport,
                          onChanged: (value) {
                            setState(() {
                              hasConferenceSupport = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      width: double.maxFinite,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue[600]),
                          ),
                          child: Text(
                            'Add Class',
                            style: commontextstylewhite,
                          ),
                          onPressed: isDataStorageInProgress
                              ? null
                              : () async {
                                  setState(() {
                                    isErrorTime = false;
                                    isDataStorageInProgress = true;
                                    currentFullClass = standard + division;
                                  });

                                  textFocusNodeTitle.unfocus();
                                  textFocusNodeDescription.unfocus();
                                  textFocusNodeLocation.unfocus();
                                  textFocusNodeAttendee.unfocus();

                                  if (selectedDate != null && selectedStartTime != null && selectedEndTime != null && currentTitle != null) {
                                    int startTimeInEpoch = DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedStartTime.hour,
                                      selectedStartTime.minute,
                                    ).millisecondsSinceEpoch;

                                    int endTimeInEpoch = DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedEndTime.hour,
                                      selectedEndTime.minute,
                                    ).millisecondsSinceEpoch;

                                    print('DIFFERENCE: ${endTimeInEpoch - startTimeInEpoch}');

                                    print('Start Time: ${DateTime.fromMillisecondsSinceEpoch(startTimeInEpoch)}');
                                    print('End Time: ${DateTime.fromMillisecondsSinceEpoch(endTimeInEpoch)}');

                                    if (endTimeInEpoch - startTimeInEpoch > 0) {
                                      if (_validateTitle(currentTitle) == null) {
                                        await calendarClient
                                            .insert(
                                          title: currentTitle,
                                          description: currentDescription ?? '',
                                          location: currentLocation,
                                          attendeeEmailList: attendeeEmails,
                                          shouldNotifyAttendees: shouldNofityAttendees,
                                          hasConferenceSupport: hasConferenceSupport,
                                          startTime: DateTime.fromMillisecondsSinceEpoch(startTimeInEpoch),
                                          endTime: DateTime.fromMillisecondsSinceEpoch(endTimeInEpoch),
                                          schoolUid: schoolUidFromDatabase,
                                          fullClassName: standard + division,
                                          standard: standard,
                                        )
                                            .then((eventData) async {
                                          String eventId = eventData['id'];
                                          String eventLink = eventData['link'];

                                          List<String> emails = [];

                                          for (int i = 0; i < attendeeEmails.length; i++) emails.add(attendeeEmails[i].email);

                                          EventInfo eventInfo = EventInfo(
                                            id: eventId,
                                            name: currentTitle,
                                            description: currentDescription ?? '',
                                            location: currentLocation,
                                            link: eventLink,
                                            attendeeEmails: emails,
                                            shouldNotifyAttendees: shouldNofityAttendees,
                                            hasConfereningSupport: hasConferenceSupport,
                                            startTimeInEpoch: startTimeInEpoch,
                                            endTimeInEpoch: endTimeInEpoch,
                                            schoolUid: schoolUidFromDatabase,
                                            standard: standard,
                                            fullClassName: standard + division,
                                          );

                                          await storage
                                              .storeEventData(eventInfo, schoolUidFromDatabase, currentFullClass)
                                              .whenComplete(() => Navigator.of(context).pop())
                                              .catchError(
                                                (e) => print(e),
                                              );
                                        }).catchError(
                                          (e) => print(e),
                                        );

                                        setState(() {
                                          isDataStorageInProgress = false;
                                        });
                                      } else {
                                        setState(() {
                                          isEditingTitle = true;
                                          isEditingLink = true;
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        isErrorTime = true;
                                        errorString = 'Invalid time! Please use a proper start and end time';
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      isEditingDate = true;
                                      isEditingStartTime = true;
                                      isEditingEndTime = true;
                                      isEditingBatch = true;
                                      isEditingTitle = true;
                                      isEditingLink = true;
                                    });
                                  }
                                  setState(() {
                                    isDataStorageInProgress = false;
                                  });
                                }),
                    )
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
