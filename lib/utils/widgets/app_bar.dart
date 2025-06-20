import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({
    super.key,
    required this.scaffoldKey,
    required this.title,
    this.actionWidget,
  });
  final ScaffoldState scaffoldKey;
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
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(10.r),
                ),
                lightSource: LightSource.topLeft,
                color: AppColors.lightWhite,
                shadowLightColor: Colors.white,
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
          SizedBox(
            width: 0.65.sw,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 20.spMin),
                  ),
                ),
                if (title == "Practical Labs" || title == "Shape your Journey")
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 5.0),
                    child: Badge(
                      backgroundColor: Color(0xFFF9817E),
                      smallSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          actionWidget ?? const SizedBox.shrink(),
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
                depth: 5,
                intensity: 0.5,
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(10.r),
                ),
                lightSource: LightSource.topLeft,
                color: AppColors.lightWhite,
                shadowLightColor: Colors.white,
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
          if (title == "29035 Journal")
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: "29035",
                    children: [
                      TextSpan(
                        text: "f ",
                        style: GoogleFonts.passionsConflict(
                          fontSize: 38.spMin,
                          fontWeight: FontWeight.w500,
                          height: 0.5,
                        ),
                      ),

                      TextSpan(
                        text: "Journal",
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(fontSize: 20.spMin),
                      ),
                    ],
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.spMin,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 5.0),
                  child: Badge(
                    backgroundColor: Color(0xFFF9817E),
                    smallSize: 12,
                  ),
                ),
              ],
            ),
          if (title != "29035 Journal")
            SizedBox(
              width: 200.w,
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontSize: 20.spMin),
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
