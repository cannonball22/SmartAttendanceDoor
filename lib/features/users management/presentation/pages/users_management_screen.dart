import 'package:flutter/material.dart';
import 'package:smart_attendance_door/Data/Model/App%20User/app_user.model.dart';
import 'package:smart_attendance_door/Data/Model/Class/Class.model.dart';
import 'package:smart_attendance_door/features/users%20management/presentation/pages/search_existing_users_screen.dart';

import '../../../../Data/Repositories/user.repo.dart';
import 'create_new_user_screen.dart';

class UsersManagementScreen extends StatefulWidget {
  const UsersManagementScreen({super.key});

  @override
  State<UsersManagementScreen> createState() => _UsersManagementScreenState();
}

class _UsersManagementScreenState extends State<UsersManagementScreen> {
  Class? selectedClass;

  Future<List<AppUser?>> getClassStudents() async {
    List<String> studentIds = selectedClass?.studentIds ?? [];
    List<AppUser?> students = [];
    for (String studentId in studentIds) {
      AppUser? fetchedStudent = await AppUserRepo().readSingle(studentId);
      if (fetchedStudent != null) {
        students.add(fetchedStudent);
      }
    }
    return students;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Users Management",
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Edit Existing'),
              Tab(text: 'Create New One'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SearchExistingUser(),
            CreateNewUserScreen(),
          ],
        ),
      ),
    );
  }
}
