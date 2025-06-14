import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeuButton extends ConsumerWidget {
  const NeuButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width,
    required this.height,
    required this.shadowLightColor,
    required this.color,
    required this.titleColor,
    this.boxShape,
  });
  final String title;
  final Function()? onPressed;
  final double? width;
  final double height;
  final Color shadowLightColor;
  final Color color;
  final Color titleColor;
  final NeumorphicBoxShape? boxShape;

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
          boxShape:
              boxShape ??
              NeumorphicBoxShape.roundRect(BorderRadius.circular(50.r)),
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
