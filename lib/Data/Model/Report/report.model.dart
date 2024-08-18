import 'dart:convert';

class Report {
  String id;
  String name;

  // String subjectName;
  int? numberOfStudents;
  List<String>? studentIds;

  //
  //
  Report({
    required this.id,
    required this.name,
    this.numberOfStudents = 0,
    this.studentIds,
    // required this.subjectName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      "numberOfStudents": numberOfStudents,
      // "subjectName": subjectName,
      "studentIds": studentIds,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] as String,
      name: map['name'] as String,
      numberOfStudents: map['numberOfStudents'] as int? ?? 0,
      studentIds: map['studentIds'] != null
          ? List<String>.from(map['studentIds'] as List<dynamic>)
          : [],
      // subjectName: map["subjectName"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) =>
      Report.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Report other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
