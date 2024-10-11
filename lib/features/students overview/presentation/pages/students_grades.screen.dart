//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';
import 'package:smart_attendance_door/Data/Repositories/student.repo.dart';
import 'package:smart_attendance_door/core/Providers/src/condition_model.dart';

import '../../../../Data/Model/Class/Class.model.dart';
import '../../../../Data/Model/Shared/subject.enum.dart';
import '../../../../Data/Repositories/class.repo.dart';
import '../../../../Data/Repositories/grade.repo.dart';
import '../../../../core/widgets/drop_down_menu.dart';
import '../../../../core/widgets/students_card_list.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class StudentsGradeScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const StudentsGradeScreen({
    super.key,
  });

  @override
  State<StudentsGradeScreen> createState() => _StudentsGradeScreenState();
}

class _StudentsGradeScreenState extends State<StudentsGradeScreen> {
  //
  //SECTION - State Variables
  late FormController _formController;

  //t2 --Controllers

  //
  //t2 --State
  Class? selectedClass;
  Subject? selectedSubject;

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
    _formController = FormController();
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
      body: FutureBuilder(
          future: ClassRepo().readAll(),
          builder: (context, classesSnapshot) {
            if (classesSnapshot.connectionState == ConnectionState.done &&
                classesSnapshot.hasData &&
                classesSnapshot.data != null &&
                classesSnapshot.data!.isNotEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropDownMenu<Class>(
                            hintText: "Select Class",
                            labelText: "Class",
                            value: selectedClass,
                            items: classesSnapshot.data!
                                .map(
                                  (classItem) => DropdownMenuItem<Class>(
                                    value: classItem,
                                    child: Text(
                                      classItem!.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (Class? newValue) {
                              selectedClass = newValue;

                              if (selectedSubject != null &&
                                  selectedClass != null) {
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: DropDownMenu(
                            labelText: "Subject",
                            hintText: "Select your Subjects",
                            value: selectedSubject,
                            items:
                                List.generate(Subject.values.length, (index) {
                              Subject subject = Subject.values[index];
                              return DropdownMenuItem<Subject>(
                                value: subject,
                                child: Text(subject.name),
                              );
                            }),
                            validator: (value) {
                              if (selectedSubject == null) {
                                return 'Select a subject that you teach';
                              }
                              return null;
                            },
                            onChanged: (Subject? newValue) {
                              selectedSubject = newValue!;
                              if (selectedSubject != null &&
                                  selectedClass != null) {
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  (selectedClass == null || selectedSubject == null)
                      ? Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_circle_outlined,
                                    color: Color(0xffE1E1E1),
                                    size: 72,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Attendance',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Choose a Class and date to mark attendance or review past records.',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : FutureBuilder(
                          future: GradeRepo().readAllWhere([
                            QueryCondition.equals(
                              field: "classId",
                              value: selectedClass?.id,
                            ),
                            QueryCondition.equals(
                              field: "subject",
                              value: selectedSubject!.index,
                            ),
                          ]),
                          builder: (context, gradeSnapshot) {
                            if (gradeSnapshot.connectionState ==
                                ConnectionState.done) {
                              if (gradeSnapshot.hasError) {
                                return const Center(
                                    child: Text('Error loading grades'));
                              }
                              if (gradeSnapshot.hasData &&
                                  gradeSnapshot.data!.isNotEmpty) {
                                return SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        decoration: const BoxDecoration(
                                            color: Color(0xFFF3F3F3)),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Name',
                                              style: TextStyle(
                                                color: Color(0xFF1C2244),
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              'Mark',
                                              style: TextStyle(
                                                color: Color(0xFF1C2244),
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: List.generate(
                                          gradeSnapshot.data!.length,
                                          (index) => FutureBuilder(
                                            future: StudentRepo().readSingle(
                                                gradeSnapshot
                                                    .data![index]!.studentId),
                                            builder:
                                                (context, studentSnapshot) {
                                              if (studentSnapshot
                                                      .connectionState ==
                                                  ConnectionState.done) {
                                                if (studentSnapshot.hasError) {
                                                  return const Center(
                                                    child:
                                                        Text("Error occurred!"),
                                                  );
                                                }
                                                if (studentSnapshot.hasData) {
                                                  return StudentsCard(
                                                    student:
                                                        studentSnapshot.data!,
                                                    trailing: Text(
                                                        "${(gradeSnapshot.data?[index]?.finalGrade ?? 0) + (gradeSnapshot.data?[index]?.midtermGrade ?? 0)} "),
                                                  );
                                                }
                                              }
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return const Center(
                                child: Text(
                                  'No grades available',
                                ),
                              );
                            }
                            return const Expanded(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
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
