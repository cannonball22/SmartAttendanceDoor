//t2 Core Packages Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';

import '../../../../core/Services/Auth/AuthService.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/presentation/pages/home.screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class SignInScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late FormController _formController;

  @override
  void initState() {
    _formController = FormController();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  const Text(
                    'Welcome Back to Smart Attendance Door!',
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Stay connected and engaged with education, whether you’re a teacher, student, or parent',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    controller: _formController.controller("email"),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegExp.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _formController.controller("password"),
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                title: "Sign in",
                onPressed: () async {
                  // await LoadingHelper.start();
                  if (_formKey.currentState!.validate()) {
                    User? user = await AuthService().signInWithEmailAndPassword(
                        _formController.controller("email").text.trim(),
                        _formController.controller("password").text,
                        context);
                    if (user != null) {
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
                },
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text(
            //       'Don’t have an account yet?',
            //       style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //     TertiaryButton(
            //       title: "Sign Up",
            //       onPressed: () {
            //         Navigator.pushReplacement(
            //           context,
            //           MaterialPageRoute<void>(
            //             builder: (BuildContext context) => const SignUpScreen(),
            //           ),
            //         );
            //       },
            //     ),
            //   ],
            // ),
            const SizedBox(height: 42),
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
