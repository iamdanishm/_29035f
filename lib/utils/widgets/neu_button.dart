import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NeuButton extends ConsumerWidget {
  const NeuButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.shadowLightColor,
    required this.color,
    required this.titleColor,
  });
  final String title;
  final Function()? onPressed;
  final double width;
  final double height;
  final Color shadowLightColor;
  final Color color;
  final Color titleColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      height: height,
      child: NeumorphicButton(
        onPressed: onPressed,
        style: NeumorphicStyle(
          depth: 6,
          shape: NeumorphicShape.flat,
          intensity: 0.6,
          shadowLightColor: shadowLightColor,
          color: color,
          lightSource: LightSource.topLeft,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: titleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
