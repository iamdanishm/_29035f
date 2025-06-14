import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key, required this.scaffoldKey, required this.title});
  final ScaffoldState scaffoldKey;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: NeumorphicButton(
              style: NeumorphicStyle(
                depth: 6,
                intensity: 0.5,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(15.r),
                ),
                lightSource: LightSource.topLeft,
                color: AppColors.lightWhite,
                shadowLightColor: AppColors.shadowLight,
                shadowLightColorEmboss: AppColors.embossLight,
              ),
              padding: EdgeInsets.all(12.h),
              child: Image.asset(
                'assets/images/icons/menu.png',
                width: 22.h,
                height: 22.h,
                fit: BoxFit.contain,
              ),
              onPressed: () {
                scaffoldKey.openDrawer();
              },
            ),
          ),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}

class CommanAppBar extends ConsumerWidget {
  const CommanAppBar({super.key, required this.title, this.actionWidget});
  final String title;
  final Widget? actionWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: NeumorphicButton(
              style: NeumorphicStyle(
                depth: 6,
                intensity: 0.5,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(15.r),
                ),
                lightSource: LightSource.topLeft,
                color: AppColors.lightWhite,
                // color: AppColors.lightWhite,
                shadowLightColor: AppColors.shadowLight,
                shadowLightColorEmboss: AppColors.embossLight,
              ),
              padding: EdgeInsets.all(12.h),
              child: Image.asset(
                'assets/images/icons/back-arrow.png',
                width: 22.h,
                height: 22.h,
                fit: BoxFit.contain,
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          SizedBox(
            width: 200.w,
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.textColor,
                fontSize: 20.spMin,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          actionWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
