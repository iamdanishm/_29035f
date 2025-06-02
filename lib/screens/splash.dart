import 'dart:math';

import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    final image = ref.watch(splashImageProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Center(
          child: SizedBox(
            height: height * 0.75,
            width: width,
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(45),
                ),
                depth: 6,
                intensity: 0.6,
                shadowLightColor: AppColors.shadowLight,
                lightSource: LightSource.topLeft,
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
