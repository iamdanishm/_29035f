import 'dart:math';

import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

const baseUrl = "assets/images/splash_illustration";

final splashImages = [
  "$baseUrl/mountain.png",
  "$baseUrl/always.png",
  "$baseUrl/breathe.png",
  "$baseUrl/destined.png",
  "$baseUrl/impossible.png",
  "$baseUrl/life.png",
  "$baseUrl/limit.png",
];

final splashImageProvider = Provider.autoDispose<String>((ref) {
  final random = Random();
  return splashImages[random.nextInt(splashImages.length)];
});

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (mounted) {
        context.go('/bottom_nav');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final image = ref.watch(splashImageProvider);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(35.w),
        child: Center(
          child: SizedBox(
            height: 0.75.sh,
            width: 1.sw,
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(45.r),
                ),
                depth: 6,
                intensity: 0.6,
                shadowLightColor: AppColors.shadowLight,
                lightSource: LightSource.topLeft,
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(50.w),
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ).animate().fadeIn(duration: 2.seconds),
          ),
        ),
      ),
    );
  }
}
