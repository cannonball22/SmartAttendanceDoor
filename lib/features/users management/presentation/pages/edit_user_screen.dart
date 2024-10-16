//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_attendance_door/Data/Model/App%20User/app_user.model.dart';
import 'package:smart_attendance_door/Data/Model/Class/Class.model.dart';
import 'package:smart_attendance_door/Data/Model/Shared/gender.enum.dart';
import 'package:smart_attendance_door/Data/Repositories/class.repo.dart';
import 'package:smart_attendance_door/core/Services/Imaging/imaging.service.dart';
import 'package:smart_attendance_door/core/widgets/drop_down_menu.dart';
import 'package:smart_attendance_door/core/widgets/primary_button.dart';

import '../../../../Data/Repositories/user.repo.dart';
import '../../../../core/widgets/secondary_button.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class EditStudentScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final AppUser student;

  //!SECTION
  //
  const EditStudentScreen({
    super.key,
    required this.student,
  });

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
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
    _formController.controller("fullName").text = widget.student.name;
    _formController.controller("email").text = widget.student.email;
    _formController.controller("dateOfBirth").text = widget.student.dateOfBirth;
    _formController.controller("phoneNumber").text = widget.student.phoneNumber;
    _formController.controller("parentPhoneNumber").text =
        widget.student.parentPhoneNumber ?? "";
    // selectedClass;
    selectedGender = widget.student.gender;
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
      appBar: AppBar(
        title: const Text("Edit Student"),
        centerTitle: true,
        actions: [
          // TextButton(
          //   onPressed: () {},
          //   child: const Text(
          //     'Delete',
          //     style: TextStyle(
          //       color: Color(0xFFBA1A1A),
          //       fontSize: 16,
          //       fontFamily: 'Poppins',
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // )
        ],
      ),
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
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              backgroundImage: widget.student.imageUrl != null
                                  ? NetworkImage(widget.student.imageUrl!)
                                  : const AssetImage(
                                          'assets/images/default_avatar.png')
                                      as ImageProvider,
                              radius: 38,
                            ),
                            const Positioned(
                              right: 2,
                              bottom: -11,
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFFAAD49),
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
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
                    // Text(
                    //   "Class:",
                    //   style: Theme.of(context).textTheme.titleMedium,
                    // ),
                    // const SizedBox(
                    //   height: 4,
                    // ),
                    // DropDownMenu(
                    //   hintText: "Select Class",
                    //   value: selectedClass,
                    //   items: List.generate(
                    //     classesSnapshot.data?.length ?? 0,
                    //     (index) => DropdownMenuItem(
                    //       value: classesSnapshot.data![index],
                    //       child: Text(classesSnapshot.data![index]!.name,
                    //           style: Theme.of(context).textTheme.bodySmall),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || selectedClass == null) {
                    //       return "Please enter student's class";
                    //     }
                    //     return null;
                    //   },
                    //   onChanged: (Class? newValue) {
                    //     selectedClass = newValue;
                    //   },
                    // ),
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
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: SecondaryButton(
                  title: "Discard",
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: PrimaryButton(
                    title: "Save Changes",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        widget.student.name =
                            _formController.controller("fullName").text.trim();
                        widget.student.email =
                            _formController.controller("email").text.trim();
                        widget.student.gender = selectedGender!;
                        widget.student.dateOfBirth =
                            _formController.controller("dateOfBirth").text;
                        widget.student.phoneNumber =
                            _formController.controller("phoneNumber").text;
                        widget.student.parentPhoneNumber = _formController
                            .controller("parentPhoneNumber")
                            .text;
                        await AppUserRepo()
                            .updateSingle(widget.student.id, widget.student);
                        Navigator.pop(context);
                      }
                    })),
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
