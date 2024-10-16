//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_attendance_door/Data/Model/App%20User/app_user.model.dart';
import 'package:smart_attendance_door/Data/Repositories/class.repo.dart';

import '../../../../Data/Model/Class/Class.model.dart';
import '../../../../Data/Model/Shared/user_role.enum.dart';
import '../../../../core/widgets/tertiary_button.dart';
import '../../../../notifier.dart';
import 'edit_user_screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class StudentDetailsScreen extends ConsumerWidget {
  // SECTION - Widget Arguments
  final AppUser student;

  //!SECTION
  //
  const StudentDetailsScreen({super.key, required this.student});

  Future<List<Class?>> getClasses() async {
    List<Class?> classes = [];
    if (student.classesIds != null) {
      for (String? classId in student.classesIds!) {
        if (classId != null) {
          Class? fetchedClass = await ClassRepo().readSingle(classId);
          if (fetchedClass != null) {
            classes.add(fetchedClass);
          }
        }
      }
    }

    return classes;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SECTION - Build Setup
    // Values
    // double w = MediaQuery.of(context).size.width;",
    // double h = MediaQuery.of(context).size.height;",
    // Widgets
    //
    final userValue = ref.watch(userProvider);
    // Widgets
    //!SECTION

    // SECTION - Build Return
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(112),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: student.imageUrl != null
                        ? NetworkImage(student.imageUrl!)
                        : const AssetImage('assets/images/default_avatar.png')
                            as ImageProvider,
                    radius: 24,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    student.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'General Info',
                  style: TextStyle(
                    color: Color(0xFF2C2C2C),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                userValue.when(data: (appUser) {
                  if (appUser.userRole == UserRole.admin) {
                    return TertiaryButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                EditStudentScreen(
                              student: student,
                            ),
                          ),
                        );
                      },
                      title: "Edit",
                    );
                  }
                  return Container();
                }, error: (Object error, StackTrace stackTrace) {
                  return Container();
                }, loading: () {
                  return Container();
                })
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            FutureBuilder(
                future: getClasses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error loading data'));
                    }
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Email:',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    student.email,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Gender:',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    student.gender.name,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Date of Birth:',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    student.dateOfBirth,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Phone Number:',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    student.phoneNumber,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Parent Phone Number:',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    student.parentPhoneNumber ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Class:',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          snapshot.data!
                                              .map((schoolClass) =>
                                                  schoolClass!.name)
                                              .join(
                                                  student.classesIds!.length > 1
                                                      ? ', '
                                                      : ''),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(
                      child: Text(
                        'No students available',
                      ),
                    );
                  }
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                })
          ],
        ),
      ),
    );

    //!SECTION
  }
}
