import 'package:flutter/material.dart';
import 'package:smart_attendance_door/Data/Model/Student/student.model.dart';

class StudentsCard extends StatelessWidget {
  final Student student;
  final Widget trailing;

  const StudentsCard({
    super.key,
    required this.student,
    required this.trailing,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(student.imageUrl),
                  radius: 24,
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
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
            trailing
          ],
        ),
      ),
    );
  }
}
