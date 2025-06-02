import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final newRPassProvider = StateProvider<String>((ref) => '');
final confirmRPassProvider = StateProvider<String>((ref) => '');

final resetPassProvider = AsyncNotifierProvider<ResetPasswordController, void>(
  ResetPasswordController.new,
);

class ResetPasswordController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    return;
  }

  bool isPasswordMatch(String newPassword, String confirmPassword) {
    return newPassword == confirmPassword;
  }

  Future<void> resetPassword(String newPassword, String confirmPassword) async {
    state = const AsyncLoading();

    log('New Password: $newPassword, Confirm Password: $confirmPassword');

    try {
      if (newPassword.isEmpty || confirmPassword.isEmpty) {
        state = const AsyncError(
          'Please enter new password and confirm password',
          StackTrace.empty,
        );
        return;
      }

      if (!isPasswordMatch(newPassword, confirmPassword)) {
        state = const AsyncError('Passwords do not match', StackTrace.empty);
        return;
      }

      await Future.delayed(const Duration(seconds: 1));
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
