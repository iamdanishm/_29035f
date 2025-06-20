import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NeuBackBtn extends ConsumerWidget {
  const NeuBackBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        depth: 6,
        intensity: 0.5,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15.r)),
        lightSource: LightSource.topLeft,
        color: AppColors.lightWhite,
        shadowLightColor: AppColors.shadowLight,
        shadowLightColorEmboss: AppColors.embossLight,
      ),
      padding: EdgeInsets.all(12.w),
      child: Image.asset(
        'assets/images/icons/back-arrow.png',
        width: 26.w,
        fit: BoxFit.contain,
      ),
      onPressed: () {
        context.pop();
      },
    );
  }
}
