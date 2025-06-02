import 'package:flutter_riverpod/flutter_riverpod.dart';

final fpEmailProvider = StateProvider<String>((ref) => "");

final fpProvider = AsyncNotifierProvider<ForgotPasswordController, void>(
  ForgotPasswordController.new,
);

class ForgotPasswordController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    return;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> forgotPassword(String email) async {
    state = const AsyncLoading();

    try {
      if (email.isEmpty) {
        state = const AsyncError(
          'Please enter your email address',
          StackTrace.empty,
        );
        return;
      }

      final isEmail = isValidEmail(email);

      if (!isEmail) {
        state = const AsyncError(
          'Please enter a valid email address',
          StackTrace.empty,
        );
        return;
      }
      await Future.delayed(const Duration(seconds: 1));
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
