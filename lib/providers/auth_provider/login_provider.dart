import 'package:_29035f/utils/constant.dart';
import 'package:_29035f/utils/reusable_fun.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Email & Password states
final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');

// Login Logic
final loginProvider = AsyncNotifierProvider<LoginController, void>(
  LoginController.new,
);

class LoginController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    return;
  }

  bool isValidEmail(String email) {
    return emailRegex.hasMatch(email);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    const correctEmail = "test@gmail.com";
    const correctPassword = "Test@123";

    try {
      if (email.isEmpty || password.isEmpty) {
        state = const AsyncError(
          'Please enter email or phone number and password',
          StackTrace.empty,
        );
        return;
      }

      final isEmail = isValidEmail(email);
      final isPhone = validatePhoneNumber(email);

      if (!isEmail && !isPhone) {
        state = const AsyncError(
          'Please enter a valid email or phone number',
          StackTrace.empty,
        );
        return;
      }

      await Future.delayed(const Duration(seconds: 1));

      if (email != correctEmail || password != correctPassword) {
        state = const AsyncError('Invalid email or password', StackTrace.empty);
        return;
      }
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
