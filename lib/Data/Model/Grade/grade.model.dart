import 'dart:convert';

import '../Shared/school_class.enum.dart';
import '../Shared/subject.enum.dart';

class Grade {
  String id;
  String studentId;
  String classId;
  String? midtermExamDate; // Midterm exam date
  String? finalExamDate; // Final exam date
  SchoolClass schoolClass;
  Subject subject;
  int? midtermGrade; // Midterm exam grade
  int? finalGrade; // Final exam grade
  String teacherName;

  Grade({
    required this.id,
    required this.studentId,
    required this.classId,
    required this.midtermExamDate,
    required this.finalExamDate,
    required this.schoolClass,
    required this.subject,
    this.midtermGrade = 0,
    this.finalGrade = 0,
    required this.teacherName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'studentId': studentId,
      'classId': classId,
      'midtermExamDate': midtermExamDate,
      'finalExamDate': finalExamDate,
      'schoolClass': schoolClass.index,
      'subject': subject.index,
      'midtermGrade': midtermGrade,
      'finalGrade': finalGrade,
      "teacherName": teacherName,
    };
  }

  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      id: map['id'] as String,
      studentId: map['studentId'] as String,
      classId: map['classId'] as String,
      midtermExamDate: map['midtermExamDate'] as String,
      finalExamDate: map['finalExamDate'] as String,
      schoolClass: SchoolClass.values[map['schoolClass']],
      subject: Subject.values[map['subject']],
      midtermGrade: map['midtermGrade'] as int,
      finalGrade: map['finalGrade'] as int,
      teacherName: map["teacherName"] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Grade.fromJson(String source) =>
      Grade.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Grade other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.studentId == studentId &&
        other.classId == classId &&
        other.midtermExamDate == midtermExamDate &&
        other.finalExamDate == finalExamDate &&
        other.schoolClass == schoolClass &&
        other.subject == subject &&
        other.midtermGrade == midtermGrade &&
        other.finalGrade == finalGrade;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      studentId.hashCode ^
      classId.hashCode ^
      midtermExamDate.hashCode ^
      finalExamDate.hashCode ^
      schoolClass.hashCode ^
      subject.hashCode ^
      midtermGrade.hashCode ^
      finalGrade.hashCode;
}
