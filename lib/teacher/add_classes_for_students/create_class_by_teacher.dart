import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:step/shared/textstyle.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:intl/intl.dart';

class CreateClassPage extends StatefulWidget {
  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  TextEditingController textControllerDate;
  TextEditingController textControllerStartTime;
  TextEditingController textControllerEndTime;
  TextEditingController textControllerTitle;
  TextEditingController textControllerDescription;
  TextEditingController textControllerLocation;
  TextEditingController textControllerAttendee;

  FocusNode textFocusNodeTitle;
  FocusNode textFocusNodeDescription;
  FocusNode textFocusNodeLocation;
  FocusNode textFocusNodeAttendee;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  String currentTitle;
  String currentDesc;
  String currentLocation;
  String currentEmail;
  String errorString = '';

  // List<String> attendeeEmails = [];
  List<calendar.EventAttendee> attendeeEmails = [];

  bool isEditingDate = false;
  bool isEditingStartTime = false;
  bool isEditingEndTime = false;
  bool isEditingBatch = false;
  bool isEditingTitle = false;
  bool isEditingEmail = false;
  bool isEditingLink = false;
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
    textFocusNodeTitle = FocusNode();
    textFocusNodeDescription = FocusNode();
    textFocusNodeLocation = FocusNode();
    textFocusNodeAttendee = FocusNode();

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
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      FormBuilderTextField(
                        name: 'title',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.title_rounded,
                            color: Colors.white70,
                            size: 30.0,
                          ),
                          hintText: "Add Title",
                          hintStyle: TextStyle(color: Colors.white70, fontSize: 15.0),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 48.0),
                        ),
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.white,
                        indent: 25.0,
                        endIndent: 25.0,
                      ),
                      FormBuilderTextField(
                        name: 'description',
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
                        ),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(
                indent: 15.0,
                endIndent: 15.0,
                color: Colors.white,
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      decoration: new InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue[800], width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue[800], width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue[900], width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.redAccent, width: 2),
                        ),
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
                    FormBuilderSwitch(
                      decoration: InputDecoration(border: InputBorder.none),
                      name: 'addvidconf',
                      title: Text(
                        'Add Virtual Class',
                        style: commontextstylewhite,
                      ),
                      initialValue: true,
                    ),
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
