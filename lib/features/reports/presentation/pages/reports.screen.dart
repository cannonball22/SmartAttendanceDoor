//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:smart_attendance_door/Data/Model/Student/student.model.dart';
import 'package:smart_attendance_door/Data/Repositories/grade.repo.dart';
import 'package:smart_attendance_door/Data/Repositories/student.repo.dart';
import 'package:smart_attendance_door/core/Providers/src/condition_model.dart';

import '../../../../core/widgets/drop_down_menu.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class ReportsScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const ReportsScreen({
    super.key,
  });

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  //t2 --Controllers
  //
  //t2 --State
  Student? selectedStudent;

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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedStudent == null
              ? "Reports"
              : "${selectedStudent!.name}'s Report",
        ),
        centerTitle: true,
        actions: selectedStudent != null
            ? [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.picture_as_pdf),
                ),
              ]
            : null,
      ),
      body: FutureBuilder(
          future: StudentRepo().readAll(),
          builder: (context, studentsSnapshot) {
            if (studentsSnapshot.connectionState == ConnectionState.done &&
                studentsSnapshot.hasData &&
                studentsSnapshot.data != null &&
                studentsSnapshot.data!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropDownMenu<Student>(
                            hintText: "Select Student",
                            value: selectedStudent,
                            items: studentsSnapshot.data!
                                .map(
                                  (studentItem) => DropdownMenuItem<Student>(
                                    value: studentItem,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundImage: NetworkImage(
                                            studentItem!.imageUrl,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          studentItem.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (Student? newValue) {
                              setState(() {
                                selectedStudent = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    selectedStudent == null
                        ? Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.insert_chart_outlined,
                                  color: Color(0xffE1E1E1),
                                  size: 80,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'View Reports',
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Select a Student from the dropdown list to view Reports information.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          )
                        : FutureBuilder(
                            future: GradeRepo().readAllWhere([
                              QueryCondition.equals(
                                  field: "studentId",
                                  value: selectedStudent!.id)
                            ]),
                            builder: (context, gradesSnapshot) {
                              if (gradesSnapshot.connectionState ==
                                  ConnectionState.done) {
                                if (gradesSnapshot.hasError) {
                                  return const Center(
                                    child: Text("Error loading grades!"),
                                  );
                                }
                                if (!gradesSnapshot.hasData ||
                                    gradesSnapshot.data == null ||
                                    gradesSnapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text(
                                        "No available grades for this student"),
                                  );
                                }
                                if (gradesSnapshot.hasData) {
                                  return Column(
                                      children: List.generate(
                                          gradesSnapshot.data!.length,
                                          (index) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16.0),
                                                child: Container(
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        const Color(0xFFF6FAF7),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xFFD0C3CC)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              '${gradesSnapshot.data![index]!.subject.name}:',
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF4D444C),
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    0.10,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${((gradesSnapshot.data?[index]?.finalGrade ?? 0) + (gradesSnapshot.data?[index]?.midtermGrade ?? 0)) / 70 * 100} %",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF4D444C),
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    0.10,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                              'Teacher:',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF4D444C),
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    0.10,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Mr. ${gradesSnapshot.data?[index]?.teacherName}",
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF4D444C),
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    0.10,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )));
                                }
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            })
                  ],
                ),
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
