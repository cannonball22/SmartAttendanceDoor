import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

import '../../../../Data/Model/Shared/gender.enum.dart';
import '../../../../Data/Model/Shared/school_class.enum.dart';
import '../../../../Data/Model/Shared/subject.enum.dart';
import '../../../../core/widgets/drop_down_menu.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';

class StepTwoWidget extends StatelessWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  final Gender? selectedGender;
  final List<SchoolClass>? selectedClasses;
  final Subject? selectedSubject;
  final Function(Subject?) onSubjectChanged;
  final Function(List<SchoolClass>) onClassesChanged;
  final Function(Gender?) onGenderChanged;
  final Function(BuildContext context) onSelectDate;
  final Function() previousPage;
  final Function() createAccount;

  final TextEditingController phoneNumberController;
  final TextEditingController dobController;

  const StepTwoWidget({
    super.key,
    this.selectedGender,
    this.selectedClasses,
    this.selectedSubject,
    required this.onSubjectChanged,
    required this.onClassesChanged,
    required this.onGenderChanged,
    required this.onSelectDate,
    required this.previousPage,
    required this.phoneNumberController,
    required this.dobController,
    required this.createAccount,
  });

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Step 2 of 2',
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
                  controller: phoneNumberController,
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
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 16,
                ),
                DropDownMenu(
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
                  onChanged: onGenderChanged,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: dobController,
                  decoration: const InputDecoration(
                    hintText: "mm/dd/yyyy",
                    label: Text("Date of Birth"),
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () => onSelectDate(context),
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
                    if (selectedClasses == null) {
                      return 'Please select the grade you teach for';
                    }
                    return null;
                  },
                  onSelectionChange: onClassesChanged,
                ),
                const SizedBox(
                  height: 16,
                ),
                DropDownMenu(
                  // labelText: "Subjects",
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
                  onChanged: onSubjectChanged,
                ),
              ],
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
                title: 'Create account',
                onPressed: createAccount,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: SecondaryButton(
                title: "Back",
                onPressed: previousPage,
              ),
            ),
          ],
        ),
      ),
    );
    //!SECTION
  }
}
