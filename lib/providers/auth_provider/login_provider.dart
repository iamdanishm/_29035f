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
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  final indiaPhoneRegex = RegExp(r'^(\+91[\-\s]?)?[6-9]\d{9}$');
  final netherlandsPhoneRegex = RegExp(r'^(?:\+31|0)[1-9]\d{8}$');
  final nzPhoneRegex = RegExp(r'^(?:\+64|0)[2-9]\d{7,8}$');

  bool validatePhoneNumber(String phone) {
    if (phone.startsWith('+91') ||
        phone.startsWith('91') ||
        RegExp(r'^[6-9]').hasMatch(phone)) {
      return indiaPhoneRegex.hasMatch(phone);
    } else if (phone.startsWith('+31') || phone.startsWith('0')) {
      return netherlandsPhoneRegex.hasMatch(phone);
    } else if (phone.startsWith('+64') || phone.startsWith('0')) {
      return nzPhoneRegex.hasMatch(phone);
    }
    return false;
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
