//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../class management/presentation/pages/class_management.screen.dart';
import '../../../reports/presentation/pages/reports.screen.dart';
import '../../../students overview/presentation/pages/students_attendance.screen.dart';
import '../../../users management/presentation/pages/users_management_screen.dart';
import '../widgets/quick_action_container.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class AdminHomeScreen extends StatelessWidget {
  // SECTION - Widget Arguments
  //!SECTION
  //
  const AdminHomeScreen({super.key});

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Quick actions',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 16,
          ),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              QuickActionContainer(
                title: "Users\nManagement",
                icon: FontAwesomeIcons.graduationCap,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const UsersManagementScreen(),
                    ),
                  );
                },
              ),
              QuickActionContainer(
                title: "Classes\nManagement",
                icon: Icons.group,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const ClassManagementScreen(
                              title: "Class Management"),
                    ),
                  );
                },
              ),
              QuickActionContainer(
                title: "Students\nAttendance",
                icon: Icons.check_circle_outline,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const StudentsAttendanceScreen(
                        isAdmin: true,
                      ),
                    ),
                  );
                },
              ),
              QuickActionContainer(
                title: "Reports\n",
                icon: Icons.stacked_bar_chart,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ReportsScreen(),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );

    //!SECTION
  }
}
