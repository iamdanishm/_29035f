import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyGpsSetting extends ConsumerStatefulWidget {
  const DailyGpsSetting({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DailyGpsSettingState();
}

class _DailyGpsSettingState extends ConsumerState<DailyGpsSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CommanAppBar(title: "Settings"),
              Neumorphic(
                style: NeumorphicStyle(
                  depth: 5,
                  intensity: 0.5,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(16.r),
                  ),
                  lightSource: LightSource.topLeft,
                  color: AppColors.white,
                  shadowLightColor: Colors.white,
                  shadowLightColorEmboss: AppColors.embossLight,
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: Row(
                        spacing: 10.w,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 45.h,
                            width: 45.h,
                            padding: EdgeInsets.all(12.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightWhite,
                            ),
                            child: Image.asset("assets/images/icons/bell.png"),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Make notifications sticky",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "Prevents notifications from being swiped away.",
                                  style: Theme.of(context).textTheme.labelSmall!
                                      .copyWith(
                                        color: AppColors.lightTextColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    AdvancedSwitch(
                      activeColor: Color(0xFFFFBE6E),
                      height: 25.h,
                      width: 43.h,
                      thumb: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      onChanged: (value) {},
                      inactiveColor: Color(0xFFEAECF0),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15.h),
              Neumorphic(
                style: NeumorphicStyle(
                  depth: 5,
                  intensity: 0.5,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(16.r),
                  ),
                  lightSource: LightSource.topLeft,
                  color: AppColors.white,
                  shadowLightColor: Colors.white,
                  shadowLightColorEmboss: AppColors.embossLight,
                ),
                padding: const EdgeInsets.all(15),

                child: Column(
                  spacing: 15.h,
                  children: [
                    Row(
                      spacing: 10.w,
                      children: [
                        Container(
                          height: 45.h,
                          width: 45.h,
                          padding: EdgeInsets.all(12.h),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.lightWhite,
                          ),
                          child: Image.asset("assets/images/icons/sun.png"),
                        ),
                        Text(
                          "Make notifications sticky",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 5.w,
                      children: [
                        Expanded(
                          child: Text(
                            "Send notifications at morning 8 AM only",
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(color: AppColors.lightTextColor),
                          ),
                        ),

                        AdvancedSwitch(
                          activeColor: Color(0xFFFFBE6E),
                          height: 25.h,
                          width: 43.h,
                          thumb: Container(
                            margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadowLight,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                          onChanged: (value) {},
                          inactiveColor: Color(0xFFEAECF0),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 5.w,
                      children: [
                        Expanded(
                          child: Text(
                            "Send notifications at late evening 8 PM only",
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(color: AppColors.lightTextColor),
                          ),
                        ),

                        AdvancedSwitch(
                          activeColor: Color(0xFFFFBE6E),
                          height: 25.h,
                          width: 43.h,
                          thumb: Container(
                            margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadowLight,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                          onChanged: (value) {},
                          inactiveColor: Color(0xFFEAECF0),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 5.w,
                      children: [
                        Expanded(
                          child: Text(
                            "Send notifications at regular intervals throughout the day.",
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(color: AppColors.lightTextColor),
                          ),
                        ),

                        AdvancedSwitch(
                          activeColor: Color(0xFFFFBE6E),
                          height: 25.h,
                          width: 43.h,
                          thumb: Container(
                            margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadowLight,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                          onChanged: (value) {},
                          inactiveColor: Color(0xFFEAECF0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              Neumorphic(
                style: NeumorphicStyle(
                  depth: 5,
                  intensity: 0.5,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(16.r),
                  ),
                  lightSource: LightSource.topLeft,
                  color: AppColors.white,
                  shadowLightColor: Colors.white,
                  shadowLightColorEmboss: AppColors.embossLight,
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: Row(
                        spacing: 10.w,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 45.h,
                            width: 45.h,
                            padding: EdgeInsets.all(12.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightWhite,
                            ),
                            child: Image.asset("assets/images/icons/time.png"),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Make notifications sticky",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "Wait until 3:00 AM to show a new day. Useful if you typically go to sleep after midnight. Requires app restart.",
                                  style: Theme.of(context).textTheme.labelSmall!
                                      .copyWith(
                                        color: AppColors.lightTextColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    AdvancedSwitch(
                      activeColor: Color(0xFFFFBE6E),
                      height: 25.h,
                      width: 43.h,
                      thumb: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      onChanged: (value) {},
                      inactiveColor: Color(0xFFEAECF0),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15.h),

              Neumorphic(
                style: NeumorphicStyle(
                  depth: 5,
                  intensity: 0.5,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(16.r),
                  ),
                  lightSource: LightSource.topLeft,
                  color: AppColors.white,
                  shadowLightColor: Colors.white,
                  shadowLightColorEmboss: AppColors.embossLight,
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: Row(
                        spacing: 10.w,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 45.h,
                            width: 45.h,
                            padding: EdgeInsets.all(12.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightWhite,
                            ),
                            child: Image.asset(
                              "assets/images/icons/stopwatch.png",
                            ),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Make notifications sticky",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "Toggle twice to add a skip instead of a checkmark. Skips keep your score unchanged and don’t break your streak.",
                                  style: Theme.of(context).textTheme.labelSmall!
                                      .copyWith(
                                        color: AppColors.lightTextColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    AdvancedSwitch(
                      activeColor: Color(0xFFFFBE6E),
                      height: 25.h,
                      width: 43.h,
                      thumb: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      onChanged: (value) {},
                      inactiveColor: Color(0xFFEAECF0),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15.h),

              Neumorphic(
                style: NeumorphicStyle(
                  depth: 5,
                  intensity: 0.5,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(16.r),
                  ),
                  lightSource: LightSource.topLeft,
                  color: AppColors.white,
                  shadowLightColor: Colors.white,
                  shadowLightColorEmboss: AppColors.embossLight,
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: Row(
                        spacing: 10.w,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 45.h,
                            width: 45.h,
                            padding: EdgeInsets.all(12.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightWhite,
                            ),
                            child: Image.asset("assets/images/icons/faq.png"),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Make notifications sticky",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "Differentiate days without data from actual lapses. To enter a lapse, toggle twice.",
                                  style: Theme.of(context).textTheme.labelSmall!
                                      .copyWith(
                                        color: AppColors.lightTextColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    AdvancedSwitch(
                      activeColor: Color(0xFFFFBE6E),
                      height: 25.h,
                      width: 43.h,
                      thumb: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      onChanged: (value) {},
                      inactiveColor: Color(0xFFEAECF0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
