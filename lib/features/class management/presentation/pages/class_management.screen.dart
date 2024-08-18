import 'package:flutter/material.dart';
import 'package:smart_attendance_door/Data/Repositories/class.repo.dart';
import 'package:smart_attendance_door/core/widgets/primary_button.dart';
import 'package:smart_attendance_door/features/class%20management/presentation/pages/class_detials.screen.dart';
import 'package:smart_attendance_door/features/class%20management/presentation/pages/create_class.screen.dart';

class ClassManagementScreen extends StatefulWidget {
  const ClassManagementScreen({super.key});

  @override
  State<ClassManagementScreen> createState() => _ClassManagementScreenState();
}

class _ClassManagementScreenState extends State<ClassManagementScreen> {
  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Class Management",
          style: Theme.of(context).textTheme.titleMedium,
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
          ),
        ],
      ),
      body: FutureBuilder(
          future: ClassRepo().readAll(),
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
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Color(0xFFE6E6E6)),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              classesSnapshot
                                                  .data![index]!.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                  '${classesSnapshot.data?[index]?.studentIds.length ?? 0} total students',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium),
                                              PrimaryButton(
                                                  title: "View Class",
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute<void>(
                                                        builder: (BuildContext
                                                                context) =>
                                                            ClassDetailsScreen(
                                                          selectedClass:
                                                              classesSnapshot
                                                                      .data![
                                                                  index]!,
                                                        ),
                                                      ),
                                                    );
                                                  })
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    //
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                        'It’s seems like you haven’t created any classes yet.',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
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
                                                builder: (BuildContext
                                                        context) =>
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
  }
}
