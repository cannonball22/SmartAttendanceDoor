//t2 Core Packages Imports
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_controller/form_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_attendance_door/Data/Model/Shared/gender.enum.dart';
import 'package:smart_attendance_door/Data/Model/Shared/user_role.enum.dart';
import 'package:smart_attendance_door/Data/Repositories/class.repo.dart';
import 'package:smart_attendance_door/core/Services/Imaging/imaging.service.dart';
import 'package:smart_attendance_door/core/widgets/drop_down_menu.dart';
import 'package:smart_attendance_door/core/widgets/primary_button.dart';

import '../../../../Data/Model/App User/app_user.model.dart';
import '../../../../Data/Repositories/user.repo.dart';
import '../../../../core/Services/Auth/AuthService.dart';
import '../../../../core/Services/Firebase Storage/firebase_storage.service.dart';
import '../../../../core/Services/Firebase Storage/src/models/storage_file.model.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class CreateNewUserScreen extends StatefulWidget {
  //SECTION - Widget Arguments

  //!SECTION
  //
  const CreateNewUserScreen({
    super.key,
  });

  @override
  State<CreateNewUserScreen> createState() => _CreateNewUserScreenState();
}

class _CreateNewUserScreenState extends State<CreateNewUserScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  late FormController _formController;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  XFile? profileImage;
  Gender? selectedGender;
  UserRole? selectedUserRole;

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

  Future<bool> _showPasswordConfirmationDialog(
      TextEditingController currentPassword, BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Enter your password to confirm!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: currentPassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Enter your password number",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty!";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        title: "Done",
                        onPressed: () async {
                          if (_formKey2.currentState!.validate()) {
                            UserCredential? currentUser;

                            currentUser = await AuthService()
                                .reAuthenticate(currentPassword.text);

                            if (currentUser != null) {
                              Navigator.of(context).pop(true);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }

  Future<void> _uploadUserProfileImage(
      String userId, XFile? profileImage) async {
    print("Got called 1");
    if (profileImage != null) {
      await FirebaseStorageService.uploadSingle(
          '/users/$userId',
          StorageFile(
            data: await profileImage.readAsBytes(),
            fileName: "userProfilePicture",
            fileExtension: "jpeg",
          ))?.then((p0) async {
        AppUserRepo().createSingle(
          itemId: userId,
          AppUser(
            id: userId,
            name: _formController.controller("fullName").text.trim(),
            imageUrl: await p0.ref.getDownloadURL(),
            gender: selectedGender!,
            email: _formController.controller("email").text.trim(),
            dateOfBirth: _formController.controller("dateOfBirth").text.trim(),
            phoneNumber: _formController.controller("phoneNumber").text.trim(),
            parentPhoneNumber:
                _formController.controller("parentPhoneNumber").text.trim(),
            classesIds: [],
            userRole: selectedUserRole!,
          ),
        );
      });
    } else {
      print("Got called 2");

      AppUserRepo().createSingle(
        itemId: userId,
        AppUser(
          id: userId,
          name: _formController.controller("fullName").text.trim(),
          gender: selectedGender!,
          email: _formController.controller("email").text.trim(),
          dateOfBirth: _formController.controller("dateOfBirth").text.trim(),
          phoneNumber: _formController.controller("phoneNumber").text.trim(),
          parentPhoneNumber:
              _formController.controller("parentPhoneNumber").text.trim(),
          classesIds: [],
          userRole: selectedUserRole!,
        ),
      );
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Adjust size to fit content
                children: [
                  const Icon(FontAwesomeIcons.graduationCap, size: 60),
                  const SizedBox(height: 16),
                  const Text(
                    'User added Successfully!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      title: "Done",
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
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
                    selectedUserRole == UserRole.student
                        ? Center(
                            child: GestureDetector(
                              onTap: () async {
                                profileImage =
                                    await ImagingService.captureSingleImages();
                                setState(() {});
                              },
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFFF1EAFE),
                                radius: 36,
                                child: profileImage == null
                                    ? const Icon(
                                        Icons.person_outlined,
                                        size: 48,
                                        // color: Color(0xff824AFD),
                                      )
                                    : ClipOval(
                                        child: Image.file(
                                          File(profileImage!.path),
                                          fit: BoxFit.cover,
                                          width: 72,
                                          height: 72,
                                        ),
                                      ),
                              ),
                            ),
                          )
                        : Container(),
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
                          return "Please enter user's full name";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Password:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFormField(
                      controller: _formController.controller("password"),
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter password",
                        // label: Text("Full name"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter user's password name";
                        }
                        return null;
                      },
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
                        hintText: "Enter user's email",
                        // label: Text("Email"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter user's email";
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
                      "User Role:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    DropDownMenu(
                      hintText: "Select User Role",
                      value: selectedUserRole,
                      items: const [
                        DropdownMenuItem(
                          value: UserRole.admin,
                          child: Text("Admin"),
                        ),
                        DropdownMenuItem(
                          value: UserRole.teacher,
                          child: Text("Teacher"),
                        ),
                        DropdownMenuItem(
                          value: UserRole.student,
                          child: Text("Student"),
                        ),
                      ],
                      validator: (value) {
                        if (value == null || selectedUserRole == null) {
                          return "Please enter user's role";
                        }
                        return null;
                      },
                      onChanged: (UserRole? newValue) {
                        setState(() {
                          selectedUserRole = newValue;
                        });
                      },
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
                          return "Please enter user's gender";
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
                          return "Please enter user's phone number";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    selectedUserRole == UserRole.student
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                controller: _formController
                                    .controller("parentPhoneNumber"),
                                decoration: const InputDecoration(
                                  hintText: "Enter phone number",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (selectedUserRole == UserRole.student &&
                                      (value == null || value == '')) {
                                    return "Please enter student's parent's phone number";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                              ),
                            ],
                          )
                        : Container(),
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                title: "Add User",
                onPressed: () async {
                  TextEditingController currentPassword =
                      TextEditingController();

                  // Check for profile image
                  if (profileImage == null &&
                      selectedUserRole == UserRole.student) {
                    SnackbarHelper.showTemplated(
                      context,
                      title: "Please provide an image for the user",
                      backgroundColor: Theme.of(context).colorScheme.error,
                      titleStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onError,
                      ),
                    );
                    return;
                  }

                  // Validate the form
                  if (_formKey.currentState!.validate()) {
                    // Show password confirmation dialog
                    bool isPasswordConfirmed =
                        await _showPasswordConfirmationDialog(
                            currentPassword, context);
                    if (isPasswordConfirmed) {
                      // Proceed with the sign-up process if password is confirmed
                      String? userId = await AuthService()
                          .signUpWithEmailAndPassword(
                              newPassword: _formController
                                  .controller("password")
                                  .text
                                  .trim(),
                              newEmail: _formController
                                  .controller("email")
                                  .text
                                  .trim(),
                              currentPassword: currentPassword.text,
                              context: context);

                      if (userId != null) {
                        await _uploadUserProfileImage(userId, profileImage);

                        _showSuccessDialog(context);
                      }
                    }
                  }
                },
              ),
            ),
            const SizedBox(height: 42),
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
