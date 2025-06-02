import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpState {
  final List<String> digits;
  final bool isVerified;

  OtpState({required this.digits, this.isVerified = false});

  OtpState copyWith({List<String>? digits, bool? isVerified}) {
    return OtpState(
      digits: digits ?? this.digits,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}

final otpProvider = AsyncNotifierProvider<OtpAsyncNotifier, OtpState>(() {
  return OtpAsyncNotifier();
});

class OtpAsyncNotifier extends AsyncNotifier<OtpState> {
  @override
  FutureOr<OtpState> build() {
    return OtpState(digits: List.filled(4, ''));
  }

  void updateDigit(int index, String val) {
    final newDigits = [...state.value!.digits];
    newDigits[index] = val;
    state = AsyncData(state.value!.copyWith(digits: newDigits));
  }

  void resetDigits() {
    state = AsyncData(OtpState(digits: List.filled(4, '')));
  }

  Future<void> submitOtp() async {
    final otpCode = state.value!.digits.join();
    log("OTP: $otpCode");

    state = const AsyncLoading();

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      const correctOTP = '1234';

      if (otpCode != correctOTP) {
        state = const AsyncError('Invalid OTP', StackTrace.empty);
        return;
      }

      // On success, you can update state or do something else
      state = AsyncData(
        state.value!.copyWith(isVerified: true),
      ); // or store success flag
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void clearVerificationFlag() {
    final current = state.value;
    if (current != null && current.isVerified) {
      state = AsyncData(current.copyWith(isVerified: false));
    }
  }
}

class OtpTimerNotifier extends StateNotifier<int> {
  Timer? _timer;

  OtpTimerNotifier() : super(30) {
    start();
  }

  void start() {
    _timer?.cancel(); // Cancel previous timer if any
    state = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void reset([int startFrom = 30]) {
    _timer?.cancel();
    state = startFrom;
    start();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final otpTimerProvider = StateNotifierProvider<OtpTimerNotifier, int>(
  (ref) => OtpTimerNotifier(),
);

final otpResetCounterProvider = StateProvider<int>((ref) => 0);
