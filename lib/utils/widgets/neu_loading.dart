import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NeuLoading extends ConsumerWidget {
  const NeuLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: SizedBox(
          width: 150,
          child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
              depth: 6,
              intensity: 0.6,
              shadowLightColor: AppColors.shadowLight,
              lightSource: LightSource.topLeft,
              color: AppColors.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                  const SizedBox(height: 16),
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
