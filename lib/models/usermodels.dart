import 'package:cloud_firestore/cloud_firestore.dart';

class StepUser {
  final String uid;

  StepUser({this.uid});
}

class UserFromFirebase {
  String uid;
  String name;
  String role;
  String subject;
  String email;
  String standard;
  String division;
  String school;
  String city;
  String state;
  String country;
  Timestamp lastlogin;
  Timestamp createdat;

  UserFromFirebase(
      {this.uid,
      this.name,
      this.role,
      this.subject,
      this.email,
      this.standard,
      this.division,
      this.lastlogin,
      this.createdat,
      this.school,
      this.state,
      this.city,
      this.country});

  // UserFromFirebase.fromMap(Map<String, dynamic> data) {
  //   uid = data['uid'] ?? '';
  //   name = data['name'] ?? '';
  //   role = data['role'] ?? '';
  //   subject = data['subject'] ?? '';
  //   email = data['email'] ?? '';
  //   standard = data['standard'] ?? '';
  //   school = data['school'] ?? '';
  //   division = data['division'] ?? '';
  //   lastlogin = data['last_login'] ?? '';
  //   createdat = data['created_at'] ?? '';
  // }
}
