import 'package:permission_handler/permission_handler.dart';

//TODO: [x]: Add Required permissions for the app, don't forget to add to the native files.
List<Permission> requirements = [
  //-- For Scheduled Notifications.
  Permission.scheduleExactAlarm,
  //--
  // Permission.camera,
  //--
];
