import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeuLoading extends ConsumerWidget {
  const NeuLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: SizedBox(
          width: 150.w,
          child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(15.r),
              ),
              depth: 6,
              intensity: 0.6,
              shadowLightColor: AppColors.shadowLight,
              lightSource: LightSource.topLeft,
              color: AppColors.primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Loading...",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.textColor,
                    ),
                    strokeCap: StrokeCap.round,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
