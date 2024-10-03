//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:smart_attendance_door/core/widgets/tertiary_button.dart';
import 'package:smart_attendance_door/features/authentication/presentation/pages/sign_in.screen.dart';
import 'package:smart_attendance_door/features/authentication/presentation/pages/sign_up.screen.dart';

import '../../../../core/widgets/primary_button.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports
class LandingScreen extends StatelessWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const LandingScreen({
    super.key,
  });

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Image.asset(
                  'assets/images/landing_screen.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 52,
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Smart Attendance Door',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Help you track and manage the student attendance, ensuring that there are accurate records and easy access to attendance information.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.50,
                      ),
                    )
                  ],
                ),
                // const Spacer(),
              ],
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
                title: "Get Started",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SignUpScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TertiaryButton(
                  title: "Sign in",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const SignInScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 42),
          ],
        ),
      ),
    );

    //!SECTION
  }
}
