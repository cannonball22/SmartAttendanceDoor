import 'dart:convert';

import '../Shared/gender.enum.dart';
import '../Shared/school_class.enum.dart';
import '../Shared/subject.enum.dart';

class AppUser {
  String id;
  String email;
  String name;
  String? imageUrl;
  Gender gender;
  Subject subject;
  List<SchoolClass> schoolClasses;
  String dateOfBirth;
  String phoneNumber;

  List<String>? classesIds;
  List<String>? subjectsIds;

  //
  //
  AppUser({
    required this.id,
    required this.email,
    this.imageUrl,
    required this.name,
    required this.gender,
    required this.schoolClasses,
    required this.subject,
    required this.dateOfBirth,
    required this.phoneNumber,
    this.classesIds,
    this.subjectsIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      "imageUrl": imageUrl,
      'fullName': name,
      "gender": gender.index,
      "subject": subject.index,
      "schoolClasses": schoolClasses.map((e) => e.index).toList(),
      "classesIds": classesIds,
      "dateOfBirth": dateOfBirth,
      "phoneNumber": phoneNumber,
      "subjectsIds": subjectsIds,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      email: map['email'],
      imageUrl: map['imageUrl'],
      name: map['fullName'],
      gender: Gender.values[map["gender"]],
      schoolClasses: List<SchoolClass>.from(
          (map["schoolClasses"] as List<dynamic>)
              .map((e) => SchoolClass.values[e])),
      subject: Subject.values[map["subject"]],
      dateOfBirth: map["dateOfBirth"],
      phoneNumber: map["phoneNumber"],
      classesIds: map['classesIds'] != null
          ? List<String>.from(map['classesIds'] as List<dynamic>)
          : [],
      subjectsIds: map['subjectsIds'] != null
          ? List<String>.from(map['subjectsIds'] as List<dynamic>)
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
