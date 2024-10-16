//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:smart_attendance_door/core/Providers/src/condition_model.dart';
import 'package:smart_attendance_door/core/Services/Auth/AuthService.dart';
import 'package:smart_attendance_door/features/class%20management/presentation/widgets/class_card.dart';

import '../../../../Data/Repositories/class.repo.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class TeacherClassManagementScreen extends StatelessWidget {
  // SECTION - Widget Arguments
  //!SECTION
  //
  const TeacherClassManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SECTION - Build Setup
    // Values
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    // Widgets
    //
    // Widgets
    //!SECTION

    // SECTION - Build Return
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Classes",
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: ClassRepo().readAllWhere([
            QueryCondition.equals(
                field: "teacherId", value: AuthService().getCurrentUserId())
          ]),
          builder: (context, classesSnapshot) {
            if (classesSnapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    classesSnapshot.data!.isNotEmpty
                        ? SingleChildScrollView(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  classesSnapshot.data!.length,
                                  (index) => ClassCard(
                                    joinedClass: classesSnapshot.data![index],
                                    isTeacher: true,
                                  ),
                                )),
                          )
                        : Expanded(
                            child: Center(
                              child: Text(
                                  "It’s seems like you don't have any classes yet.",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
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
}
