import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step/models/usermodels.dart';
import 'package:step/roleselector.dart';
import 'package:step/screens/authenticate.dart';
import 'package:step/services/database.dart';
// import 'package:step/student/studenthome.dart';

// class Wrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<StepUser>(context);

//     // return either role selector or authenticate widget
//     if (user == null) {
//       return Authenticate();
//     } else {
//       return RoleSelector();
//     }
//   }
// }

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            UserHelper.saveUser(snapshot.data);
            return RoleSelector();
          }
          return Authenticate();
        });
  }
}
