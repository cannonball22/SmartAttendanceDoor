//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';
import 'package:smart_attendance_door/Data/Model/Attendance/attendance.model.dart';
import 'package:smart_attendance_door/Data/Model/Class/Class.model.dart';
import 'package:smart_attendance_door/Data/Repositories/attendance.repo.dart';
import 'package:smart_attendance_door/Data/Repositories/class.repo.dart';
import 'package:smart_attendance_door/core/Providers/src/condition_model.dart';
import 'package:smart_attendance_door/core/Services/Auth/AuthService.dart';

import '../../../../core/widgets/drop_down_menu.dart';
import '../widgets/student_attendance.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class StudentsAttendanceScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final bool? isAdmin;

  //!SECTION
  //
  const StudentsAttendanceScreen({
    super.key,
    this.isAdmin,
  });

  @override
  State<StudentsAttendanceScreen> createState() =>
      _StudentsAttendanceScreenState();
}

class _StudentsAttendanceScreenState extends State<StudentsAttendanceScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  late FormController _formController;

  //t2 --Controllers

  //
  //t2 --State
  Class? selectedClass;
  DateTime? selectedDate;
  List<Class?>? classes;
  bool isLoaded = false;

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
    if (widget.isAdmin == true) {
      ClassRepo().readAll().then((val) {
        setState(() {
          classes = val;
          isLoaded = true;
        });
      });
    } else {
      ClassRepo().readAllWhere([
        QueryCondition.equals(
            field: 'teacherId', value: AuthService().getCurrentUserId())
      ]).then((val) {
        setState(() {
          classes = val;
          isLoaded = true;
        });
      });
    }

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
  Future<void> _selectDate(BuildContext context) async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null && selectedDate != DateTime.now()) {
      _formController.controller("dateOfBirth").text =
          "${selectedDate?.month}/${selectedDate?.day}/${selectedDate?.year}";

      if (selectedClass != null && selectedDate != null) {
        setState(() {});
      }
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
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
        title: const Text("Students Attendance"),
        centerTitle: true,
      ),
      body: isLoaded
          ? Column(
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
                          items: classes!
                              .map(
                                (classItem) => DropdownMenuItem<Class>(
                                  value: classItem,
                                  child: Text(
                                    classItem!.name,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (Class? newValue) {
                            setState(() {
                              selectedClass = newValue;
                            });
                            //
                            // if (selectedClass != null &&
                            //     selectedDate != null) {
                            //   setState(() {});
                            // }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          enabled: selectedClass != null ? true : false,
                          controller: _formController.controller("dateOfBirth"),
                          decoration: const InputDecoration(
                            hintText: "mm/dd/yyyy",
                            label: Text("Date"),
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          onTap: () async {
                            selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: selectedClass!.startSemesterDate,
                              lastDate: selectedClass!.endSemesterDate,
                            );
                            if (selectedDate != null &&
                                selectedDate != DateTime.now()) {
                              _formController.controller("dateOfBirth").text =
                                  "${selectedDate?.month}/${selectedDate?.day}/${selectedDate?.year}";

                              if (selectedClass != null &&
                                  selectedDate != null) {
                                print("got called from fun");
                                setState(() {});
                              }
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Date cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                (selectedClass == null || selectedDate == null)
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
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : FutureBuilder(
                        future: AttendanceRepo().readAllWhere([
                          QueryCondition.equals(
                              field: "classId", value: selectedClass!.id),
                        ]),
                        builder: (context, attendanceSnapshot) {
                          if (attendanceSnapshot.connectionState ==
                              ConnectionState.done) {
                            if (attendanceSnapshot.hasError) {
                              return const Center(
                                child:
                                    Text("Error while getting the attendance"),
                              );
                            }
                            List<Attendance?>? attendanceRecords =
                                attendanceSnapshot.data?.where((e) {
                              if (e is Attendance) {
                                return isSameDay(e.date, selectedDate!);
                              }
                              return false;
                            }).toList();
                            List<String> existingStudentIds = attendanceRecords
                                    ?.map((e) => e!.studentId)
                                    .toList() ??
                                [];

                            for (String studentId
                                in selectedClass!.studentIds) {
                              if (!existingStudentIds.contains(studentId)) {
                                Attendance newAttendance = Attendance(
                                  id: studentId,
                                  attendance: false,
                                  studentId: studentId,
                                  classId: selectedClass!.id,
                                  date: DateTime.now(),
                                );

                                attendanceRecords?.add(newAttendance);
                              }
                            }
                            if (attendanceRecords == null ||
                                attendanceRecords.isEmpty) {
                              return const Center(
                                child:
                                    Text("No Attendance Records for this date"),
                              );
                            }
                            if (attendanceSnapshot.hasData) {
                              return SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      child: const Text(
                                        'Name',
                                        style: TextStyle(
                                          color: Color(0xFF1C2244),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(
                                        attendanceRecords.length,
                                        (index) => StudentsAttendanceCard(
                                          attendance: attendanceRecords[index]!,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }

                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
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
