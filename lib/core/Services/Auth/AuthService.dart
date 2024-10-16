import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/SnackBar/snackbar.helper.dart';
import '../Contexter/contexter.service.dart';
import '../Error Handling/error_handling.service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signUpWithEmailAndPassword({
    required String newEmail,
    required String newPassword,
    required String currentPassword,
    required BuildContext context,
  }) async {
    try {
      User? originalUser;

      if (_auth.currentUser != null) {
        originalUser = _auth.currentUser;
      }
      UserCredential newUser = await _auth.createUserWithEmailAndPassword(
        email: newEmail,
        password: newPassword,
      );

      await _auth.signOut();
      print("Orginal User ${originalUser!.email}");
      if (originalUser != null) {
        await _auth.signInWithEmailAndPassword(
            email: originalUser.email!, password: currentPassword);
        print('Re-signed in original user');
      } else {
        print('No original user found');
      }
      return newUser.user?.uid;
    } catch (e) {
      // Show an error message if something goes wrong
      SnackbarHelper.showTemplated(context,
          content: Text('Error: ${e.toString()}'), title: 'Signup Error');
    }
    return null;
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

  //t2 ReAuthenticate
  Future<UserCredential?> reAuthenticate(String password) async {
    try {
      User? user = _auth.currentUser;
      print("Debugggg1 ${user!.email}");
      print("Debugggg2 ${password}");

      UserCredential? userCredential = await user?.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: user.email!, password: password),
      );
      print("Debugggg ${userCredential}");
      return userCredential;
    } catch (e, s) {
      ErrorHandlingService.handle(e, "FBEmailAuth/reAuthenticate",
          stackTrace: s);
      SnackbarHelper.showTemplated(
        Contexter.currentContext,
        title: "You have a wrong password",
        backgroundColor: Theme.of(Contexter.currentContext).colorScheme.error,
        titleStyle: TextStyle(
          color: Theme.of(Contexter.currentContext).colorScheme.onError,
        ),
      );
      return null;
    }
    return null;
  }
}
