import 'dart:convert';

import '../Shared/school_class.enum.dart';
import '../Shared/subject.enum.dart';

class Class {
  String id;
  String name;
  SchoolClass schoolClass;
  Subject subject;
  int? numberOfStudents;
  List<String> studentIds;

  //
  //
  Class({
    required this.id,
    required this.name,
    required this.schoolClass,
    required this.subject,
    this.numberOfStudents = 0,
    required this.studentIds,
    // required this.subjectName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      "numberOfStudents": numberOfStudents,
      "schoolClass": schoolClass.index,
      "subject": subject.index,
      "studentIds": studentIds,
    };
  }

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
      id: map['id'] as String,
      name: map['name'] as String,
      schoolClass: SchoolClass.values[map["schoolClass"]],
      subject: Subject.values[map["subject"]],
      numberOfStudents: map['numberOfStudents'] as int? ?? 0,
      studentIds: map['studentIds'] != null
          ? List<String>.from(map['studentIds'] as List<dynamic>)
          : [],
      // subjectName: map["subjectName"],
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
