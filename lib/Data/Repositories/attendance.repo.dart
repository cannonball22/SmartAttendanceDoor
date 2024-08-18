import 'package:smart_attendance_door/Data/Model/Attendance/attendance.model.dart';

import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';

class AttendanceRepo extends FirestoreRepo<Attendance> {
  AttendanceRepo()
      : super(
          'Attendance',
        );

  @override
  Attendance? toModel(Map<String, dynamic>? item) =>
      Attendance.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(Attendance? item) => item?.toMap() ?? {};
}
