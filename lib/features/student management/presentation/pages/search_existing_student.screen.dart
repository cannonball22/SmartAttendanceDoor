//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:smart_attendance_door/Data/Model/Class/Class.model.dart';
import 'package:smart_attendance_door/Data/Repositories/class.repo.dart';
import 'package:smart_attendance_door/Data/Repositories/student.repo.dart';
import 'package:smart_attendance_door/core/widgets/primary_button.dart';
import 'package:smart_attendance_door/core/widgets/students_card_list.dart';

import '../../../../core/widgets/drop_down_menu.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class SearchExistingStudent extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const SearchExistingStudent({
    super.key,
  });

  @override
  State<SearchExistingStudent> createState() => _SearchExistingStudentState();
}

class _SearchExistingStudentState extends State<SearchExistingStudent> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  //t2 --Controllers
  //
  //t2 --State
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
  Class? selectedClass;

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
        future: StudentRepo().readAll(),
        builder: (context, studentSnapshot) {
          if (studentSnapshot.connectionState == ConnectionState.done &&
              studentSnapshot.hasData) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder(
                future: ClassRepo().readAll(),
                builder: (context, classesSnapshot) {
                  if (classesSnapshot.connectionState == ConnectionState.done) {
                    if (classesSnapshot.hasError) {
                      return const Center(
                        child: Text("Error Fetcing classes"),
                      );
                    }
                    if (classesSnapshot.hasData) {
                      return Column(
                        children: List.generate(
                          studentSnapshot.data!.length,
                          (index) => StudentsCard(
                            student: studentSnapshot.data![index]!,
                            trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Choose a Class',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      content: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            DropDownMenu<Class?>(
                                              hintText: "Select Class",
                                              labelText: "",
                                              value: selectedClass,
                                              items: List.generate(
                                                classesSnapshot.data!.length,
                                                (index) => DropdownMenuItem(
                                                  value: classesSnapshot
                                                      .data![index],
                                                  child: Text(
                                                    classesSnapshot
                                                        .data![index]!.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    selectedClass == null) {
                                                  return "Please enter student's class";
                                                }
                                                return null;
                                              },
                                              onChanged: (Class? newValue) {
                                                selectedClass = newValue;
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    backgroundColor:
                                                        const Color(0xFFF3F3F3),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  child: const Text("Discard"),
                                                ),
                                                const SizedBox(width: 16),
                                                PrimaryButton(
                                                  title: "Add Student",
                                                  onPressed: () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      selectedClass?.studentIds
                                                          .add(studentSnapshot
                                                              .data![index]!
                                                              .id);
                                                      studentSnapshot
                                                          .data![index]!
                                                          .classesIds
                                                          .add(selectedClass!
                                                              .id);
                                                      await StudentRepo()
                                                          .updateSingle(
                                                              studentSnapshot
                                                                  .data![index]!
                                                                  .id,
                                                              studentSnapshot
                                                                      .data![
                                                                  index]!);
                                                      ClassRepo().updateSingle(
                                                          selectedClass!.id,
                                                          selectedClass!);
                                                      selectedClass = null;
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.add_box_outlined),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
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
