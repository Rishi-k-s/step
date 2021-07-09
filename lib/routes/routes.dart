import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:step/shared/loading.dart';
import 'package:step/teacher/add_classes_for_students/create_class_by_teacher.dart';

class AppRoutes {
  static const home = "/";
  static const splash = "splash";
  static const login = "login";
  static const signup = "signup";
  static const userInfo = "user_info";
  static const String profile = "profile";
  static const String editProfile = "edit_profile";
  static const String addEvent = "add_event";
  static const String editEvent = "edit_event";
  static const String viewEvent = "view_event";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          switch (settings.name) {
            case editEvent:
            // return AddEventPage(event: settings.arguments);
            case viewEvent:
            // return EventDetails(event: settings.arguments);
            case addEvent:
              return CreateClassPage();
            default:
              return Loading();
          }
        });
  }
}
