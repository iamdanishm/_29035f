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
          top: 70.h,
          child: CustomPaint(
            size: Size(200.w, 200.h),
            painter: DottedRingPainter(),
          ),
        ),

        Positioned(
          top: 65.h,
          child: SizedBox(
            width: 205.w,
            height: 205.h,
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
          top: 88.h,
          child: SizedBox(
            width: 160.w,
            height: 160.h,
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
          top: 85.h,
          child: CustomPaint(
            size: Size(165.w, 165.h),
            painter: ProgressArcPainter(percentage),
          ),
        ),
        Positioned(
          top: 122.h,
          child: SizedBox(
            width: 90.w,
            height: 90.h,
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
          top: 131.h,
          child: SizedBox(
            width: 72.w,
            height: 72.h,
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
          top: 142.h,
          child: CustomPaint(
            size: Size(50.w, 50.h),
            painter: PercentageTextPainter(percentage, context),
          ),
        ),
      ],
    );
  }
}
