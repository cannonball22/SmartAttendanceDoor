import 'package:flutter/material.dart';
import 'package:smart_attendance_door/Data/Model/Attendance/attendance.model.dart';
import 'package:smart_attendance_door/Data/Repositories/student.repo.dart';

class StudentsAttendanceCard extends StatelessWidget {
  final Attendance attendance;

  const StudentsAttendanceCard({
    super.key,
    required this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: const Color(0xFFE7E7E7),
          ),
        ),
        child: FutureBuilder(
          future: StudentRepo().readSingle(attendance.studentId),
          builder: (context, studentSnapshot) {
            if (studentSnapshot.connectionState == ConnectionState.done) {
              if (studentSnapshot.hasError) {
                return const Text("Error fetching attendance");
              }
              if (studentSnapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(studentSnapshot.data!.imageUrl),
                          radius: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              studentSnapshot.data!.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            // Text(
                            //   "ID: ${students[index].id}",
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .bodySmall,
                            // ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      decoration: ShapeDecoration(
                        color: (attendance.attendance == false)
                            ? const Color(0xFFDC2B2B)
                            : const Color(0xFF1B8E55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Text(
                        (attendance.attendance == false) ? 'Absent' : "Present",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.10,
                        ),
                      ),
                    )
                  ],
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
