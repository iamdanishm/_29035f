import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/neu_button.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NeuDialog extends ConsumerWidget {
  const NeuDialog({
    super.key,
    required this.title,
    required this.titleStyle,
    required this.description,
    this.buttonText,
    this.buttonTextColor,
    this.onPressed,
  });
  final String title;
  final TextStyle? titleStyle;
  final String description;
  final String? buttonText;
  final Color? buttonTextColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
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
              Text(title, style: titleStyle),
              const SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 16),
              Visibility(
                visible: buttonText != null,
                replacement: const SizedBox(),
                child: NeuButton(
                  title: buttonText ?? '',
                  shadowLightColor: AppColors.shadowLight,
                  color: AppColors.embossLight,
                  titleColor: buttonTextColor ?? AppColors.textColor,
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: 50,
                  onPressed: onPressed ?? () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
