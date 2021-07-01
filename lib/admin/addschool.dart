import 'package:flutter/material.dart';
import 'package:step/services/auth.dart';
import 'package:step/services/database.dart';
import 'package:step/shared/errorscreens.dart';
import 'package:step/shared/loading.dart';
import 'package:step/shared/textstyle.dart';

class AddSchools extends StatefulWidget {
  @override
  _AddSchoolsState createState() => _AddSchoolsState();
}

class _AddSchoolsState extends State<AddSchools> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String registeredwelcome;
  String schoolname;
  String email;
  String password;
  String role = "school";
  String state;
  String city;
  String country;
  String collectionWhereUserShouldBe = "users1";
  String collectionWhereRoleShouldBe = "roles";
  bool hiddenPassword = true;
  // bool checkpasswordhidden = true;
  bool loading = false;
  bool checkpassword = false;

  void _togglePasswordView() {
    // if (hiddenPassword = !hiddenPassword) {
    //   hiddenPassword = false;
    // } else {
    //   hiddenPassword = true;
    // }
    setState(() {
      hiddenPassword = !hiddenPassword;
    });
  }

  // void _togglehiddenPasswordView() {
  //   // if (hiddenPassword = !hiddenPassword) {
  //   //   hiddenPassword = false;
  //   // } else {
  //   //   hiddenPassword = true;
  //   // }
  //   setState(() {
  //     checkpasswordhidden = !checkpasswordhidden;
  //   });
  // }

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
                                // height: 56.9,
                                // child: TextFormField(
                                //   style: commontextstyle,
                                //   keyboardType: TextInputType.visiblePassword,
                                //   decoration: InputDecoration(
                                //       fillColor: Colors.white,
                                //       filled: true,
                                //       hintText: 'Retype Password',
                                //       hintStyle: commontextstyle,
                                //       prefixIcon: Icon(Icons.lock),
                                //       suffixIcon: InkWell(
                                //           onTap: _togglehiddenPasswordView,
                                //           child: Icon(checkpasswordhidden ? Icons.visibility : Icons.visibility_off))),
                                //   obscureText: checkpasswordhidden,
                                //   validator: (val) => checkpassword ? 'Passwords do not match' : null,
                                //   onChanged: (val) {
                                //     setState(() => password = val);
                                //   },
                                // ),
                                ),
                            SizedBox(
                              height: 17.0,
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
                                        dynamic result = await _auth.registerSchoolWithEmailPassword(
                                          collectionWhereUserShouldBe: collectionWhereUserShouldBe,
                                          email: email,
                                          password: password,
                                          name: schoolname,
                                          role: role,
                                          city: city,
                                          state: state,
                                          country: country,
                                          collectionWhereRoleShouldBe: collectionWhereRoleShouldBe,
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
                                          setState(() {
                                            loading = false;
                                            Navigator.pop(context);
                                            registeredwelcome = 'School Successfully Registered';
                                            print(registeredwelcome);
                                            // school registeration completion message
                                            Future.delayed(const Duration(milliseconds: 1), () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return ErrorScreen(
                                                      svgAsset: 'assets/shared/checkedscreen/checkmark.png',
                                                      underText: "Successful",
                                                      mainText: registeredwelcome,
                                                      buttonText: "Continue",
                                                      onpressedFunc: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  });
                                            });
                                          });
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
