//re direct from wrapper to choose roles

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step/admin/AdminHomeScreen.dart';
import 'package:step/school/schoolHomeScreen.dart';
import 'package:step/services/database.dart';
import 'package:step/shared/loading.dart';
import 'package:step/student/studenthome.dart';
import 'package:step/teacher/teacherhome.dart';

// class RoleSelector extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // return either studenthome/teacherhome/teacheradminhome widgets.
//     return StudentsHomeScreen();
//   }
// }

class RoleSelector extends StatefulWidget {
  @override
  _RoleSelectorState createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  String role = "";
  Future<void> setRole() async {
    String e = await UserHelper.getuserRole();
    setState(() {
      role = e;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setRole();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(role + " is role from firebase");
    switch (role) {
      case 'student':
        return StudentsHomeScreen();
        break;
      case 'admin':
        return AdminHomeScreen();
        break;
      case 'teacher':
        return TeachersHomeScreen();
        break;
      case 'school':
        return SchoolHomeScreen();
        break;
      default:
        return Loading();
    }
  }
}
