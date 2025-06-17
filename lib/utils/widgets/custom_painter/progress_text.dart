import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PercentageTextPainter extends CustomPainter {
  final double percentage;
  final BuildContext context;

  PercentageTextPainter(this.percentage, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      color: AppColors.lightTextColor,
      fontWeight: FontWeight.bold,
    );

    final textSpan = TextSpan(text: '${percentage.toInt()}%', style: textStyle);

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout();

    final textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CustomTextPainter extends CustomPainter {
  final String text;
  final TextStyle? textStyle;
  final BuildContext context;

  CustomTextPainter({
    required this.text,
    required this.textStyle,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final textSpan = TextSpan(text: text, style: textStyle);

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout();

    final textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
