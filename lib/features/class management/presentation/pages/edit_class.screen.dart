//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_attendance_door/core/widgets/primary_button.dart';

import '../../../../Data/Model/Class/Class.model.dart';
import '../../../../Data/Model/Shared/school_class.enum.dart';
import '../../../../Data/Model/Shared/subject.enum.dart';
import '../../../../Data/Model/Student/student.model.dart';
import '../../../../Data/Repositories/class.repo.dart';
import '../../../../Data/Repositories/student.repo.dart';
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
  late MultiSelectController<Student> multiSelectController;
  List<String>? selectedStudentsIds;
  List<Student>? selectedStudents;
  late List<Student?>? allStudents;
  bool isLoaded = false;

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

    fetchAllStudents().then((students) {
      setState(() {
        allStudents = students;
        if (allStudents != null && allStudents!.isNotEmpty) {
          multiSelectController = MultiSelectController<Student>();

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

  Future<List<Student?>?> fetchAllStudents() async {
    return await StudentRepo().readAll();
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
        title: Text(
          "Edit Class",
          style: Theme.of(context).textTheme.titleMedium,
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
            multiSelectController
                .selectWhere((value) => value.value.id == "262-UXi-34293");
            // if (_formKey.currentState!.validate()) {
            //   await ClassRepo()
            //       .updateSingle(widget.selectedClass.id, widget.selectedClass);
            //   Navigator.pop(context);
            // }
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
