//t2 Core Packages Imports
import 'package:flutter/material.dart';

import '../../../../Data/Model/Shared/gender.enum.dart';
import '../../../../Data/Model/Shared/school_class.enum.dart';
import '../../../../Data/Model/Shared/subject.enum.dart';
import '../../../../core/Services/Auth/AuthService.dart';
import '../../../home/presentation/pages/home.screen.dart';
import '../widgets/step_one_widget.dart';
import '../widgets/step_two_widget.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class SignUpScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  final PageController _pageController = PageController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  //t2 --Controllers
  //
  //t2 --State
  int _currentPage = 0;
  Gender? selectedGender;
  List<SchoolClass>? selectedClasses;
  Subject? selectedSubject;

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
  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      if (_currentPage < 2) {
        _pageController.animateToPage(
          _currentPage + 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  createAccount() async {
    // await LoadingHelper.start();
    if (_formKey.currentState!.validate()) {
      bool success = await AuthService().signUpWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
          fullName: fullNameController.text,
          phoneNumber: phoneNumberController.text,
          schoolClasses: selectedClasses!,
          subject: selectedSubject!,
          gender: selectedGender!,
          dateOfBirth: dobController.text,
          context: context);
      if (success) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomeScreen(),
          ),
          (route) => false,
        );
        // await LoadingHelper.stop();
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        dobController.text =
            "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
      });
    }
  }

  //SECTION - Action Callbacks
  //!SECTION
  final _formKey = GlobalKey<FormState>();

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

    //SECTION - Build Return
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              StepOneWidget(
                nextPage: _nextPage,
                emailController: emailController,
                passwordController: passwordController,
                fullNameController: fullNameController,
              ),
              StepTwoWidget(
                dobController: dobController,
                phoneNumberController: phoneNumberController,
                previousPage: _previousPage,
                createAccount: createAccount,
                onSubjectChanged: (Subject? newValue) {
                  setState(() {
                    selectedSubject = newValue!;
                  });
                },
                onClassesChanged: (newValue) {
                  setState(() {
                    selectedClasses = newValue;
                  });
                },
                onGenderChanged: (Gender? newValue) {
                  setState(() {
                    selectedGender = newValue!;
                  });
                },
                onSelectDate: _selectDate,
                selectedSubject: selectedSubject,
                selectedClasses: selectedClasses,
                selectedGender: selectedGender,
              )
            ],
          ),
        ),
      ),
    );
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    dobController.dispose(); //!SECTION
    super.dispose();
  }
}
//t2 Core Packages Imports

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
