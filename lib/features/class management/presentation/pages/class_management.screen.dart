import 'package:flutter/material.dart';
import 'package:smart_attendance_door/Data/Repositories/class.repo.dart';
import 'package:smart_attendance_door/core/widgets/primary_button.dart';
import 'package:smart_attendance_door/features/class%20management/presentation/pages/create_class.screen.dart';
import 'package:smart_attendance_door/features/class%20management/presentation/widgets/class_card.dart';

class ClassManagementScreen extends StatelessWidget {
  final String title;

  const ClassManagementScreen({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          title,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const CreateClassScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.add_box_outlined,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          )
        ],
      ),
      body: FutureBuilder(
          future: ClassRepo().readAll(),
          builder: (context, classesSnapshot) {
            if (classesSnapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: classesSnapshot.data!.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              classesSnapshot.data!.length,
                              (index) => ClassCard(
                                  joinedClass: classesSnapshot.data![index],
                                  isTeacher: true),
                            )),
                      )
                    : Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_circle_outline_outlined,
                                  color: Color(0xffE1E1E1),
                                  size: 80,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'Get Started',
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                //
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                    'It’s seems like you haven’t created any classes yet.',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                //
                                const SizedBox(
                                  height: 16,
                                ),
                                //
                                SizedBox(
                                  width: double.infinity,
                                  child: PrimaryButton(
                                      title: "Create Class",
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                const CreateClassScreen(),
                                          ),
                                        );
                                      }),
                                )
                                //
                              ],
                            ),
                          ),
                        ),
                      ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
