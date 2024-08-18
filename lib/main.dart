import 'package:flutter/material.dart';
import 'package:smart_attendance_door/theme.dart';
import 'package:smart_attendance_door/util.dart';

import 'core/Services/App/app.service.dart';
import 'core/Services/Auth/AuthService.dart';
import 'core/Services/Firebase/firebase.service.dart';
import 'features/authentication/presentation/pages/landing.screen.dart';
import 'features/home/presentation/pages/home.screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await App.initialize(AppEnvironment.dev);

  await FirebaseService.initialize();
  runApp(const SmartAttendanceDoorApp());
}

class SmartAttendanceDoorApp extends StatelessWidget {
  const SmartAttendanceDoorApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: theme.light().colorScheme,
        textTheme: textTheme,
      ),
      // highContrastTheme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: theme.lightHighContrast().colorScheme,
      //   textTheme: textTheme,
      // ),
      // darkTheme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: theme.dark().colorScheme,
      //   textTheme: textTheme,
      // ),
      // highContrastDarkTheme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: theme.darkHighContrast().colorScheme,
      //   textTheme: textTheme,
      // ),
      home: StreamBuilder(
        stream: AuthService().isUserLoggedIn(),
        builder: (builder, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LandingScreen();
          }
        },
      ),
    );
  }
}
