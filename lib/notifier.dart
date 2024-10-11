import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_attendance_door/Data/Model/App%20User/app_user.model.dart';
import 'package:smart_attendance_door/Data/Repositories/user.repo.dart';
import 'package:smart_attendance_door/core/Services/Auth/AuthService.dart';

final userProvider = StreamProvider<AppUser>((ref) async* {
  final userId = AuthService().getCurrentUserId();
  final userStream = AppUserRepo().streamSingle(userId);
  await for (final appUser in userStream) {
    if (appUser != null) {
      yield appUser;
    }
  }
});
