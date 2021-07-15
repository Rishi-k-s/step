import 'package:flutter/material.dart';

class ActivitiesInfo {
  final String chapterName;
  var chapterUid;
  final String fullClassName;
  final String currentClassOnly;
  final String schoolUid;

  ActivitiesInfo({
    @required this.chapterName,
    @required this.chapterUid,
    @required this.fullClassName,
    @required this.currentClassOnly,
    @required this.schoolUid,
  });

  ActivitiesInfo.fromMap(Map snapshot)
      : chapterName = snapshot['chapterName'] ?? '',
        chapterUid = snapshot['chapterUid'] ?? '',
        schoolUid = snapshot['schoolUid'] ?? '',
        fullClassName = snapshot['fullClassName'],
        currentClassOnly = snapshot['currentClassOnly'];

  toJson() {
    return {
      'chapterName': chapterName,
      'chapterUid': chapterUid,
      'fullClassName': fullClassName,
      'schoolUid': schoolUid,
      'currentClassOnly': currentClassOnly,
    };
  }
}
