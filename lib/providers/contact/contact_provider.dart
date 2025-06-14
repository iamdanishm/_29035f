import 'package:_29035f/utils/constant.dart';
import 'package:_29035f/utils/reusable_fun.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactEmailProvider = StateProvider<String>((ref) => '');
final contactNameProvider = StateProvider<String>((ref) => '');
final contactMessageProvider = StateProvider<String>((ref) => '');
final contactSubscribeCheckProvider = StateProvider<bool>((ref) => false);

final contactProvider = AsyncNotifierProvider<ContactController, void>(
  ContactController.new,
);

class ContactController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    return;
  }

  bool isValidEmail(String email) {
    return emailRegex.hasMatch(email);
  }

  Future<void> sendContact(
    String email,
    String name,
    String message,
    bool subscribe,
  ) async {
    state = const AsyncLoading();
    try {
      if (email.isEmpty || name.isEmpty || message.isEmpty) {
        state = const AsyncError(
          'Please enter name, email and message',
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
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
