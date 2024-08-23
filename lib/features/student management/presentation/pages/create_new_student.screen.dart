//t2 Core Packages Imports
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_snackbar_plus/flutter_snackbar_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_controller/form_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_attendance_door/Data/Model/Class/Class.model.dart';
import 'package:smart_attendance_door/Data/Model/Shared/gender.enum.dart';
import 'package:smart_attendance_door/Data/Model/Student/student.model.dart';
import 'package:smart_attendance_door/Data/Repositories/class.repo.dart';
import 'package:smart_attendance_door/Data/Repositories/student.repo.dart';
import 'package:smart_attendance_door/core/Services/Imaging/imaging.service.dart';
import 'package:smart_attendance_door/core/widgets/drop_down_menu.dart';
import 'package:smart_attendance_door/core/widgets/primary_button.dart';

import '../../../../core/Services/Firebase Storage/firebase_storage.service.dart';
import '../../../../core/Services/Firebase Storage/src/models/storage_file.model.dart';
import '../../../../core/Services/Id Generating/id_generating.service.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class CreateNewStudentScreen extends StatefulWidget {
  //SECTION - Widget Arguments

  //!SECTION
  //
  const CreateNewStudentScreen({
    super.key,
  });

  @override
  State<CreateNewStudentScreen> createState() => _CreateNewStudentScreenState();
}

class _CreateNewStudentScreenState extends State<CreateNewStudentScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  late FormController _formController;
  final _formKey = GlobalKey<FormState>();
  XFile? profileImage;
  Gender? selectedGender;
  Class? selectedClass;
  String? dateOfBirth;

  //t2 --Controllers
  //
  //t2 --State
  //t2 --State
  //
  //t2 --Constants
  //t2 --Constants
  //!SECTION

  @override
  void initState() {
    super.initState();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --Controllers & Listeners
    _formController = FormController();
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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      _formController.controller("dateOfBirth").text =
          "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
      // setState(() {
      // });
    }
  }

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
        future: ClassRepo().readAll(),
        builder: (context, classesSnapshot) {
          if (classesSnapshot.connectionState == ConnectionState.done &&
              classesSnapshot.hasData) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          profileImage =
                              await ImagingService.captureSingleImages();
                          setState(() {});
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFFF1EAFE),
                          radius: 36,
                          child: profileImage == null
                              ? const Icon(
                                  Icons.person_outlined,
                                  size: 48,
                                  // color: Color(0xff824AFD),
                                )
                              : ClipOval(
                                  child: Image.file(
                                    File(profileImage!.path),
                                    fit: BoxFit.cover,
                                    width: 72,
                                    height: 72,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Full name:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFormField(
                      controller: _formController.controller("fullName"),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Full name",
                        // label: Text("Full name"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter student's full name";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Email:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFormField(
                      controller: _formController.controller("email"),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter student's email",
                        // label: Text("Email"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter student's email";
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Gender:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    DropDownMenu(
                      hintText: "Select Gender",
                      value: selectedGender,
                      // labelText: 'Gender',
                      items: const [
                        DropdownMenuItem(
                          value: Gender.male,
                          child: Text("Male"),
                        ),
                        DropdownMenuItem(
                          value: Gender.female,
                          child: Text("Female"),
                        ),
                      ],
                      validator: (value) {
                        if (value == null || selectedGender == null) {
                          return "Please enter student's gender";
                        }
                        return null;
                      },
                      onChanged: (Gender? newValue) {
                        selectedGender = newValue;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Date of Birth:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFormField(
                      controller: _formController.controller("dateOfBirth"),
                      decoration: const InputDecoration(
                        hintText: "mm/dd/yyyy",
                        // label: Text("Date of Birth"),
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Date cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Phone Number:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFormField(
                      controller: _formController.controller("phoneNumber"),
                      decoration: const InputDecoration(
                        hintText: "Enter phone number",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter student's phone number";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Parent Phone Number:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFormField(
                      controller:
                          _formController.controller("parentPhoneNumber"),
                      decoration: const InputDecoration(
                        hintText: "Enter phone number",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter student's parent's phone number";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Class:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    DropDownMenu(
                      hintText: "Select Class",
                      value: selectedClass,
                      items: List.generate(
                        classesSnapshot.data?.length ?? 0,
                        (index) => DropdownMenuItem(
                          value: classesSnapshot.data![index],
                          child: Text(classesSnapshot.data![index]!.name,
                              style: Theme.of(context).textTheme.bodySmall),
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
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                title: "Add Student",
                onPressed: () async {
                  if (profileImage == null) {
                    SnackbarHelper.showTemplated(
                      context,
                      title: "Please provide an image for the student",
                      style: FlutterSnackBarStyle(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        titleStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                    );
                    return;
                  }
                  //
                  //
                  //
                  //
                  if (_formKey.currentState!.validate()) {
                    String studentId = IdGeneratingService.generate();
                    await FirebaseStorageService.uploadSingle(
                        '/students/$studentId',
                        StorageFile(
                          data: await profileImage!.readAsBytes(),
                          fileName: "userProfilePicture",
                          fileExtension: "jpeg",
                        ))?.then((p0) async {
                      StudentRepo().createSingle(
                        itemId: studentId,
                        Student(
                          id: studentId,
                          name: _formController
                              .controller("fullName")
                              .text
                              .trim(),
                          imageUrl: await p0.ref.getDownloadURL(),
                          gender: selectedGender!,
                          email:
                              _formController.controller("email").text.trim(),
                          dateOfBirth: _formController
                              .controller("dateOfBirth")
                              .text
                              .trim(),
                          phoneNumber: _formController
                              .controller("phoneNumber")
                              .text
                              .trim(),
                          parentPhoneNumber: _formController
                              .controller("parentPhoneNumber")
                              .text
                              .trim(),
                          classesIds: [selectedClass?.id],
                        ),
                      );

                      selectedClass!.studentIds.add(studentId);
                      ClassRepo()
                          .updateSingle(selectedClass!.id, selectedClass!);
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
                                      'Student added Successfully!',
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
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 42),
          ],
        ),
      ),
    );
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    _formController.dispose();
    //!SECTION
    super.dispose();
  }
}
