//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_attendance_door/features/authentication/presentation/pages/landing.screen.dart';
import 'package:smart_attendance_door/features/profile/presentation/EditProfile.screen.dart';

import '../../../core/Services/Auth/AuthService.dart';
import '../../../notifier.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class ProfileScreen extends ConsumerWidget {
  //SECTION - Widget Arguments

  //!SECTION
  //
  const ProfileScreen({
    super.key,
  });

  //SECTION - Stateless functions
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //SECTION - Build Setup
    //t2 -Values
    //double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    final userValue = ref.watch(userProvider);
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Your Profile",
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () async {
                await AuthService().signOut(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const LandingScreen()),
                  ModalRoute.withName('/'),
                );
              },
              child: Text(
                'Sign out',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            )
          ],
        ),
        body: userValue.when(
          data: (appUser) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFFF1EAFE),
                        radius: 24,
                        backgroundImage: (appUser.imageUrl != null &&
                                appUser.imageUrl!.isNotEmpty)
                            ? NetworkImage(appUser.imageUrl!)
                            : null,
                        child: (appUser.imageUrl == null ||
                                appUser.imageUrl!.isEmpty)
                            ? Icon(
                                Icons.person_outlined,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              )
                            : null,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        appUser.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'General Info',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                EditProfileScreen(appUser: appUser),
                          ),
                        );
                      },
                      child: const Text(
                        'Edit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFAAD49),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Email:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        appUser.email,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Gender:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        appUser.gender.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Date of Birth:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        appUser.dateOfBirth,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Phone Number:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        appUser.phoneNumber,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
        ));
    //!SECTION
  }
}
