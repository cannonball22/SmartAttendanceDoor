//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_attendance_door/Data/Model/App%20User/app_user.model.dart';
import 'package:smart_attendance_door/Data/Model/Shared/user_role.enum.dart';
import 'package:smart_attendance_door/core/widgets/students_card_list.dart';
import 'package:smart_attendance_door/core/widgets/tertiary_button.dart';
import 'package:smart_attendance_door/features/class%20management/presentation/pages/edit_class.screen.dart';

import '../../../../Data/Model/Class/Class.model.dart';
import '../../../../Data/Model/Shared/day_of_the_week.enum.dart';
import '../../../../Data/Repositories/user.repo.dart';
import '../../../../notifier.dart';
import '../../../users management/presentation/pages/student_details.screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class ClassDetailsScreen extends ConsumerWidget {
  //SECTION - Widget Arguments
  final Class selectedClass;

  //!SECTION
  //
  const ClassDetailsScreen({
    super.key,
    required this.selectedClass,
  });

  //SECTION - Stateless functions
  Future<List<AppUser?>> getClassStudents() async {
    List<String> studentIds = selectedClass.studentIds;
    List<AppUser> students = [];

    for (String studentId in studentIds) {
      AppUser? fetchedStudent = await AppUserRepo().readSingle(studentId);

      if (fetchedStudent != null) {
        students.add(fetchedStudent);
      }
    }
    return students;
  }

  //SECTION - Action Callbacks
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      appBar: AppBar(
        title: const Text(
          "Class Details",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Class Info"),
                userValue.when(data: (appUser) {
                  if (appUser.userRole == UserRole.admin) {
                    return TertiaryButton(
                        title: "Edit",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  EditClassScreen(selectedClass: selectedClass),
                            ),
                          );
                        });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  "Class name:",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: const Color(0xff808080)),
                )),
                Expanded(
                    child: Text(
                  selectedClass.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                )),
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
                    "Number of Students:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: const Color(0xff808080)),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${selectedClass.studentIds.length} total students",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
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
                    "Start Semester Date:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: const Color(0xff808080)),
                  ),
                ),
                Expanded(
                  child: Text(
                    DateFormat('yyyy-MM-dd')
                        .format(selectedClass.startSemesterDate),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
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
                    "End Semester Date:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: const Color(0xff808080)),
                  ),
                ),
                Expanded(
                  child: Text(
                    DateFormat('yyyy-MM-dd')
                        .format(selectedClass.endSemesterDate),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
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
                    "Weekly Subject Date & Time:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: const Color(0xff808080)),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${DayOfTheWeek.values[selectedClass.weeklySubjectDate.index].name} ${selectedClass.weeklySubjectTime}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              color: Color(0xffE8E8E8),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Students of class ${selectedClass.name}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            FutureBuilder(
              future: getClassStudents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading students'));
                  }
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return SingleChildScrollView(
                        child: Column(
                      children: List.generate(
                        snapshot.data!.length,
                        (index) => StudentsCard(
                          student: snapshot.data![index]!,
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      StudentDetailsScreen(
                                          student: snapshot.data![index]!),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ),
                      ),
                    ));
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
              },
            ),
          ],
        ),
      ),
    );
    //!SECTION
  }
}
