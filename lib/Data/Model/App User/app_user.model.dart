import 'dart:convert';

import 'package:smart_attendance_door/Data/Model/Shared/user_role.enum.dart';

import '../Shared/gender.enum.dart';

class AppUser {
  String id;
  String email;
  String name;
  String? imageUrl;
  Gender gender;
  String dateOfBirth;
  String phoneNumber;
  UserRole userRole;

  //
  String? parentPhoneNumber;
  List<String>? classesIds;

  AppUser({
    required this.id,
    required this.email,
    this.imageUrl,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.phoneNumber,
    this.parentPhoneNumber,
    required this.userRole,
    this.classesIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      "imageUrl": imageUrl,
      'fullName': name,
      "gender": gender.index,
      "userRole": userRole.index,
      "classesIds": classesIds,
      "dateOfBirth": dateOfBirth,
      "phoneNumber": phoneNumber,
      "parentPhoneNumber": parentPhoneNumber,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      email: map['email'],
      imageUrl: map['imageUrl'],
      name: map['fullName'],
      gender: Gender.values[map["gender"]],
      userRole: UserRole.values[map["userRole"]],
      dateOfBirth: map["dateOfBirth"],
      phoneNumber: map["phoneNumber"],
      parentPhoneNumber: map["parentPhoneNumber"],
      classesIds: map['classesIds'] != null
          ? List<String>.from(map['classesIds'] as List<dynamic>)
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
