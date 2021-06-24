import 'package:cloud_firestore/cloud_firestore.dart';

class StepUser {
  final String uid;

  StepUser({this.uid});
}

class UserroleSelection {
  final String role;
  UserroleSelection({this.role});

  String get getRole => role;

  factory UserroleSelection.fromMap(Map data) {
    return UserroleSelection(role: data['role'] ?? '');
  }
}

class StepUserFromFirebase {
  String uid;
  String name;
  String role;
  String subject;
  String email;
  String standard;
  String division;
  Timestamp lastlogin;
  Timestamp createdat;

  StepUserFromFirebase.fromMap(Map<String, dynamic> data) {
    uid = data['uid'] ?? '';
    name = data['name'] ?? '';
    role = data['role'] ?? '';
    subject = data['subject'] ?? '';
    email = data['email'] ?? '';
    standard = data['standard'] ?? '';
    division = data['division'] ?? '';
    lastlogin = data['last_login'] ?? '';
    createdat = data['created_at'] ?? '';
  }

  StepUserFromFirebase({this.uid, this.name, this.role, this.subject, this.email, this.standard, this.division, this.lastlogin, this.createdat});
}
