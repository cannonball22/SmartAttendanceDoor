//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_attendance_door/Data/Repositories/student.repo.dart';
import 'package:smart_attendance_door/core/widgets/students_card_list.dart';
import 'package:smart_attendance_door/core/widgets/tertiary_button.dart';
import 'package:smart_attendance_door/features/class%20management/presentation/pages/edit_class.screen.dart';
import 'package:smart_attendance_door/features/student%20management/presentation/pages/student_details.screen.dart';

import '../../../../Data/Model/Class/Class.model.dart';
import '../../../../Data/Model/Shared/day_of_the_week.enum.dart';
import '../../../../Data/Model/Student/student.model.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class ClassDetailsScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Class selectedClass;

  //!SECTION
  //
  const ClassDetailsScreen({
    super.key,
    required this.selectedClass,
  });

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
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
  Future<List<Student?>> getClassStudents() async {
    List<String> studentIds = widget.selectedClass.studentIds;
    List<Student?> students = [];
    for (String studentId in studentIds) {
      Student? fetchedStudent = await StudentRepo().readSingle(studentId);
      if (fetchedStudent != null) {
        students.add(fetchedStudent);
      }
    }
    return students;
  }

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
                TertiaryButton(
                    title: "Edit",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => EditClassScreen(
                              selectedClass: widget.selectedClass),
                        ),
                      );
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
                  widget.selectedClass.name,
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
                    "${widget.selectedClass.studentIds.length} total students",
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
                        .format(widget.selectedClass.startSemesterDate),
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
                        .format(widget.selectedClass.endSemesterDate),
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
                    "${DayOfTheWeek.values[widget.selectedClass.weeklySubjectDate.index].name} ${widget.selectedClass.weeklySubjectTime}",
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
              "Students of class ${widget.selectedClass.name}",
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
                            icon: Icon(Icons.arrow_forward_ios_outlined),
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

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    super.dispose();
  }
}
