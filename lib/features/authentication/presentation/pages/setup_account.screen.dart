//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_attendance_door/core/widgets/secondary_button.dart';
import 'package:smart_attendance_door/features/authentication/presentation/pages/upload_id_photo.screen.dart';

import '../../../../Data/Model/Shared/gender.enum.dart';
import '../../../../Data/Model/Shared/school_class.enum.dart';
import '../../../../Data/Model/Shared/subject.enum.dart';
import '../../../../core/widgets/drop_down_menu.dart';
import '../../../../core/widgets/primary_button.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class SetupAccountScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final FormController formController;

  //!SECTION
  //
  const SetupAccountScreen({
    super.key,
    required this.formController,
  });

  @override
  State<SetupAccountScreen> createState() => _SetupAccountScreenState();
}

class _SetupAccountScreenState extends State<SetupAccountScreen> {
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
  Gender? selectedGender;
  List<SchoolClass>? selectedClasses;
  Subject? selectedSubject;

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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        widget.formController.controller("dateOfBirth").text =
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
    //double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Step 2 of 3',
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Setup Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'This help us customize your experience and provide relevant resources.',
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Personal info:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: widget.formController.controller("phoneNumber"),
                    decoration: const InputDecoration(
                      hintText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropDownMenu(
                    labelText: "gender",
                    hintText: "Select your gender",
                    value: selectedGender,
                    items: List.generate(Gender.values.length, (index) {
                      Gender gender = Gender.values[index];
                      return DropdownMenuItem<Gender>(
                        value: gender,
                        child: Text(gender.name),
                      );
                    }),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                    onChanged: (Gender? newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: widget.formController.controller("dateOfBirth"),
                    decoration: const InputDecoration(
                      hintText: "mm/dd/yyyy",
                      label: Text("Date of Birth"),
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
                  MultiDropdown<SchoolClass>(
                    // value: selectedClass,
                    items: List.generate(
                      SchoolClass.values.length,
                      (index) => DropdownItem(
                        label: SchoolClass.values[index].name,
                        value: SchoolClass.values[index],
                      ),
                    ),
                    fieldDecoration: const FieldDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Grade",
                      hintText: "Choose the grade you teach for",
                    ),
                    chipDecoration: const ChipDecoration(
                      backgroundColor: Color(0xffFAD196),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select the grade you teach for';
                      }
                      return null;
                    },
                    onSelectionChange: (newValue) {
                      setState(() {
                        selectedClasses = newValue;
                      });
                      print(newValue);
                    },
                    // enabled: false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropDownMenu(
                    labelText: "Subjects",
                    hintText: "Pick the subject you teach",
                    value: selectedSubject,
                    items: List.generate(Subject.values.length, (index) {
                      Subject subject = Subject.values[index];
                      return DropdownMenuItem<Subject>(
                        value: subject,
                        child: Text(subject.name),
                      );
                    }),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select the subject you teach';
                      }
                      return null;
                    },
                    onChanged: (Subject? newValue) {
                      setState(() {
                        selectedSubject = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                title: 'Next',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => UploadIDPhotoScreen(
                          formController: widget.formController,
                          selectedClass: selectedClasses!,
                          selectedSubject: selectedSubject!,
                          selectedGender: selectedGender!,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: SecondaryButton(
                title: "Back",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    super.dispose();
  }
}
