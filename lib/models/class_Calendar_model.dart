import 'package:flutter/material.dart';

class EventInfo {
  final String id;
  final String name;
  final String description;
  final String location;
  final String link;
  final String schoolUid;
  final String standard;
  final String fullClassName;
  final List<dynamic> attendeeEmails;
  final bool shouldNotifyAttendees;
  final bool hasConfereningSupport;
  final int startTimeInEpoch;
  final int endTimeInEpoch;

  EventInfo({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.location,
    @required this.link,
    @required this.attendeeEmails,
    @required this.shouldNotifyAttendees,
    @required this.hasConfereningSupport,
    @required this.startTimeInEpoch,
    @required this.endTimeInEpoch,
    @required this.schoolUid,
    @required this.fullClassName,
    @required this.standard,
  });

  EventInfo.fromMap(Map snapshot)
      : id = snapshot['id'] ?? '',
        name = snapshot['name'] ?? '',
        description = snapshot['desc'],
        location = snapshot['loc'],
        link = snapshot['link'],
        attendeeEmails = snapshot['emails'] ?? '',
        shouldNotifyAttendees = snapshot['should_notify'],
        hasConfereningSupport = snapshot['has_conferencing'],
        startTimeInEpoch = snapshot['start'],
        endTimeInEpoch = snapshot['end'],
        schoolUid = snapshot['schoolUid'],
        fullClassName = snapshot['FullClassName'],
        standard = snapshot['standard'];

  toJson() {
    return {
      'id': id,
      'name': name,
      'desc': description,
      'loc': location,
      'link': link,
      'emails': attendeeEmails,
      'should_notify': shouldNotifyAttendees,
      'has_conferencing': hasConfereningSupport,
      'start': startTimeInEpoch,
      'end': endTimeInEpoch,
      'schoolUid': schoolUid,
      'FullClassName': fullClassName,
      'standard': standard,
    };
  }
}
