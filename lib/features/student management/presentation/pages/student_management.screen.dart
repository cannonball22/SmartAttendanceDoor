import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_attendance_door/Data/Model/Class/Class.model.dart';
import 'package:smart_attendance_door/Data/Repositories/class.repo.dart';
import 'package:smart_attendance_door/core/widgets/primary_button.dart';
import 'package:smart_attendance_door/features/student%20management/presentation/pages/add_new_student.screen.dart';
import 'package:smart_attendance_door/features/student%20management/presentation/pages/student_details.screen.dart';

import '../../../../Data/Model/Student/student.model.dart';
import '../../../../Data/Repositories/student.repo.dart';
import '../../../../core/widgets/drop_down_menu.dart';
import '../../../../core/widgets/students_card_list.dart';

class StudentManagementScreen extends StatefulWidget {
  const StudentManagementScreen({super.key});

  @override
  State<StudentManagementScreen> createState() =>
      _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  Class? selectedClass;

  Future<List<Student?>> getClassStudents() async {
    List<String> studentIds = selectedClass?.studentIds ?? [];
    List<Student?> students = [];
    for (String studentId in studentIds) {
      Student? fetchedStudent = await StudentRepo().readSingle(studentId);
      if (fetchedStudent != null) {
        students.add(fetchedStudent);
      }
    }
    return students;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Students Management",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const AddNewStudentScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.add_box_outlined,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: ClassRepo().readAll(),
        builder: (context, classesSnapshot) {
          if (classesSnapshot.connectionState == ConnectionState.done) {
            if (classesSnapshot.hasError) {
              return const Center(child: Text('Error loading classes'));
            }
            if (classesSnapshot.hasData && classesSnapshot.data!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropDownMenu<Class>(
                      hintText: "Select Class",
                      value: selectedClass,
                      items: classesSnapshot.data!
                          .map(
                            (classItem) => DropdownMenuItem<Class>(
                              value: classItem,
                              child: Text(
                                classItem!.name,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (Class? newValue) {
                        setState(() {
                          selectedClass = newValue;
                        });
                      },
                    ),
                    selectedClass == null
                        ? Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.graduationCap,
                                    color: Color(0xffE1E1E1),
                                    size: 72,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'View Students',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Select a class from the dropdown list to view student information or add new students.',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: w,
                                    child: PrimaryButton(
                                      title: "Add New Student",
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                const AddNewStudentScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : FutureBuilder<List<Student?>?>(
                            future: getClassStudents(),
                            builder: (context, classStudentsSnapshot) {
                              if (classStudentsSnapshot.connectionState ==
                                  ConnectionState.done) {
                                if (classStudentsSnapshot.hasError) {
                                  return const Center(
                                      child: Text('Error loading students'));
                                }
                                if (classStudentsSnapshot.hasData &&
                                    classStudentsSnapshot.data!.isNotEmpty) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 16),
                                        Text(
                                          "Students of class ${selectedClass!.name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        const SizedBox(height: 16),
                                        Column(
                                          children: List.generate(
                                            classStudentsSnapshot.data!.length,
                                            (index) => StudentsCard(
                                              student: classStudentsSnapshot
                                                  .data![index]!,
                                              trailing: IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (BuildContext
                                                              context) =>
                                                          StudentDetailsScreen(
                                                              student:
                                                                  classStudentsSnapshot
                                                                          .data![
                                                                      index]!),
                                                    ),
                                                  );
                                                },
                                                icon: Icon(Icons
                                                    .arrow_forward_ios_outlined),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                                return const Center(
                                  child: Text(
                                    'No students available',
                                  ),
                                );
                              }
                              return const Expanded(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            },
                          ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No classes available'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
