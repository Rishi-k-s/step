//re direct from wrapper to choose roles

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step/student/studenthome.dart';
import 'package:step/teacher/teacherhome.dart';

class RoleSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either studenthome/teacherhome/teacheradminhome widgets.
    return StudentsHomeScreen();
  }
}

// class RoleSelector extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider(
//       create: create, initialData: initialData
//       )
//   }
// }
