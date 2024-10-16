//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_attendance_door/Data/Repositories/user.repo.dart';
import 'package:smart_attendance_door/core/widgets/primary_button.dart';

import '../../../../Data/Model/App User/app_user.model.dart';
import '../../../../Data/Model/Class/Class.model.dart';
import '../../../../Data/Model/Shared/day_of_the_week.enum.dart';
import '../../../../Data/Model/Shared/school_class.enum.dart';
import '../../../../Data/Model/Shared/subject.enum.dart';
import '../../../../Data/Repositories/class.repo.dart';
import '../../../../core/widgets/drop_down_menu.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class EditClassScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final Class selectedClass;

  //!SECTION
  //
  const EditClassScreen({
    super.key,
    required this.selectedClass,
  });

  @override
  State<EditClassScreen> createState() => _EditClassScreenState();
}

class _EditClassScreenState extends State<EditClassScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers

  //t2 --Controllers
  //
  //t2 --State
  late SchoolClass selectedClass;
  late Subject selectedSubject;
  late MultiSelectController<AppUser> multiSelectController;
  List<String>? selectedStudentsIds;
  List<AppUser>? selectedStudents;
  late DayOfTheWeek selectedDayOfTheWeek;
  late List<AppUser?>? allStudents;
  bool isLoaded = false;
  late FormController formController;

  //t2 --State
  //
  //t2 --Constants
  final _formKey = GlobalKey<FormState>();

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
    selectedClass = widget.selectedClass.schoolClass;
    selectedSubject = widget.selectedClass.subject;
    selectedStudentsIds = widget.selectedClass.studentIds;
    formController = FormController();
    formController.controller("startSemesterDate").text =
        DateFormat('yyyy-MM-dd').format(widget.selectedClass.startSemesterDate);
    formController.controller("endSemesterDate").text =
        DateFormat('yyyy-MM-dd').format(widget.selectedClass.endSemesterDate);
    selectedDayOfTheWeek = widget.selectedClass.weeklySubjectDate;
    formController.controller("weeklySubjectTime").text =
        widget.selectedClass.weeklySubjectTime;

    fetchAllStudents().then((students) {
      setState(() {
        allStudents = students;
        if (allStudents != null && allStudents!.isNotEmpty) {
          multiSelectController = MultiSelectController<AppUser>();

          multiSelectController.setItems(List.generate(
            allStudents!.length,
            (index) => DropdownItem(
              label: allStudents![index]!.name,
              value: allStudents![index]!,
            ),
          ));

          print("All Students: $allStudents");
          print("Items: ${multiSelectController.items[0].value.name}");
        } else {
          print("No students found or list is empty.");
        }

        isLoaded = true;
      });
    });

    //t2 --State
    //
    //t2 --Late & Async Initializers
    //t2 --Late & Async Initializers
    //!SECTION
  }

  Future<List<AppUser?>?> fetchAllStudents() async {
    return await AppUserRepo().readAll();
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Edit Class",
        ),
        actions: [
          TextButton(
            onPressed: () {
              ClassRepo().deleteSingle(widget.selectedClass.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              "Delete",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: const Color(0xffBA1A1A)),
            ),
          )
        ],
      ),
      body: isLoaded
          ? Padding(
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
                      // labelText: "class",
                      hintText: "Select your class",
                      value: selectedClass,
                      items: List.generate(SchoolClass.values.length, (index) {
                        SchoolClass schoolClass = SchoolClass.values[index];
                        return DropdownMenuItem<SchoolClass>(
                          value: schoolClass,
                          child: Text(schoolClass.name),
                        );
                      }),
                      onChanged: (SchoolClass? newValue) {
                        setState(() {
                          selectedClass = newValue!;
                        });
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
                      // labelText: "Subject",
                      hintText: "Select your Subjects",
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
                          selectedSubject = newValue!;
                        });
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
                          formController.controller("startSemesterDate").text =
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
                      controller: formController.controller("endSemesterDate"),
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
                      items: List.generate(DayOfTheWeek.values.length, (index) {
                        DayOfTheWeek dayOfTheWeek = DayOfTheWeek.values[index];
                        return DropdownMenuItem<DayOfTheWeek>(
                          value: dayOfTheWeek,
                          child: Text(dayOfTheWeek.name),
                        );
                      }),
                      validator: (value) {
                        if (value == null) {
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
                          formController.controller("weeklySubjectTime").text =
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
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // Text('Students Name:',
                    //     style: Theme.of(context).textTheme.titleMedium),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // MultiDropdown<Student>(
                    //   controller: multiSelectController,
                    //   items: multiSelectController.items,
                    //   fieldDecoration: const FieldDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: "Students Name:",
                    //     hintText: "Select students for your class",
                    //   ),
                    //   chipDecoration: const ChipDecoration(
                    //     backgroundColor: Color(0xffFAD196),
                    //   ),
                    //   validator: (value) {
                    //     if (selectedStudents == null) {
                    //       return 'Select students for your class';
                    //     }
                    //     return null;
                    //   },
                    //   onSelectionChange: (value) {
                    //     setState(() {
                    //       selectedStudents = value;
                    //     });
                    //   },
                    // ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PrimaryButton(
          title: 'Save Changes',
          onPressed: () async {
            // multiSelectController
            //     .selectWhere((value) => value.value.id == "262-UXi-34293");
            if (_formKey.currentState!.validate()) {
              String className =
                  "${selectedClass.name} - ${selectedSubject.name}";
              final dateFormat = DateFormat("yyyy-MM-dd");

              widget.selectedClass.name = className;
              widget.selectedClass.schoolClass = selectedClass;
              widget.selectedClass.subject = selectedSubject;
              widget.selectedClass.startSemesterDate = dateFormat
                  .parse(formController.controller("startSemesterDate").text);
              widget.selectedClass.endSemesterDate = dateFormat
                  .parse(formController.controller("endSemesterDate").text);
              widget.selectedClass.weeklySubjectDate = selectedDayOfTheWeek;
              widget.selectedClass.weeklySubjectTime =
                  formController.controller("weeklySubjectTime").text;

              await ClassRepo()
                  .updateSingle(widget.selectedClass.id, widget.selectedClass);
              Navigator.pop(context);
            }
          },
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
