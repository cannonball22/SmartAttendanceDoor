//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:smart_attendance_door/Data/Model/Class/Class.model.dart';

import '../../../../Data/Model/App User/app_user.model.dart';
import '../../../../Data/Model/Shared/user_role.enum.dart';
import '../../../../Data/Repositories/class.repo.dart';
import '../../../../Data/Repositories/user.repo.dart';
import '../../../../core/Providers/src/condition_model.dart';
import '../../../../core/widgets/drop_down_menu.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/students_card_list.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class SearchExistingUser extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const SearchExistingUser({
    super.key,
  });

  @override
  State<SearchExistingUser> createState() => _SearchExistingUserState();
}

class _SearchExistingUserState extends State<SearchExistingUser> {
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
        future: AppUserRepo().readAllWhere([
          QueryCondition.equals(
              field: "userRole", value: UserRole.student.index),
        ]),
        builder: (context, studentSnapshot) {
          if (studentSnapshot.connectionState == ConnectionState.done &&
              studentSnapshot.hasData) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildClassList(context, studentSnapshot),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
    //!SECTION
  }

  Widget _buildClassList(
      BuildContext context, AsyncSnapshot<List<AppUser?>?> studentSnapshot) {
    return FutureBuilder(
      future: ClassRepo().readAll(),
      builder: (context, classesSnapshot) {
        if (classesSnapshot.connectionState == ConnectionState.done) {
          if (classesSnapshot.hasError) {
            return const Center(child: Text("Error Fetching classes"));
          }
          if (classesSnapshot.hasData) {
            return Column(
              children: List.generate(
                studentSnapshot.data!.length,
                (index) => _buildStudentCard(
                    context,
                    studentSnapshot.data![index]!,
                    classesSnapshot.data!,
                    index),
              ),
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildStudentCard(
      BuildContext context, AppUser student, List<Class?> classes, int index) {
    return StudentsCard(
      student: student,
      trailing: IconButton(
        onPressed: () =>
            _showClassSelectionDialog(context, student, classes, index),
        icon: const Icon(Icons.add_box_outlined),
      ),
    );
  }

  void _showClassSelectionDialog(
      BuildContext context, AppUser student, List<Class?> classes, int index) {
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
                _buildClassDropdown(classes),
                const SizedBox(height: 16),
                _buildDialogActions(context, student, index),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildClassDropdown(List<Class?> classes) {
    return DropDownMenu<Class?>(
      hintText: "Select Class",
      labelText: "",
      value: selectedClass,
      items: List.generate(
        classes.length,
        (index) => DropdownMenuItem(
          value: classes[index],
          child: Text(
            classes[index]!.name,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || selectedClass == null) {
          return "Please enter student's class";
        }
        return null;
      },
      onChanged: (Class? newValue) {
        selectedClass = newValue;
      },
    );
  }

  Row _buildDialogActions(BuildContext context, AppUser student, int index) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            backgroundColor: const Color(0xFFF3F3F3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Discard"),
        ),
        const SizedBox(width: 16),
        PrimaryButton(
          title: "Add Student",
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              selectedClass?.studentIds.add(student.id);
              student.classesIds?.add(selectedClass!.id);
              await AppUserRepo().updateSingle(student.id, student);
              await ClassRepo().updateSingle(selectedClass!.id, selectedClass!);
              selectedClass = null;
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
