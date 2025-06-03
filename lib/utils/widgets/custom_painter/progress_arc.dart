import 'dart:math';

import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressArcPainter extends CustomPainter {
  final double percentage;

  ProgressArcPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width * 0.35.r; // Responsive radius

    final paint = Paint()
      ..color = AppColors.accentColor
      ..strokeWidth = 10
          .r // Responsive stroke width
      ..style = PaintingStyle.stroke;

    double angle = 2 * pi * (percentage / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top
      angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
