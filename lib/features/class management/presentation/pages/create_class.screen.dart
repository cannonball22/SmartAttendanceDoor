import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_attendance_door/Data/Repositories/student.repo.dart';
import 'package:smart_attendance_door/core/Services/Id%20Generating/id_generating.service.dart';
import 'package:smart_attendance_door/core/widgets/primary_button.dart';

import '../../../../Data/Model/Class/Class.model.dart';
import '../../../../Data/Model/Shared/school_class.enum.dart';
import '../../../../Data/Model/Shared/subject.enum.dart';
import '../../../../Data/Model/Student/student.model.dart';
import '../../../../Data/Repositories/class.repo.dart';
import '../../../../core/widgets/drop_down_menu.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({super.key});

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final _formKey = GlobalKey<FormState>();
  SchoolClass? selectedClass;
  Subject? selectedSubject;
  List<Student>? selectedStudents;

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
            numberOfStudents: selectedStudents!.length,
            schoolClass: selectedClass!,
            subject: selectedSubject!,
            studentIds: selectedStudents!.map((value) => value.id).toList(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create a Class",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: StudentRepo().readAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Padding(
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
                        hintText: "Select your class",
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
                            return 'Select a class that you teach';
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
                      Text(
                        'Subject Name:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DropDownMenu(
                        hintText: "Select your Subjects",
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
                            return 'Select a subject that you teach';
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
                      MultiDropdown<Student>(
                        items: List.generate(
                          snapshot.data!.length,
                          (index) => DropdownItem(
                            label: snapshot.data![index]!.name,
                            value: snapshot.data![index]!,
                          ),
                        ),
                        fieldDecoration: const FieldDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Select students for your class",
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
