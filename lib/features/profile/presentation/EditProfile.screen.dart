//t2 Core Packages Imports
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_attendance_door/Data/Model/App%20User/app_user.model.dart';
import 'package:smart_attendance_door/Data/Model/Shared/gender.enum.dart';
import 'package:smart_attendance_door/Data/Model/Shared/school_class.enum.dart';
import 'package:smart_attendance_door/Data/Repositories/user.repo.dart';
import 'package:smart_attendance_door/core/widgets/drop_down_menu.dart';
import 'package:smart_attendance_door/core/widgets/primary_button.dart';
import 'package:smart_attendance_door/core/widgets/secondary_button.dart';

import '../../../Data/Model/Shared/subject.enum.dart';
import '../../../core/Services/Imaging/imaging.service.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class EditProfileScreen extends StatefulWidget {
  // SECTION - Widget Arguments
  final AppUser appUser;

  //!SECTION
  //
  const EditProfileScreen({super.key, required this.appUser});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  late FormController _formController;
  late Gender selectedGender;
  late List<SchoolClass> selectedClass;
  XFile? profileImage;
  late Subject selectedSubject;
  final _formKey = GlobalKey<FormState>();
  final List<String> _selectedItems = [];

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
    _formController.controller("name").text = widget.appUser.name;
    _formController.controller("email").text = widget.appUser.email;
    _formController.controller("phoneNumber").text = widget.appUser.phoneNumber;
    _formController.controller("dateOfBirth").text = widget.appUser.dateOfBirth;
    selectedGender = widget.appUser.gender;
    selectedClass = widget.appUser.schoolClasses;
    selectedSubject = widget.appUser.subject;
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
      setState(() {
        _formController.controller("dateOfBirth").text =
            "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
      });
    }
  }

  //SECTION - Action Callbacks
  //!SECTION

  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION
    // SECTION - Build Return
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Your Profile",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    profileImage = await ImagingService.captureSingleImages();
                    String? pictureURL;

                    if (profileImage != null) {
                      final FirebaseStorage storage = FirebaseStorage.instance;
                      final Reference storageRef = storage
                          .ref()
                          .child('profile_images')
                          .child('${widget.appUser.id}/${profileImage!.name}');
                      final UploadTask uploadTask =
                          storageRef.putFile(File(profileImage!.path));
                      final TaskSnapshot taskSnapshot = await uploadTask;
                      pictureURL = await taskSnapshot.ref.getDownloadURL();
                    }

                    widget.appUser.imageUrl = pictureURL;

                    await AppUserRepo()
                        .updateSingle(widget.appUser.id, widget.appUser);
                    setState(() {});
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFFF1EAFE),
                        radius: 38,
                        backgroundImage: (widget.appUser.imageUrl != null &&
                                widget.appUser.imageUrl!.isNotEmpty)
                            ? NetworkImage(widget.appUser.imageUrl!)
                            : null,
                        child: (widget.appUser.imageUrl == null ||
                                widget.appUser.imageUrl!.isEmpty)
                            ? Icon(
                                Icons.person_outlined,
                                color: Theme.of(context).colorScheme.primary,
                                size: 38,
                              )
                            : null,
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
                const SizedBox(
                  height: 16,
                ),
                //
                TextFormField(
                  controller: _formController.controller("name"),
                  decoration: const InputDecoration(
                    label: Text("Full name"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full name cannot be empty';
                    } else if (value.length < 3) {
                      return 'Full name must be at least 3 characters long';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 16,
                ),
                //
                TextFormField(
                  controller: _formController.controller("email"),
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 16,
                ),
                // Gender
                DropDownMenu(
                  labelText: "Gender",
                  hintText: "Select your Gender",
                  value: selectedGender,
                  items: List.generate(Gender.values.length, (index) {
                    Gender gender = Gender.values[index];
                    return DropdownMenuItem<Gender>(
                      value: gender,
                      child: Text(gender.name),
                    );
                  }),
                  onChanged: (Gender? newValue) {
                    setState(() {
                      selectedGender = newValue!;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                //
                TextFormField(
                  controller: _formController.controller("dateOfBirth"),
                  decoration: const InputDecoration(
                    hintText: "mm/dd/yyyy",
                    label: Text("Date"),
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
                // specialization
                TextFormField(
                  controller: _formController.controller("phoneNumber"),
                  decoration: const InputDecoration(
                    hintText: "Enter your phone number",
                    label: Text("Phone Number"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16,
                ),
                //
                MultiDropdown<SchoolClass>(
                  items: List.generate(
                    SchoolClass.values.length,
                    (index) => DropdownItem(
                      label: SchoolClass.values[index].name,
                      value: SchoolClass.values[index],
                    ),
                  ),
                  fieldDecoration: const FieldDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Class",
                    hintText: "Select Classes you teach",
                  ),
                  chipDecoration: const ChipDecoration(
                    backgroundColor: Color(0xffFAD196),
                  ),
                  onSelectionChange: (value) {
                    print(value);
                  },
                  // enabled: false,
                ),
                const SizedBox(
                  height: 16,
                ),
                //
                DropDownMenu(
                  labelText: "Subject",
                  hintText: "Select your Subjects",
                  value: selectedSubject,
                  items: List.generate(Subject.values.length, (index) {
                    Subject subject = Subject.values[index];
                    return DropdownMenuItem<Subject>(
                      value: subject,
                      child: Text(subject.name),
                    );
                  }),
                  onChanged: (Subject? newValue) {
                    setState(() {
                      selectedSubject = newValue!;
                    });
                  },
                ),
              ],
            ),
          )),
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
                        widget.appUser.name =
                            _formController.controller("name").text.trim();
                        widget.appUser.email =
                            _formController.controller("email").text.trim();
                        widget.appUser.gender = selectedGender;
                        widget.appUser.dateOfBirth =
                            _formController.controller("dateOfBirth").text;
                        widget.appUser.phoneNumber =
                            _formController.controller("phoneNumber").text;
                        widget.appUser.subject = selectedSubject;

                        await AppUserRepo()
                            .updateSingle(widget.appUser.id, widget.appUser);
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
    _formController.dispose();
    super.dispose();
  }
}
