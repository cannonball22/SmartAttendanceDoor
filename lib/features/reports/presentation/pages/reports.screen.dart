//t2 Core Packages Imports
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:smart_attendance_door/Data/Model/Shared/user_role.enum.dart';
import 'package:smart_attendance_door/Data/Repositories/attendance.repo.dart';
import 'package:smart_attendance_door/Data/Repositories/class.repo.dart';
import 'package:smart_attendance_door/Data/Repositories/user.repo.dart';
import 'package:smart_attendance_door/core/Providers/src/condition_model.dart';

import '../../../../Data/Model/App User/app_user.model.dart';
import '../../../../Data/Model/Attendance Report/attendance_report.model.dart';
import '../../../../Data/Model/Attendance/attendance.model.dart';
import '../../../../Data/Model/Class/Class.model.dart';
import '../../../../core/widgets/drop_down_menu.dart';
import '../widgets/report_summary_card.dart';

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
  AppUser? selectedStudent;
  List<AttendanceReport> attendanceReport = [];

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
  Future<List<Class?>> readAllClasses(Set<String> classesIDs) async {
    List<Class?> classes = [];
    for (String id in classesIDs) {
      classes.add(await ClassRepo().readSingle(id));
    }
    return classes;
  }

  Future<void> sendPdfToWhatsApp(String filePath) async {
    try {
      // Share the PDF file
      await Share.shareXFiles([XFile(filePath)],
          text: 'Here is the attendance record');
    } catch (e) {
      print('Error: $e');
    }
  }

  int countDaysExcludingFridays(DateTime startDate, DateTime endDate) {
    if (startDate.isAfter(endDate)) {
      throw ArgumentError('startDate must be before endDate');
    }

    int count = 0;
    DateTime date = startDate;

    while (date.isBefore(endDate.add(const Duration(days: 1)))) {
      if (date.weekday != DateTime.friday) {
        count++;
      }
      date = date.add(const Duration(days: 1));
    }

    return count;
  }

  int countAttendanceByClassId(attendanceList, currentClass) {
    return attendanceList
            ?.where((attendance) => attendance?.classId == currentClass?.id)
            .length ??
        0;
  }

  pw.Widget buildAttendanceTable(List<AttendanceReport> reports) {
    final data = [
      ['Class ID', 'Class Name - Subject', 'Attendance'],
      for (var report in reports)
        [
          report.classId,
          report.className,
          "${report.attendance.truncate()} %",
        ],
    ];

    return pw.TableHelper.fromTextArray(
      headers: data[0],
      data: data.sublist(1),
    );
  }

  Future<String> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                'Attendance Records',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              buildAttendanceTable(attendanceReport),
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/attendance_records-${selectedStudent?.name}-${DateTime.now()}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    return filePath;
  }

  void generateAttendanceReports(
      List<Class?>? classes, List<Attendance?>? attendanceSnapshot) {
    if (classes == null || attendanceSnapshot == null) {
      print("Classes or attendance snapshot is null.");
      return;
    }

    for (Class? currentClass in classes) {
      if (currentClass == null) continue; // Skip null classes

      final double attendancePercentage =
          (attendanceSnapshot.isEmpty || currentClass == null)
              ? 0
              : (countAttendanceByClassId(attendanceSnapshot, currentClass) /
                      countDaysExcludingFridays(
                        currentClass.startSemesterDate,
                        DateTime.now().isAfter(currentClass.endSemesterDate)
                            ? currentClass.endSemesterDate
                            : DateTime.now(),
                      ) *
                      100)
                  .truncateToDouble();

      attendanceReport.add(
        AttendanceReport(
          classId: currentClass.id,
          className: currentClass.name,
          attendance: attendancePercentage,
        ),
      );
    }

    print("attendanceReport: $attendanceReport");
  }

  //SECTION - Action Callbacks
  //!SECTION

  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
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
                  onPressed: () async {
                    String filePath = await generatePdf();
                    sendPdfToWhatsApp(filePath);
                  },
                  icon: const Icon(Icons.picture_as_pdf),
                ),
              ]
            : null,
      ),
      body: FutureBuilder(
          future: AppUserRepo().readAllWhere([
            QueryCondition.equals(
                field: "userRole", value: UserRole.student.index)
          ]),
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
                          child: DropDownMenu<AppUser>(
                            hintText: "Select Student",
                            value: selectedStudent,
                            items: studentsSnapshot.data!
                                .map(
                                  (studentItem) => DropdownMenuItem<AppUser>(
                                    value: studentItem,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: studentItem
                                                      ?.imageUrl !=
                                                  null
                                              ? NetworkImage(
                                                  studentItem!.imageUrl!)
                                              : const AssetImage(
                                                      'assets/images/default_avatar.png')
                                                  as ImageProvider,
                                          radius: 24,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          studentItem!.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (AppUser? newValue) {
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
                            future: AttendanceRepo().readAllWhere([
                              QueryCondition.equals(
                                  field: "studentId",
                                  value: selectedStudent!.id)
                            ]),
                            builder: (context, attendanceSnapshot) {
                              if (attendanceSnapshot.connectionState ==
                                  ConnectionState.done) {
                                if (attendanceSnapshot.hasError) {
                                  return const Center(
                                    child: Text("Error loading attendance!"),
                                  );
                                }
                                if (!attendanceSnapshot.hasData ||
                                    attendanceSnapshot.data == null ||
                                    attendanceSnapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text(
                                        "No available attendance records for this student"),
                                  );
                                }
                                if (attendanceSnapshot.hasData) {
                                  Set<String> classIdsSet = {};
                                  for (var record in attendanceSnapshot.data!) {
                                    if (record is Attendance) {
                                      classIdsSet.add(record.classId);
                                    }
                                  }

                                  return FutureBuilder(
                                      future: readAllClasses(classIdsSet),
                                      builder: (context, classesSnapshot) {
                                        if (classesSnapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (classesSnapshot.hasError) {
                                            return const Text(
                                                "Error Loading Data");
                                          }
                                          if (classesSnapshot.hasData) {
                                            generateAttendanceReports(
                                                classesSnapshot.data,
                                                attendanceSnapshot.data);
                                            return Column(
                                              children: List.generate(
                                                attendanceReport.length,
                                                (index) => ReportSummaryCard(
                                                  attendanceReport:
                                                      attendanceReport[index],
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      });
                                }
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          )
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
