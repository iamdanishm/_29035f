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
          top: 50.h,
          child: CustomPaint(
            size: Size(300.w, 300.h),
            painter: DottedRingPainter(),
          ),
        ),

        Positioned(
          top: 75.h,
          child: SizedBox(
            width: 250.w,
            height: 250.h,
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
          top: 100.h,
          child: SizedBox(
            width: 200.w,
            height: 200.h,
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
          top: 100.h,
          child: CustomPaint(
            size: Size(200.w, 200.h),
            painter: ProgressArcPainter(percentage),
          ),
        ),
        Positioned(
          top: 150.h,
          child: SizedBox(
            width: 100.w,
            height: 100.h,
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
          top: 163.h,
          child: SizedBox(
            width: 75.w,
            height: 75.h,
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
          top: 100.h,
          child: CustomPaint(
            size: Size(200.w, 200.h),
            painter: PercentageTextPainter(percentage, context),
          ),
        ),
      ],
    );
  }
}
