import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendance_door/Data/Model/Shared/school_class.enum.dart';
import 'package:smart_attendance_door/Data/Model/Shared/subject.enum.dart';

import '../../../Data/Model/App User/app_user.model.dart';
import '../../../Data/Model/Shared/gender.enum.dart';
import '../../../Data/Repositories/user.repo.dart';
import '../../../core/utils/SnackBar/snackbar.helper.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
    required String fullName,
    required Gender gender,
    required String dateOfBirth,
    required List<SchoolClass> schoolClasses,
    required Subject subject,
    required BuildContext context,
  }) async {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      SnackbarHelper.showTemplated(context,
          content: const Text('Invalid email address'), title: 'Invalid email');
      return false;
    }

    if (password.length < 6) {
      SnackbarHelper.showTemplated(context,
          content: const Text('Password must be at least 6 characters long'),
          title: 'Invalid password');
      return false;
    }

    if (fullName.isEmpty) {
      SnackbarHelper.showTemplated(context,
          content: const Text('Full name cannot be empty'),
          title: 'Invalid name');
      return false;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await AppUserRepo().createSingle(
        AppUser(
          id: userCredential.user!.uid,
          name: fullName,
          email: email,
          phoneNumber: phoneNumber,
          subject: subject,
          gender: gender,
          schoolClasses: schoolClasses,
          dateOfBirth: dateOfBirth,
        ),
        itemId: userCredential.user!.uid,
      );

      return true;
    } catch (e) {
      SnackbarHelper.showTemplated(context,
          content: Text('Error: ${e.toString()}'), title: 'Signup Error');
      return false;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackbarHelper.showTemplated(context,
            content: const Text('No user found for that email.'),
            title: "Invalid User");
      } else if (e.code == 'wrong-password') {
        SnackbarHelper.showTemplated(context,
            title: 'Wrong password.',
            content: const Text("Wrong password provided for that user."));
      }
      return null;
    } catch (e) {
      print('Sign in failed: $e');
      return null;
    }
  }

  Stream<User?> isUserLoggedIn() {
    return _auth.authStateChanges();
  }

  String getCurrentUserId() {
    User? user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Sign out failed: $e');
    }
  }
}
