import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeuExpandable extends StatelessWidget {
  final Widget title;
  final Widget expandedChild;
  final bool isExpanded;
  final VoidCallback onPressed;
  final Duration animationDuration;

  const NeuExpandable({
    super.key,
    required this.title,
    required this.expandedChild,
    required this.isExpanded,
    required this.onPressed,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        depth: 6,
        intensity: 0.5,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15.r)),
        lightSource: LightSource.topLeft,
        color: Colors.white,
        shadowLightColor: AppColors.shadowLight,
        shadowLightColorEmboss: AppColors.embossLight,
      ),
      onPressed: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title row with expand icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: title),
              AnimatedContainer(
                duration: animationDuration,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                  color: isExpanded
                      ? AppColors.shadowLight
                      : AppColors.lightWhite,
                ),
                child: Icon(
                  isExpanded ? Icons.remove : Icons.add,
                  color: AppColors.shadowDark,
                ),
              ),
            ],
          ),

          /// Expandable content
          AnimatedSize(
            duration: animationDuration,
            curve: Curves.easeInOut,
            child: ConstrainedBox(
              constraints: isExpanded
                  ? const BoxConstraints()
                  : const BoxConstraints(maxHeight: 0),
              child: expandedChild,
            ),
          ),
        ],
      ),
    );
  }
}
