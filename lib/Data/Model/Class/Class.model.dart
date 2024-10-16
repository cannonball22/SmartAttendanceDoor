import 'dart:convert';

import '../Shared/day_of_the_week.enum.dart';
import '../Shared/school_class.enum.dart';
import '../Shared/subject.enum.dart';

class Class {
  String id;
  String name;
  String teacherId;
  SchoolClass schoolClass;
  Subject subject;
  List<String> studentIds;
  DateTime startSemesterDate;
  DateTime endSemesterDate;
  DayOfTheWeek weeklySubjectDate;
  String weeklySubjectTime;

  Class({
    required this.id,
    required this.name,
    required this.schoolClass,
    required this.subject,
    required this.studentIds,
    required this.teacherId,
    required this.startSemesterDate,
    required this.endSemesterDate,
    required this.weeklySubjectDate,
    required this.weeklySubjectTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      "teacherId": teacherId,
      "schoolClass": schoolClass.index,
      "subject": subject.index,
      "studentIds": studentIds,
      'startSemesterDate': startSemesterDate.toIso8601String(),
      'endSemesterDate': endSemesterDate.toIso8601String(),
      'weeklySubjectDay': weeklySubjectDate.index,
      'weeklySubjectTime': weeklySubjectTime,
    };
  }

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
      id: map['id'] as String,
      name: map['name'] as String,
      teacherId: map['teacherId'] as String,
      schoolClass: SchoolClass.values[map["schoolClass"]],
      subject: Subject.values[map["subject"]],
      studentIds: map['studentIds'] != null
          ? List<String>.from(map['studentIds'] as List<dynamic>)
          : [],
      startSemesterDate: DateTime.parse(map['startSemesterDate']),
      endSemesterDate: DateTime.parse(map['endSemesterDate']),
      weeklySubjectDate: DayOfTheWeek.values[map["weeklySubjectDay"]],
      weeklySubjectTime: map['weeklySubjectTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Class.fromJson(String source) =>
      Class.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Class other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
