import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NeuButton extends ConsumerWidget {
  const NeuButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.width,
    required this.height,
  });
  final String title;
  final Function() onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      height: height,
      child: NeumorphicButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(15),
        style: NeumorphicStyle(
          depth: 6,
          shape: NeumorphicShape.flat,
          intensity: 0.6,
          shadowLightColor: AppColors.shadowLight,
          lightSource: LightSource.topLeft,
          color: AppColors.embossLight,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
