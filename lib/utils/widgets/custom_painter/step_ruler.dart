import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepRulerPainter extends CustomPainter {
  final int totalSteps;
  final List<int> activeSteps;
  final double spacing;
  final BuildContext context;

  StepRulerPainter({
    required this.totalSteps,
    required this.activeSteps,
    required this.spacing,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintTick = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.r;
    final paintSmallTick = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.r;

    final double tickHeightSmall = 10.r;
    final double tickHeightBig = 18.r;
    final double circleRadius = 8.r;
    final double centerY = size.height / 2.r;
    final double bottomY = centerY + tickHeightBig;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final totalTicks = totalSteps * 4 - 3;
    final totalWidth = (totalTicks - 1) * spacing;
    final startX = (size.width - totalWidth) / 2.r;

    for (int i = 0; i < totalTicks; i++) {
      final x = startX + i * spacing;
      final isMajorTick = i % 4 == 0;

      if (isMajorTick) {
        // Major tick
        canvas.drawLine(
          Offset(x, centerY),
          Offset(x, centerY + tickHeightBig),
          paintTick,
        );

        // Label
        final stepIndex = i ~/ 4 + 1;
        textPainter.text = TextSpan(
          text: 'E$stepIndex',
          style: Theme.of(context).textTheme.bodySmall,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(x - textPainter.width / 2, centerY + tickHeightBig + 4.r),
        );

        // Circle (above center)
        final circlePaint = Paint()
          ..color = activeSteps.contains(stepIndex - 1)
              ? Color(0xFFF85A83)
              : Colors.white
          ..style = PaintingStyle.fill;

        canvas.drawCircle(Offset(x, centerY - 15.r), circleRadius, circlePaint);
      } else {
        // Minor tick (aligned at bottom)
        canvas.drawLine(
          Offset(x, bottomY - tickHeightSmall),
          Offset(x, bottomY),
          paintSmallTick,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
