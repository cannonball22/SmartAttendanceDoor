//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_attendance_door/features/class%20management/presentation/pages/class_management.screen.dart';
import 'package:smart_attendance_door/features/reports/presentation/pages/reports.screen.dart';
import 'package:smart_attendance_door/features/student%20management/presentation/pages/student_management.screen.dart';

import '../../../../notifier.dart';
import '../../../profile/presentation/profile.screen.dart';
import '../../../students overview/presentation/pages/students_attendance.screen.dart';
import '../widgets/quick_action_container.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class HomeScreen extends ConsumerStatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers

  //t2 --Controllers
  //
  //t2 --State
  //t2 --State
  //
  //t2 --Constants

  //t2 --Constants
  //!SECTION

  //SECTION - Stateless functions
  //!SECTION
  //SECTION - Action Callbacks
  //!SECTION
  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    //double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    final userValue = ref.watch(userProvider);
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Scaffold(
        appBar: null,
        body: userValue.when(
          data: (appUser) => SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hello, ${appUser.name}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const ProfileScreen(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFFF1EAFE),
                            radius: 18,
                            backgroundImage: (appUser.imageUrl != null &&
                                    appUser.imageUrl!.isNotEmpty)
                                ? NetworkImage(appUser.imageUrl!)
                                : null,
                            child: (appUser.imageUrl == null ||
                                    appUser.imageUrl!.isEmpty)
                                ? Icon(
                                    Icons.person_outlined,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 18,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Quick actions',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      QuickActionContainer(
                        title: "Students\nManagement",
                        icon: FontAwesomeIcons.graduationCap,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const StudentManagementScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      QuickActionContainer(
                        title: "Classes\nManagement",
                        icon: Icons.group,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const ClassManagementScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      QuickActionContainer(
                        title: "Students\nAttendance",
                        icon: Icons.check_circle_outline,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const StudentsAttendanceScreen(),
                              ));
                        },
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      QuickActionContainer(
                        title: "Reports\n",
                        icon: Icons.stacked_bar_chart,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const ReportsScreen(),
                              ));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
        ));
    //!SECTION
  }
}
