//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_attendance_door/Data/Repositories/user.repo.dart';
import 'package:smart_attendance_door/core/Services/Auth/AuthService.dart';
import 'package:smart_attendance_door/features/class%20management/presentation/pages/class_management.screen.dart';
import 'package:smart_attendance_door/features/reports/presentation/pages/reports.screen.dart';
import 'package:smart_attendance_door/features/student%20management/presentation/pages/student_management.screen.dart';

import '../../../profile/presentation/profile.screen.dart';
import '../../../students overview/presentation/pages/student_overview.screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class HomeScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  void initState() {
    super.initState();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --Controllers & Listeners
    //t2 --Controllers & Listeners
    //
    //t2 --State
    //t2 --State
    //
    //t2 --Late & Async Initializers
    //t2 --Late & Async Initializers
    //!SECTION
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --State
    //t2 --State
    //!SECTION
  }

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
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Scaffold(
      appBar: null,
      body: FutureBuilder(
        future: AppUserRepo().readSingle(AuthService().getCurrentUserId()),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.done &&
              userSnapshot.hasData) {
            return SafeArea(
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
                            'Hello, ${userSnapshot.data?.name}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      ProfileScreen(
                                    appUser: userSnapshot.data!,
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: const Color(0xFFF1EAFE),
                              radius: 18,
                              backgroundImage: (userSnapshot.data!.imageUrl !=
                                          null &&
                                      userSnapshot.data!.imageUrl!.isNotEmpty)
                                  ? NetworkImage(userSnapshot.data!.imageUrl!)
                                  : null,
                              child: (userSnapshot.data!.imageUrl == null ||
                                      userSnapshot.data!.imageUrl!.isEmpty)
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
                    // out of scope
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'Today’s Classes',
                    //       style: Theme.of(context).textTheme.titleSmall,
                    //     ),
                    //     TertiaryButton(title: "View all", onPressed: () {})
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.all(16),
                    //   decoration: ShapeDecoration(
                    //     shape: RoundedRectangleBorder(
                    //       side: const BorderSide(),
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         "Arabic 4th B",
                    //         style: Theme.of(context).textTheme.bodyMedium,
                    //       ),
                    //       Text(
                    //         "07:00 AM - 09:00 AM",
                    //         style: Theme.of(context).textTheme.bodyMedium,
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 32,
                    // ),
                    Text(
                      'Quick actions',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(
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
                          title: "Students\nOverview",
                          icon: Icons.check_circle_outline,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const StudentOverviewScreen(),
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
                    // out of scope
                    // const SizedBox(
                    //   height: 32,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'Today’s Activities',
                    //       style: Theme.of(context).textTheme.titleSmall,
                    //     ),
                    //     TertiaryButton(title: "View all", onPressed: () {})
                    //   ],
                    // ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION

    super.dispose();
  }
}

class QuickActionContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;

  const QuickActionContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color(0xffFBB04B),
                size: 24,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
