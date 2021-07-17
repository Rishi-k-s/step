import 'package:flutter/material.dart';

class ActivitiesInfo {
  final String chapterName;
  var chapterUid;
  final String fullClassName;
  final String currentClassOnly;
  final String schoolUid;
  final String teacherSubject;
  final String teacherUid;

  ActivitiesInfo({
    @required this.chapterName,
    @required this.chapterUid,
    @required this.fullClassName,
    @required this.currentClassOnly,
    @required this.schoolUid,
    @required this.teacherSubject,
    @required this.teacherUid,
  });

  ActivitiesInfo.fromMap(Map snapshot)
      : chapterName = snapshot['chapterName'] ?? '',
        chapterUid = snapshot['chapterUid'] ?? '',
        schoolUid = snapshot['schoolUid'] ?? '',
        fullClassName = snapshot['fullClassName'],
        currentClassOnly = snapshot['currentClassOnly'],
        teacherSubject = snapshot['teacherSubject'],
        teacherUid = snapshot['teacherUid'];

  toJson() {
    return {
      'chapterName': chapterName,
      'chapterUid': chapterUid,
      'fullClassName': fullClassName,
      'schoolUid': schoolUid,
      'currentClassOnly': currentClassOnly,
      'teacherSubject': teacherSubject,
      'teacherUid': teacherUid,
    };
  }
}
