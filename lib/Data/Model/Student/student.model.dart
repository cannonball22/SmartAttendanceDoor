// import 'dart:convert';
//
// import '../Shared/gender.enum.dart';
//
// class Student {
//   String id;
//   String name;
//   String imageUrl;
//   String email;
//
// // final String gender;
//   String dateOfBirth;
//   String phoneNumber;
//   String parentPhoneNumber;
//   List<String?> classesIds;
//   Gender gender;
//
//   Student({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.email,
//     required this.dateOfBirth,
//     required this.phoneNumber,
//     required this.parentPhoneNumber,
//     required this.classesIds,
//     required this.gender,
//   });
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       "id": id,
//       "name": name,
//       "imageUrl": imageUrl,
//       "gender": gender.index,
//       //
//       "email": email,
//       "dateOfBirth": dateOfBirth,
//       "phoneNumber": phoneNumber,
//       //
//       "parentPhoneNumber": parentPhoneNumber,
//       "classesIds": classesIds,
//     };
//   }
//
//   factory Student.fromMap(Map<String, dynamic> map) {
//     return Student(
//       id: map["id"],
//       name: map["name"],
//       imageUrl: map["imageUrl"],
//       gender: Gender.values[map["gender"]],
//       //
//       email: map["email"],
//       dateOfBirth: map["dateOfBirth"],
//       phoneNumber: map["phoneNumber"],
//       //
//       parentPhoneNumber: map["parentPhoneNumber"],
//       classesIds: map['classesIds'] != null
//           ? List<String?>.from(map['classesIds'] as List<dynamic>)
//           : [],
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory Student.fromJson(String source) =>
//       Student.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   bool operator ==(covariant Student other) {
//     if (identical(this, other)) return true;
//
//     return other.id == id;
//   }
//
//   @override
//   int get hashCode => id.hashCode;
// }
