import 'dart:math';

import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DottedRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final radius = 130.r;
    final gap = 8.r;
    final lineLength = 20.r;

    final dotPaint = Paint()
      ..color = AppColors.accentColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.r;

    final linePaint = Paint()
      ..color = AppColors.accentColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.r;

    const totalSegments = 65;
    for (int i = 0; i < totalSegments; i++) {
      final angle = 2 * pi * i / totalSegments;
      final cosAngle = cos(angle);
      final sinAngle = sin(angle);

      final dotOffset = Offset(
        center.dx + radius * cosAngle,
        center.dy + radius * sinAngle,
      );

      final lineStart = Offset(
        center.dx + (radius + gap) * cosAngle,
        center.dy + (radius + gap) * sinAngle,
      );

      final lineEnd = Offset(
        center.dx + (radius + gap + lineLength) * cosAngle,
        center.dy + (radius + gap + lineLength) * sinAngle,
      );

      canvas.drawLine(dotOffset, dotOffset, dotPaint);
      canvas.drawLine(lineStart, lineEnd, linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
