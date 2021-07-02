import 'package:flutter/material.dart';
import 'package:step/services/auth.dart';
import 'package:step/shared/errorscreens.dart';
import 'package:step/shared/loading.dart';
import 'package:step/shared/textstyle.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String error = '';
  String email = '';
  String password = '';
  bool hiddenPassword = true;
  bool loading = false;

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

  @override
  Widget build(BuildContext context) {
    // if (errorscreen == true) {
    //   return ErrorScreen(
    //     svgAsset: 'assets/shared/cancelscreen/redcancel.svg',
    //     underText: "Error",
    //     mainText: error,
    //     buttonText: "Try",
    //     onpressedFunc: () {},
    //   );
    // }
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
                      height: 90.0,
                      width: 90.0,
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
                                keyboardType: TextInputType.visiblePassword,
                                style: commontextstyle,
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
                                },
                              ),
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
                                        dynamic result = await _auth.signInWithEmailPassword(email: email, password: password);
                                        if (result == null) {
                                          setState(() {
                                            loading = false;
                                            error = 'Could not sign in with those credentials';
                                            // return the error screen
                                            Future.delayed(const Duration(seconds: 1), () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return ErrorScreen(
                                                      textcolor: Colors.red[600],
                                                      buttonColor: Colors.red[600],
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
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Log In',
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
