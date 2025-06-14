import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class NeuCheckbox extends StatelessWidget {
  final bool value;
  final NeumorphicCheckboxStyle style;
  final NeumorphicCheckboxListener onChanged;
  final bool isEnabled;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Duration duration;
  final Curve curve;

  const NeuCheckbox({
    super.key,
    this.style = const NeumorphicCheckboxStyle(
      border: NeumorphicBorder(color: Colors.white, width: 1),
    ),
    required this.value,
    required this.onChanged,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.padding = const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
    this.margin = const EdgeInsets.all(5.0),
    this.isEnabled = true,
  });

  bool get isSelected => value;

  void _onClick() {
    onChanged(!value);
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    final selectedColor = style.selectedColor ?? theme.accentColor;

    final double selectedDepth = 1 * (style.selectedDepth ?? theme.depth).abs();
    final double unselectedDepth =
        -1 * (style.unselectedDepth ?? theme.depth).abs();
    final double selectedIntensity =
        (style.selectedIntensity ?? theme.intensity).abs().clamp(
          Neumorphic.MIN_INTENSITY,
          Neumorphic.MAX_INTENSITY,
        );
    final double unselectedIntensity = style.unselectedIntensity.clamp(
      Neumorphic.MIN_INTENSITY,
      Neumorphic.MAX_INTENSITY,
    );

    double depth = isSelected ? selectedDepth : unselectedDepth;
    if (!isEnabled) {
      depth = 0;
    }

    Color? color = isSelected ? selectedColor : null;
    if (!isEnabled) {
      color = null;
    }

    Color iconColor = isSelected ? theme.baseColor : selectedColor;
    if (!isEnabled) {
      iconColor = theme.disabledColor;
    }

    return NeumorphicButton(
      padding: padding,
      pressed: isSelected,
      margin: margin,
      duration: duration,
      curve: curve,
      onPressed: () {
        if (isEnabled) {
          _onClick();
        }
      },
      drawSurfaceAboveChild: true,
      minDistance: selectedDepth.abs(),
      style: NeumorphicStyle(
        boxShape: style.boxShape,
        border: style.border,
        color: color,
        depth: depth,
        lightSource: style.lightSource ?? theme.lightSource,
        disableDepth: style.disableDepth,
        intensity: isSelected ? selectedIntensity : unselectedIntensity,
        shape: NeumorphicShape.flat,
      ),
      child: isSelected
          ? Icon(Icons.check, color: iconColor, size: 20.0)
          : SizedBox(width: 20.0, height: 20.0),
    );
  }
}
