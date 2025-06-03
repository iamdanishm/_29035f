import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/custom_painter/dotted_ring.dart';
import 'package:_29035f/utils/widgets/custom_painter/progress_arc.dart';
import 'package:_29035f/utils/widgets/custom_painter/progress_text.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeuCircularProgress extends ConsumerWidget {
  const NeuCircularProgress({super.key, required this.percentage});

  final double percentage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 50.r,
          child: SizedBox(
            width: 300.r,
            height: 300.r,
            child: CustomPaint(painter: DottedRingPainter()),
          ),
        ),

        Positioned(
          top: 75.r,
          child: SizedBox(
            width: 250.r,
            height: 250.r,
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 5,
                intensity: 0.8,
                shadowLightColor: AppColors.primaryColor,
                shadowDarkColor: AppColors.shadowDark,
                lightSource: LightSource.topLeft,
                color: Color(0xFFF1F1F1),
              ),
            ),
          ),
        ),
        Positioned(
          top: 100.r,
          child: SizedBox(
            width: 200.r,
            height: 200.r,
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
                depth: -5,
                intensity: 0.6,
                shadowDarkColorEmboss: AppColors.shadowDark,
                shadowLightColorEmboss: AppColors.lightWhite,
                lightSource: LightSource.topLeft,
                color: Color(0xFFF1F1F1),
              ),
            ),
          ),
        ),
        Positioned(
          top: 90.r,
          child: SizedBox(
            width: 220.r,
            height: 220.r,
            child: CustomPaint(painter: ProgressArcPainter(percentage)),
          ),
        ),
        Positioned(
          top: 150.r,
          child: SizedBox(
            width: 100.r,
            height: 100.r,
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 6,
                intensity: 0.6,
                shadowDarkColorEmboss: AppColors.shadowDark,
                shadowLightColorEmboss: AppColors.lightWhite,
                lightSource: LightSource.topLeft,
                color: Color(0xFFF1F1F1),
              ),
            ),
          ),
        ),
        Positioned(
          top: 163.r,
          child: SizedBox(
            width: 75.r,
            height: 75.r,
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 6,
                intensity: 0.6,
                shadowDarkColorEmboss: AppColors.shadowDark,
                shadowLightColorEmboss: AppColors.lightWhite,
                lightSource: LightSource.topLeft,
                color: Color(0xFFF1F1F1),
              ),
            ),
          ),
        ),
        Positioned(
          top: 100.r,
          child: SizedBox(
            width: 200.r,
            height: 200.r,
            child: CustomPaint(
              painter: PercentageTextPainter(percentage, context),
            ),
          ),
        ),
      ],
    );
  }
}
