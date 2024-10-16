//t2 Core Packages Imports
import 'package:flutter/material.dart';

import '../../../class management/presentation/pages/teacher_class_management_screen.dart';
import '../../../students overview/presentation/pages/students_attendance.screen.dart';
import '../widgets/quick_action_container.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class TeacherHomeScreen extends StatelessWidget {
  // SECTION - Widget Arguments
  //!SECTION
  //
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SECTION - Build Setup
    // Values
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    // Widgets
    //
    // Widgets
    //!SECTION

    // SECTION - Build Return
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick actions',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 16,
          ),
          QuickActionContainer(
            title: "My Classes",
            icon: Icons.group,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const TeacherClassManagementScreen(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          QuickActionContainer(
            title: "Students Attendance",
            icon: Icons.check_circle_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const StudentsAttendanceScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );

    //!SECTION
  }
}
