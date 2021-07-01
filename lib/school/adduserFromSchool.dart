import 'package:flutter/material.dart';
import 'package:step/services/auth.dart';
import 'package:step/services/database.dart';
import 'package:step/shared/errorscreens.dart';
import 'package:step/shared/loading.dart';
import 'package:step/shared/textstyle.dart';

class AddUserFromSchool extends StatefulWidget {
  @override
  _AddUserFromSchoolState createState() => _AddUserFromSchoolState();
}

class _AddUserFromSchoolState extends State<AddUserFromSchool> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
//drop down
  String dropDownUserType;
  String dropDownSubjects;
  String dropDownClass;
  String dropDownDivision;
  List userDropdownList = ["teacher", "student"];
  List dropdownSubject = [
    "Science",
    "Physics",
    "Chemistry",
    "Biology",
    "Maths",
    "Social Science",
    "History",
    "Political Science",
    "Geography",
    "Economics",
    "English",
    "Malayalam",
    "Hindi",
  ];
  List dropdownClass = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];
  List dropdownDivision = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"];

//drop down swithcer
  bool dropDownSwitcherTeacher = false;
  bool dropDownSwitcherStudent = false;

//Boolandstrings
  String error = '';
  String registeredwelcome;
  String name;
  String email;
  String password;
  String role;
  String state;
  String city;
  String country;
  String collectionWhereUserShouldBe = "users1";
  String collectionWhereRoleShouldBe = "roles";
  String standard;
  String division;
  String subject;
  bool hiddenPassword = true;
  bool loading = false;
  bool checkpassword = false;

  //get school name from datbase
  String schoolNameFromDatabse;
  Future<void> getSchool() async {
    String schoolNameFromFirestore = await UserHelper.getSchoolName();
    setState(() {
      schoolNameFromDatabse = schoolNameFromFirestore;
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

  //hidden passwod
  void _togglePasswordView() {
    setState(() {
      hiddenPassword = !hiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xff040812),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 123.0,
                  ),
                  Center(
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Image.asset('assets/icon/icon.png'),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Center(
                    child: Container(
                      width: 376.0,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Name of user
                            Container(
                              // height: 56.9,
                              child: TextFormField(
                                style: commontextstyle,
                                validator: (val) => val.isEmpty ? 'Name' : null,
                                onChanged: (val) {
                                  setState(() => name = val);
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.school_rounded),
                                  hintText: 'Name',
                                  hintStyle: commontextstyle,
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            //mail of school
                            Container(
                              // height: 56.9,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: commontextstyle,
                                validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintText: 'Email',
                                  hintStyle: commontextstyle,
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            //password of school
                            Container(
                              // height: 56.9,
                              child: TextFormField(
                                style: commontextstyle,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'Password',
                                    hintStyle: commontextstyle,
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon:
                                        InkWell(onTap: _togglePasswordView, child: Icon(hiddenPassword ? Icons.visibility : Icons.visibility_off))),
                                obscureText: hiddenPassword,
                                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                                onChanged: (val) {
                                  setState(() => password = val);
                                  setState(() {
                                    checkpassword = true;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            // ------------------------------------------
                            // --------- First Drop Down-----------------
                            // ------------------------------------------
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white60, width: 5.0), borderRadius: BorderRadius.circular(8), color: Colors.white),
                              child: DropdownButton(
                                hint: Text(
                                  'Select user type',
                                  style: TextStyle(fontFamily: 'LexendDeca', fontSize: 17),
                                ),
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.arrow_drop_down_rounded),
                                iconSize: 40.0,
                                isExpanded: true,
                                underline: SizedBox(),
                                style: TextStyle(fontSize: 17.0, color: Colors.grey[850], fontFamily: 'LexendDeca'),
                                value: dropDownUserType,
                                onChanged: (changedValue) {
                                  setState(() {
                                    dropDownUserType = changedValue;
                                    if (dropDownUserType == 'teacher') {
                                      dropDownSwitcherTeacher = true;
                                      dropDownSwitcherStudent = false;
                                      dropDownClass = null;
                                      dropDownDivision = null;
                                    } else {
                                      dropDownSwitcherTeacher = false;
                                      dropDownSwitcherStudent = true;
                                      dropDownSubjects = null;
                                    }
                                  });
                                },
                                items: userDropdownList.map((changedItem) {
                                  return DropdownMenuItem(
                                    value: changedItem,
                                    child: Text(
                                      changedItem,
                                      style: commontextstyle,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            // ----------------------------------
                            // second drop down--------------
                            // -----------------------
                            Visibility(
                              visible: dropDownSwitcherStudent,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white60, width: 5.0),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: DropdownButton(
                                  hint: Text(
                                    'Select class ',
                                    style: TextStyle(fontFamily: 'LexendDeca', fontSize: 17),
                                  ),
                                  dropdownColor: Colors.white,
                                  icon: Icon(Icons.arrow_drop_down_rounded),
                                  iconSize: 40.0,
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  style: TextStyle(fontSize: 17.0, color: Colors.grey[850], fontFamily: 'LexendDeca'),
                                  value: dropDownClass,
                                  onChanged: (changedValue) {
                                    setState(() {
                                      dropDownClass = changedValue;
                                    });
                                  },
                                  items: dropdownClass.map((changedItem) {
                                    return DropdownMenuItem(
                                      value: changedItem,
                                      child: Text(
                                        changedItem,
                                        style: commontextstyle,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: dropDownSwitcherStudent,
                              child: SizedBox(
                                height: 10.0,
                              ),
                            ),
                            // ----------------------
                            // ------third dropdown-
                            // ---------------------
                            Visibility(
                              visible: dropDownSwitcherStudent,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white60, width: 5.0),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: DropdownButton(
                                  hint: Text(
                                    'Select division',
                                    style: TextStyle(fontFamily: 'LexendDeca', fontSize: 17),
                                  ),
                                  dropdownColor: Colors.white,
                                  icon: Icon(Icons.arrow_drop_down_rounded),
                                  iconSize: 40.0,
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  style: TextStyle(fontSize: 17.0, color: Colors.grey[850], fontFamily: 'LexendDeca'),
                                  value: dropDownDivision,
                                  onChanged: (changedValue) {
                                    setState(() {
                                      dropDownDivision = changedValue;
                                    });
                                  },
                                  items: dropdownDivision.map((changedItem) {
                                    return DropdownMenuItem(
                                      value: changedItem,
                                      child: Text(
                                        changedItem,
                                        style: commontextstyle,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: dropDownSwitcherStudent,
                              child: SizedBox(
                                height: 10.0,
                              ),
                            ),
                            // ----------------------
                            // ------fourth dropdown-
                            // ---------------------
                            Visibility(
                              visible: dropDownSwitcherTeacher,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white60, width: 5.0),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: DropdownButton(
                                  hint: Text(
                                    'Select Subject',
                                    style: TextStyle(fontFamily: 'LexendDeca', fontSize: 17),
                                  ),
                                  dropdownColor: Colors.white,
                                  icon: Icon(Icons.arrow_drop_down_rounded),
                                  iconSize: 40.0,
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  style: TextStyle(fontSize: 17.0, color: Colors.grey[850], fontFamily: 'LexendDeca'),
                                  value: dropDownSubjects,
                                  onChanged: (changedValue) {
                                    setState(() {
                                      dropDownSubjects = changedValue;
                                    });
                                  },
                                  items: dropdownSubject.map((changedItem) {
                                    return DropdownMenuItem(
                                      value: changedItem,
                                      child: Text(
                                        changedItem,
                                        style: commontextstyle,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                                height: 56.9,
                                width: 376.0,
                                child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xffEC5F5F)),
                                      foregroundColor: MaterialStateProperty.all<Color>(Color(0xffffffff)),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() => loading = true);
                                        dynamic result = await _auth.registerWithEmailPasswordUser(
                                          collectionWhereUserShouldBe: collectionWhereUserShouldBe,
                                          collectionWhereRoleShouldBe: collectionWhereRoleShouldBe,
                                          email: email,
                                          password: password,
                                          name: name,
                                          role: dropDownUserType,
                                          subject: dropDownSubjects,
                                          division: dropDownDivision,
                                          standard: dropDownClass,
                                          //get the school name form the firebase from below code
                                          school: schoolNameFromDatabse,
                                        );
                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                            error = 'Could not register with those credentials';
                                            // return the error screen
                                            Future.delayed(const Duration(milliseconds: 1), () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return ErrorScreen(
                                                      svgAsset: 'assets/shared/cancelscreen/redcancel.svg',
                                                      underText: "Error",
                                                      mainText: error,
                                                      buttonText: "Try Again",
                                                      textcolor: Colors.red[400],
                                                      buttonColor: Colors.red[400],
                                                      onpressedFunc: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  });
                                            });
                                          });
                                        } else if (result == 'okey') {
                                          setState(() {
                                            loading = false;
                                            Navigator.pop(context);
                                            registeredwelcome = '$dropDownUserType Registered Successfully';
                                            print(registeredwelcome);
                                            // school registeration completion message
                                            Future.delayed(const Duration(milliseconds: 1), () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return ErrorScreen(
                                                      svgAsset: 'assets/shared/checkedscreen/checkmark1.svg',
                                                      underText: "Successful",
                                                      mainText: registeredwelcome,
                                                      buttonText: "Continue",
                                                      onpressedFunc: () {
                                                        Navigator.pop(context);
                                                      },
                                                      buttonColor: Colors.green[700],
                                                      textcolor: Colors.green[700],
                                                    );
                                                  });
                                            });
                                          });
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Add $dropDownUserType',
                                      style: commontextstyle,
                                    ))),
                            SizedBox(
                              height: 25.0,
                            ),
                            // Center(
                            //     child: Text(
                            //   error,
                            //   style: bigtextstyle,
                            //   textAlign: TextAlign.center,
                            // )),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
