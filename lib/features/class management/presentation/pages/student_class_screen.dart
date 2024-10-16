//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:smart_attendance_door/core/Services/Auth/AuthService.dart';

import '../../../../Data/Repositories/class.repo.dart';
import '../widgets/class_card.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class StudentClassScreen extends StatelessWidget {
  // SECTION - Widget Arguments
  //!SECTION
  //
  const StudentClassScreen({super.key});

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "My Classes",
        ),
      ),
      body: FutureBuilder(
          future: ClassRepo().readAll(),
          builder: (context, classesSnapshot) {
            if (classesSnapshot.connectionState == ConnectionState.done) {
              final joinedClasses = classesSnapshot.data?.where((clas) {
                    return clas?.studentIds
                            .contains(AuthService().getCurrentUserId()) ??
                        false;
                  }).toList() ??
                  [];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    joinedClasses.isNotEmpty
                        ? SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                joinedClasses.length,
                                (index) => ClassCard(
                                  joinedClass: joinedClasses[index],
                                  isTeacher: false,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Center(
                              child: Text(
                                  'It’s seems like you haven’t joined any classes yet.',
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
