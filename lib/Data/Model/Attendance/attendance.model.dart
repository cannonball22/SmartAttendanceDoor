import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  String id;
  bool attendance;
  String studentId;
  String classId;
  DateTime date;

  Attendance({
    required this.id,
    required this.attendance,
    required this.studentId,
    required this.classId,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'attendance': attendance,
      'studentId': studentId,
      'classId': classId,
      'date': date.toIso8601String(),
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    // Check if the date is a Timestamp or a string
    var dateField = map['date'];
    DateTime date;
    if (dateField is Timestamp) {
      date = dateField.toDate();
    } else {
      date = DateTime.parse(dateField as String);
    }

    return Attendance(
      id: map['id'] as String,
      attendance: map['attendance'] as bool,
      studentId: map['studentId'] as String,
      classId: map['classId'] as String,
      date: date,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Attendance other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.attendance == attendance &&
        other.studentId == studentId &&
        other.classId == classId &&
        other.date == date;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      attendance.hashCode ^
      studentId.hashCode ^
      classId.hashCode ^
      date.hashCode;
}
