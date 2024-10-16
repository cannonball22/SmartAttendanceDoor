//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:smart_attendance_door/features/class%20management/presentation/pages/class_detials.screen.dart';

import '../../../../Data/Model/Class/Class.model.dart';
import '../../../../core/widgets/primary_button.dart';
import '../pages/student_class_details_screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class ClassCard extends StatelessWidget {
  // SECTION - Widget Arguments
  final Class? joinedClass;
  final bool isTeacher;

  //!SECTION
  //
  const ClassCard(
      {super.key, required this.joinedClass, required this.isTeacher});

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFE6E6E6)),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                joinedClass?.name ?? "",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Column(
              children: [
                Text('${joinedClass?.studentIds.length} total students',
                    style: Theme.of(context).textTheme.bodyMedium),
                PrimaryButton(
                    title: "View Class",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => isTeacher
                              ? ClassDetailsScreen(selectedClass: joinedClass!)
                              : StudentClassDetailsScreen(
                                  selectedClass: joinedClass!,
                                ),
                        ),
                      );
                    })
              ],
            )
          ],
        ),
      ),
    );

    //!SECTION
  }
}
