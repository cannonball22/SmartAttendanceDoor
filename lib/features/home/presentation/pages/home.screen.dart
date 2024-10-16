//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_attendance_door/Data/Model/Shared/user_role.enum.dart';
import 'package:smart_attendance_door/features/home/presentation/pages/teacher_home_screen.dart';

import '../../../../notifier.dart';
import '../../../class management/presentation/pages/student_class_screen.dart';
import '../../../profile/presentation/profile.screen.dart';
import 'admin_home_screen.dart';

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
        appBar: userValue.when(
          data: (appUser) => AppBar(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
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
                              color: Theme.of(context).colorScheme.primary,
                              size: 18,
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          error: (Object error, StackTrace stackTrace) {},
          loading: () {},
        ),
        body: userValue.when(
          data: (appUser) {
            if (appUser.userRole == UserRole.student) {
              return const StudentClassScreen();
            } else if (appUser.userRole == UserRole.teacher) {
              return const TeacherHomeScreen();
            } else {
              return const AdminHomeScreen();
            }
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Error: $err'),
        ));
    //!SECTION
  }
}
