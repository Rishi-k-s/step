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
  List userDropdownList = ["teacher", "student"];

//Boolandstrings
  String error = '';
  String registeredwelcome;
  String schoolname;
  String email;
  String password;
  String role;
  String state;
  String city;
  String country;
  String collectionWhereUserShouldBe;
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
                            // Name of school
                            Container(
                              // height: 56.9,
                              child: TextFormField(
                                style: commontextstyle,
                                validator: (val) => val.isEmpty ? 'Name of the School' : null,
                                onChanged: (val) {
                                  setState(() => schoolname = val);
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.school_rounded),
                                  hintText: 'Name of school',
                                  hintStyle: commontextstyle,
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            //City of school
                            Container(
                              // height: 56.9,
                              child: TextFormField(
                                style: commontextstyle,
                                validator: (val) => val.isEmpty ? 'Required' : null,
                                onChanged: (val) {
                                  setState(() => city = val);
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.location_on),
                                  hintText: 'City',
                                  hintStyle: commontextstyle,
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            // state of school
                            Container(
                              // height: 56.9,
                              child: TextFormField(
                                autofillHints: [AutofillHints.location],
                                style: commontextstyle,
                                validator: (val) => val.isEmpty ? 'Required' : null,
                                onChanged: (val) {
                                  setState(() => state = val);
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.location_on),
                                  hintText: 'State',
                                  hintStyle: commontextstyle,
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            //country of school
                            Container(
                              // height: 56.9,
                              child: TextFormField(
                                autofillHints: [AutofillHints.countryName],
                                style: commontextstyle,
                                validator: (val) => val.isEmpty ? 'Required' : null,
                                onChanged: (val) {
                                  setState(() => country = val);
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.location_on),
                                  hintText: 'Country',
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
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white60, width: 4.0),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: DropdownButton(
                                hint: Text(
                                  'Select user type',
                                  style: commontextstyle,
                                ),
                                dropdownColor: Colors.white70,
                                icon: Icon(Icons.arrow_drop_down_rounded),
                                iconSize: 30.0,
                                isExpanded: true,
                                underline: SizedBox(),
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.blue.shade400,
                                ),
                                value: dropDownUserType,
                                onChanged: (changedValue) {
                                  setState(() {
                                    dropDownUserType = changedValue;
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
                                          email: email,
                                          password: password,
                                          name: schoolname,
                                          role: dropDownUserType,
                                          city: city,
                                          state: state,
                                          country: country,
                                          //get the school name form the firebase from below code
                                          school: schoolNameFromDatabse,
                                        );
                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                            error = 'Could not sign in with those credentials';
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
                                                      onpressedFunc: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  });
                                            });
                                          });
                                        } else if (result == 'okey') {
                                          loading = false;
                                          Navigator.pop(context);
                                          registeredwelcome = 'School Successfully Registered';
                                          print(registeredwelcome);
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Add this School',
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
