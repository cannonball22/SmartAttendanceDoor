import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_controller/form_controller.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_attendance_door/Data/Model/App%20User/app_user.model.dart';
import 'package:smart_attendance_door/Data/Model/Shared/user_role.enum.dart';
import 'package:smart_attendance_door/Data/Repositories/user.repo.dart';
import 'package:smart_attendance_door/core/Services/Id%20Generating/id_generating.service.dart';
import 'package:smart_attendance_door/core/widgets/primary_button.dart';

import '../../../../Data/Model/Class/Class.model.dart';
import '../../../../Data/Model/Shared/day_of_the_week.enum.dart';
import '../../../../Data/Model/Shared/school_class.enum.dart';
import '../../../../Data/Model/Shared/subject.enum.dart';
import '../../../../Data/Repositories/class.repo.dart';
import '../../../../core/widgets/drop_down_menu.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({super.key});

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final _formKey = GlobalKey<FormState>();
  List<AppUser> students = [];
  List<AppUser> teachers = [];
  AppUser? selectedTeacher;
  SchoolClass? selectedClass;
  Subject? selectedSubject;
  DayOfTheWeek? selectedDayOfTheWeek;
  List<AppUser>? selectedStudents;
  late FormController formController;

  @override
  void initState() {
    super.initState();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --Controllers & Listeners
    formController = FormController();
    //t2 --Controllers & Listeners
    //
    //t2 --State
    //t2 --State
    //
    //t2 --Late & Async Initializers
    //t2 --Late & Async Initializers
    //!SECTION    super.initState();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        String classId = IdGeneratingService.generate();
        String className = "${selectedClass!.name} - ${selectedSubject!.name}";
        await ClassRepo().createSingle(
          Class(
            id: classId,
            name: className,
            schoolClass: selectedClass!,
            subject: selectedSubject!,
            studentIds: selectedStudents!.map((value) => value.id).toList(),
            startSemesterDate: DateTime.parse(
                formController.controller("startSemesterDate").text),
            endSemesterDate: DateTime.parse(
                formController.controller("endSemesterDate").text),
            weeklySubjectDate: selectedDayOfTheWeek!,
            weeklySubjectTime:
                formController.controller("weeklySubjectTime").text,
            teacherId: selectedTeacher!.id,
          ),
          itemId: classId,
        );
      } catch (e) {
        // Handle errors here
        print('Error: $e');
      } finally {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(
                        FontAwesomeIcons.graduationCap,
                        size: 60,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Class created Successfully!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                            title: "Done",
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        );
      }
    }
  }

  Future<void> runAllFutures() async {
    List<AppUser?>? allUsers = await AppUserRepo().readAll();

    if (allUsers != null) {
      for (AppUser? appUser in allUsers) {
        if (appUser != null) {
          if (appUser.userRole == UserRole.student) {
            students.add(appUser);
          } else if (appUser.userRole == UserRole.teacher) {
            teachers.add(appUser);
          }
        }
      }
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create a Class",
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: runAllFutures(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Class name:',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(
                        height: 8,
                      ),
                      DropDownMenu(
                        hintText: "Select the class name",
                        value: selectedClass,
                        items:
                            List.generate(SchoolClass.values.length, (index) {
                          SchoolClass schoolClass = SchoolClass.values[index];
                          return DropdownMenuItem<SchoolClass>(
                            value: schoolClass,
                            child: Text(schoolClass.name),
                          );
                        }),
                        validator: (value) {
                          if (selectedClass == null) {
                            return 'Select a class';
                          }
                          return null;
                        },
                        onChanged: (SchoolClass? newValue) {
                          selectedClass = newValue!;
                          // setState(() {
                          // });
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('Teacher Name:',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(
                        height: 8,
                      ),
                      DropDownMenu<AppUser>(
                        hintText: "Select the teacher name",
                        value: selectedTeacher,
                        items: List.generate(teachers.length, (index) {
                          AppUser teacher = teachers[index];
                          return DropdownMenuItem<AppUser>(
                            value: teacher,
                            child: Text(teacher.name),
                          );
                        }),
                        validator: (value) {
                          if (selectedTeacher == null) {
                            return 'Select a teacher';
                          }
                          return null;
                        },
                        onChanged: (AppUser? newValue) {
                          selectedTeacher = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Subject Name:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DropDownMenu(
                        hintText: "Select the subject",
                        value: selectedSubject,
                        items: List.generate(Subject.values.length, (index) {
                          Subject subject = Subject.values[index];
                          return DropdownMenuItem<Subject>(
                            value: subject,
                            child: Text(subject.name),
                          );
                        }),
                        validator: (value) {
                          if (selectedSubject == null) {
                            return 'Select a subject';
                          }
                          return null;
                        },
                        onChanged: (Subject? newValue) {
                          selectedSubject = newValue!;
                          // setState(() {
                          // });
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('Students Name:',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(
                        height: 8,
                      ),
                      MultiDropdown<AppUser>(
                        items: List.generate(
                          students?.length ?? 0,
                          (index) => DropdownItem(
                            label: students![index].name,
                            value: students![index],
                          ),
                        ),
                        fieldDecoration: const FieldDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Select students for this class",
                        ),
                        chipDecoration: const ChipDecoration(
                          backgroundColor: Color(0xffFAD196),
                        ),
                        validator: (value) {
                          if (selectedStudents == null) {
                            return 'Select students for your class';
                          }
                          return null;
                        },
                        onSelectionChange: (value) {
                          selectedStudents = value;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('Start Semester Date:',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller:
                            formController.controller("startSemesterDate"),
                        decoration: const InputDecoration(
                          hintText: "Select start date (mm/dd/yyyy)",
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (selectedDate != null &&
                              selectedDate != DateTime.now()) {
                            formController
                                    .controller("startSemesterDate")
                                    .text =
                                "${selectedDate.toLocal().year.toString().padLeft(4, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Start semester date cannot be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('End Semester Date:',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller:
                            formController.controller("endSemesterDate"),
                        decoration: const InputDecoration(
                          hintText: "Select end date (mm/dd/yyyy)",
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (selectedDate != null &&
                              selectedDate != DateTime.now()) {
                            formController.controller("endSemesterDate").text =
                                "${selectedDate.toLocal().year.toString().padLeft(4, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'End semester date cannot be empty';
                          }
                          if (DateTime.parse(formController
                                  .controller("endSemesterDate")
                                  .text)
                              .isBefore(DateTime.parse(formController
                                  .controller("startSemesterDate")
                                  .text))) {
                            return 'End semester date should be after Start semester';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('Weekly Subject day:',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(
                        height: 8,
                      ),
                      DropDownMenu(
                        hintText: "Select weekly day",
                        value: selectedDayOfTheWeek,
                        items:
                            List.generate(DayOfTheWeek.values.length, (index) {
                          DayOfTheWeek dayOfTheWeek =
                              DayOfTheWeek.values[index];
                          return DropdownMenuItem<DayOfTheWeek>(
                            value: dayOfTheWeek,
                            child: Text(dayOfTheWeek.name),
                          );
                        }),
                        validator: (value) {
                          if (value == null || selectedDayOfTheWeek == null) {
                            return 'Weekly subject date cannot be empty';
                          }
                          return null;
                        },
                        onChanged: (DayOfTheWeek? newValue) {
                          selectedDayOfTheWeek = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('Weekly Subject Time:',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller:
                            formController.controller("weeklySubjectTime"),
                        decoration: const InputDecoration(
                          hintText: "Select the time (hh:mm AM/PM)",
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () async {
                          final TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (selectedTime != null) {
                            formController
                                    .controller("weeklySubjectTime")
                                    .text =
                                "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.name}";
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Weekly subject time cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PrimaryButton(
          title: 'Create Class',
          onPressed: () {
            _submitForm();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    super.dispose();
  }
}
