//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:smart_attendance_door/Data/Model/Shared/subject.enum.dart';
import 'package:smart_attendance_door/Data/Repositories/grade.repo.dart';

import '../../../../Data/Model/Grade/grade.model.dart';
import '../../../../Data/Model/Student/student.model.dart';
import '../../../../core/Providers/src/condition_model.dart';
import '../../../../core/widgets/drop_down_menu.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class StudentGradesScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Student student;

  //!SECTION
  //
  const StudentGradesScreen({
    super.key,
    required this.student,
  });

  @override
  State<StudentGradesScreen> createState() => _StudentGradesScreenState();
}

class _StudentGradesScreenState extends State<StudentGradesScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  //t2 --Controllers
  //
  //t2 --State
  Subject? selectedSubject;

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
    // double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.student.name}'s Grades"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropDownMenu<Subject>(
              hintText: "Select Subject",
              value: selectedSubject,
              items: List.generate(Subject.values.length, (index) {
                Subject subject = Subject.values[index];
                return DropdownMenuItem<Subject>(
                  value: subject,
                  child: Text(subject.name),
                );
              }),
              onChanged: (Subject? newValue) {
                setState(() {
                  selectedSubject = newValue;
                });
              },
            ),
            selectedSubject == null
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.menu_book,
                            color: Color(0xffE1E1E1),
                            size: 72,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Subject',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Choose a subject from the dropdown list to proceed with students information.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  )
                : FutureBuilder<List<Grade?>?>(
                    future: GradeRepo().readAllWhere([
                      QueryCondition.equals(
                        field: 'studentId',
                        value: widget.student.id,
                      )
                    ]),
                    builder: (context, gradeSnapshot) {
                      Grade? studentGrade = gradeSnapshot.data?.firstWhere(
                        (e) => e?.subject.index == selectedSubject?.index,
                        orElse: () => null,
                      );

                      if (gradeSnapshot.connectionState ==
                          ConnectionState.done) {
                        if (gradeSnapshot.hasError) {
                          return const Center(
                              child: Text('Error loading grades'));
                        }
                        if (gradeSnapshot.hasData &&
                            gradeSnapshot.data!.isNotEmpty &&
                            studentGrade != null) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'Overall Result',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '${(studentGrade.midtermGrade ?? 0) + (studentGrade.finalGrade ?? 0)} / 70',
                                          style: const TextStyle(
                                            color: Color(0xFF808080),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.calendar_today),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              studentGrade.midtermExamDate ==
                                                      null
                                                  ? "0"
                                                  : studentGrade
                                                      .midtermExamDate!,
                                              style: const TextStyle(
                                                color: Color(0xFF808080),
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'Edit',
                                            style: TextStyle(
                                              color: Color(0xFFFAAD49),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${selectedSubject!.name} Mid-term',
                                          style: const TextStyle(
                                            color: Color(0xFF344053),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '${studentGrade.midtermGrade ?? 0}/20',
                                          style: const TextStyle(
                                            color: Color(0xFF344053),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.calendar_today),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              studentGrade.finalExamDate == null
                                                  ? "0"
                                                  : studentGrade.finalExamDate!,
                                              style: const TextStyle(
                                                color: Color(0xFF808080),
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'Edit',
                                            style: TextStyle(
                                              color: Color(0xFFFAAD49),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${selectedSubject!.name} Final Exam',
                                          style: const TextStyle(
                                            color: Color(0xFF344053),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '${studentGrade.finalGrade ?? 0}/50',
                                          style: const TextStyle(
                                            color: Color(0xFF344053),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }

                        if (studentGrade == null) {
                          print("Got calllllllllllll");
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 24),
                                const Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Overall Result',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '0/ 70',
                                          style: TextStyle(
                                            color: Color(0xFF808080),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.calendar_today),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              "Didn't start yet",
                                              style: TextStyle(
                                                color: Color(0xFF808080),
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'Edit',
                                            style: TextStyle(
                                              color: Color(0xFFFAAD49),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${selectedSubject!.name} Mid-term',
                                          style: const TextStyle(
                                            color: Color(0xFF344053),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Text(
                                          '0/20',
                                          style: TextStyle(
                                            color: Color(0xFF344053),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.calendar_today),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              "Didn't start yet",
                                              style: TextStyle(
                                                color: Color(0xFF808080),
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'Edit',
                                            style: TextStyle(
                                              color: Color(0xFFFAAD49),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${selectedSubject!.name} Final Exam',
                                          style: const TextStyle(
                                            color: Color(0xFF344053),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Text(
                                          '0 /50',
                                          style: TextStyle(
                                            color: Color(0xFF344053),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
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
