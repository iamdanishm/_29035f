import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressNotifier extends StateNotifier<double> {
  ProgressNotifier() : super(0);

  Timer? _timer;

  void animateTo(
    double target, {
    Duration duration = const Duration(seconds: 2),
  }) {
    _timer?.cancel();
    final int steps = 60;
    final double increment = (target - state) / steps;
    final int intervalMs = (duration.inMilliseconds / steps).floor();
    int currentStep = 0;

    _timer = Timer.periodic(Duration(milliseconds: intervalMs), (timer) {
      if (currentStep >= steps) {
        timer.cancel();
        state = target;
      } else {
        state += increment;
        currentStep++;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final progressProvider = StateNotifierProvider<ProgressNotifier, double>(
  (ref) => ProgressNotifier(),
);
