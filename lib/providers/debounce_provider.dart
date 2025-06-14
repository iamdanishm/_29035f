import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final debouncerProvider = Provider.family<Debouncer, Duration>(
  (ref, duration) => Debouncer(duration: duration),
);

class Debouncer {
  Debouncer({required this.duration});
  final Duration duration;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
