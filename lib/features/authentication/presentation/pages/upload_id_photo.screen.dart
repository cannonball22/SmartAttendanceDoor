//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';

import '../../../../Data/Model/Shared/gender.enum.dart';
import '../../../../Data/Model/Shared/school_class.enum.dart';
import '../../../../Data/Model/Shared/subject.enum.dart';
import '../../../../core/Services/Auth/AuthService.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../../home/presentation/pages/home.screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class UploadIDPhotoScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  final FormController formController;
  final Gender selectedGender;
  final List<SchoolClass> selectedClass;
  final Subject selectedSubject;

  //!SECTION
  //
  const UploadIDPhotoScreen({
    super.key,
    required this.formController,
    required this.selectedGender,
    required this.selectedClass,
    required this.selectedSubject,
  });

  @override
  State<UploadIDPhotoScreen> createState() => _UploadIDPhotoScreenState();
}

class _UploadIDPhotoScreenState extends State<UploadIDPhotoScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Step 3 of 3',
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
                  'Upload ID Photo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'This help us verify your educator status securely.',
                  style: TextStyle(
                    color: Color(0xFF808080),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 40),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFE1E1E1)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload_outlined),
                        SizedBox(height: 24),
                        Text(
                          'Front ID Photo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF808080),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFE1E1E1)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload_outlined),
                      SizedBox(height: 24),
                      Text(
                        'Back ID Photo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF808080),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
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
                onPressed: () async {
                  bool success = await AuthService().signUpWithEmailAndPassword(
                      email:
                          widget.formController.controller("email").text.trim(),
                      password:
                          widget.formController.controller("password").text,
                      fullName: widget.formController.controller("name").text,
                      phoneNumber:
                          widget.formController.controller("phoneNumber").text,
                      schoolClasses: widget.selectedClass,
                      subject: widget.selectedSubject,
                      gender: widget.selectedGender,
                      dateOfBirth:
                          widget.formController.controller("dateOfBirth").text,
                      context: context);
                  if (success) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const HomeScreen(),
                      ),
                      (route) => false,
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
