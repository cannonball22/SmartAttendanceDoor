//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_attendance_door/core/Services/Auth/AuthService.dart';

import '../../../../Data/Model/Attendance/attendance.model.dart';
import '../../../../Data/Model/Class/Class.model.dart';
import '../../../../Data/Model/Shared/day_of_the_week.enum.dart';
import '../../../../Data/Repositories/attendance.repo.dart';
import '../../../../core/Providers/src/condition_model.dart';
import '../../../students overview/presentation/widgets/student_attendance.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class StudentClassDetailsScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Class selectedClass;

  //!SECTION
  //
  const StudentClassDetailsScreen({
    super.key,
    required this.selectedClass,
  });

  @override
  State<StudentClassDetailsScreen> createState() =>
      _StudentClassDetailsScreenState();
}

class _StudentClassDetailsScreenState extends State<StudentClassDetailsScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  final TextEditingController attendanceDate = TextEditingController();

  //t2 --Controllers
  //
  //t2 --State
  DateTime? selectedDate;

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
            const Text("Class Info"),
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
              "Your Attendance",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: attendanceDate,
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
                  firstDate: widget.selectedClass.startSemesterDate,
                  lastDate: widget.selectedClass.endSemesterDate,
                );
                if (selectedDate != null && selectedDate != DateTime.now()) {
                  attendanceDate.text =
                      "${selectedDate?.month}/${selectedDate?.day}/${selectedDate?.year}";

                  if (selectedDate != null) {
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
            const SizedBox(
              height: 16,
            ),
            selectedDate != null
                ? FutureBuilder(
                    future: AttendanceRepo().readAllWhere([
                      QueryCondition.equals(
                          field: "classId", value: widget.selectedClass.id),
                    ]),
                    builder: (context, attendanceSnapshot) {
                      if (attendanceSnapshot.connectionState ==
                          ConnectionState.done) {
                        if (attendanceSnapshot.hasError) {
                          return const Center(
                            child: Text("Error while getting the attendance"),
                          );
                        }

                        List<Attendance?>? attendanceRecords =
                            attendanceSnapshot.data?.where((e) {
                          if (e is Attendance) {
                            return isSameDay(e.date, selectedDate!);
                          }
                          return false;
                        }).toList();

                        Attendance? filteredAttendance;
                        // "786-Sqh-16690"
                        if (attendanceRecords != null) {
                          filteredAttendance = attendanceRecords.firstWhere(
                            (attendance) =>
                                attendance?.studentId ==
                                AuthService().getCurrentUserId(),
                            orElse: () => null,
                          );
                        }

                        if (filteredAttendance == null) {
                          return const Center(
                            child: Text("No Attendance Records for this date"),
                          );
                        }
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              StudentsAttendanceCard(
                                attendance: filteredAttendance,
                              )
                            ],
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  )
                : Container()
            //add attendance
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
