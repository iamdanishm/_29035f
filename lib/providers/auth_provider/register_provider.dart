import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerNameProvider = StateProvider<String>((ref) => "");
final registerEmailProvider = StateProvider<String>((ref) => "");
final registerCountryCodeProvider = StateProvider<String>((ref) => "+91");
final registerPhoneNoProvider = StateProvider<String>((ref) => "");
final registerPasswordProvider = StateProvider<String>((ref) => "");
final registerConfirmPasswordProvider = StateProvider<String>((ref) => "");

final registerProvider = AsyncNotifierProvider<RegisterController, void>(
  RegisterController.new,
);

class RegisterController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    return;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isAnyFieldEmpty(
    String name,
    String email,
    String countryCode,
    String phone,
    String password,
    String confirmPassword,
  ) {
    return name.isEmpty ||
        email.isEmpty ||
        countryCode.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty;
  }

  bool isPasswordMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  Future<void> register(
    String name,
    String email,
    String countryCode,
    String phone,
    String password,
    String confirmPassword,
  ) async {
    state = const AsyncLoading();

    try {
      if (isAnyFieldEmpty(
        name,
        email,
        countryCode,
        phone,
        password,
        confirmPassword,
      )) {
        state = const AsyncError(
          'Please fill all the fields',
          StackTrace.empty,
        );
        return;
      }

      if (!isValidEmail(email)) {
        state = const AsyncError(
          'Please enter a valid email address',
          StackTrace.empty,
        );
        return;
      }

      if (password.length < 6) {
        state = const AsyncError(
          'Password must be at least 6 characters long',
          StackTrace.empty,
        );
        return;
      }

      if (!isPasswordMatch(password, confirmPassword)) {
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
