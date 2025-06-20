import 'package:_29035f/model/daily_gps_today.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/neu_button.dart';
import 'package:_29035f/utils/widgets/neu_checkbox.dart';
import 'package:_29035f/utils/widgets/neu_text_field.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

final targetCheckProvider = StateProvider<int>((ref) {
  // 0 means nothing, 1 means checked, 2 means not checked
  return 0;
});

final targetTextProvider = StateProvider<String>((ref) => '');

class TodayGps extends ConsumerWidget {
  const TodayGps({super.key, required this.data});
  final DailyGpsTodayModal data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: data.data.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Neumorphic(
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
          style: NeumorphicStyle(
            depth: 5,
            intensity: 0.5,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12.r)),
            lightSource: LightSource.topLeft,
            color: AppColors.white,
            shadowLightColor: Colors.white,
            shadowLightColorEmboss: AppColors.embossLight,
          ),
          padding: EdgeInsets.all(12.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 5.w,
                children: [
                  Container(
                    height: 45.h,
                    width: 45.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightWhite,
                    ),
                  ),

                  /* ClipRRect(
                    borderRadius:
                        BorderRadiusGeometry.circular(50.r),
                    child: CachedNetworkImage(
                      imageUrl: data.data[index].image,
                      height: 45.h,
                      width: 45.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child:
                            const CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ), */
                  SizedBox(
                    width: 200.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.data[index].title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          data.data[index].subtitle,
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: AppColors.lightTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              NeuCheckbox(
                value: data.data[index].isCheck,
                unselectedColor: Colors.transparent,
                style: NeumorphicCheckboxStyle(
                  unselectedDepth: 0,
                  unselectedIntensity: 0,
                  border: NeumorphicBorder(
                    color: data.data[index].isCheck
                        ? AppColors.white
                        : AppColors.lightTextColor,
                    width: 1,
                  ),
                  selectedColor: Color(0xFFFFBE6E),
                  boxShape: NeumorphicBoxShape.circle(),
                  selectedDepth: 2,
                  disabledColor: AppColors.shadowLight,
                ),
                onChanged: (value) {
                  if (data.data[index].isCheck) return;
                  showDialog(
                    context: context,
                    builder: (context) => TargetDialog(data: data.data[index]),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class TargetDialog extends ConsumerWidget {
  const TargetDialog({super.key, required this.data});
  final DailyGpsTodayData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCheck = ref.watch(targetCheckProvider);
    final inputText = ref.watch(targetTextProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(targetCheckProvider.notifier).state = 0;
          ref.read(targetTextProvider.notifier).state = '';
        }
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: SizedBox(
            width: 1.sw,
            child: SingleChildScrollView(
              child: Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(15.r),
                  ),
                  depth: 6,
                  intensity: 0.6,
                  shadowLightColor: AppColors.shadowLight,
                  lightSource: LightSource.topLeft,
                  color: AppColors.primaryColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        data.subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 20.h),

                      Text(
                        "Did you complete the task today?",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),

                      SizedBox(height: 10.h),

                      Row(
                        spacing: 50.w,
                        children: [
                          Row(
                            spacing: 5.w,
                            children: [
                              NeuCheckbox(
                                value: isCheck == 1,
                                iconSize: 15.h,
                                unselectedColor: Colors.transparent,
                                style: NeumorphicCheckboxStyle(
                                  unselectedDepth: 0,
                                  unselectedIntensity: 0,
                                  border: NeumorphicBorder(
                                    width: 1,
                                    color: isCheck == 1
                                        ? AppColors.white
                                        : AppColors.lightTextColor,
                                  ),
                                  selectedColor: Color(0xFFFFBE6E),
                                  boxShape: NeumorphicBoxShape.circle(),
                                  selectedDepth: 2,
                                  disabledColor: AppColors.shadowLight,
                                ),
                                onChanged: (value) {
                                  ref
                                      .read(targetCheckProvider.notifier)
                                      .update((state) => 1);
                                },
                              ),
                              Text(
                                "YES",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                          Row(
                            spacing: 5.w,
                            children: [
                              NeuCheckbox(
                                value: isCheck == 2,
                                iconSize: 15.h,
                                unselectedColor: Colors.transparent,
                                style: NeumorphicCheckboxStyle(
                                  unselectedDepth: 0,
                                  unselectedIntensity: 0,
                                  border: NeumorphicBorder(
                                    width: 1,
                                    color: isCheck == 2
                                        ? AppColors.white
                                        : AppColors.lightTextColor,
                                  ),
                                  selectedColor: Color(0xFFFFBE6E),
                                  boxShape: NeumorphicBoxShape.circle(),
                                  selectedDepth: 2,
                                  disabledColor: AppColors.shadowLight,
                                ),
                                onChanged: (value) {
                                  ref
                                      .read(targetCheckProvider.notifier)
                                      .update((state) => 2);
                                },
                              ),
                              Text(
                                "NO",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 30.h),

                      NeuTextField(
                        label: "Target Steps Achieved",
                        hintText: "Enter",
                        labelColor: AppColors.textColor,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          ref.read(targetTextProvider.notifier).state = text;
                        },
                        validator: (text) => null,
                      ),

                      SizedBox(height: 50.h),

                      NeuButton(
                        title: "Submit",
                        onPressed: (isCheck == 0 || inputText.isEmpty)
                            ? null
                            : () {
                                context.pop();
                                ref
                                    .read(targetCheckProvider.notifier)
                                    .update((state) => 0);

                                ref.read(targetTextProvider.notifier).state =
                                    '';
                              },
                        height: 50.h,
                        shadowLightColor: AppColors.shadowLight,
                        color: Color(0xFFFFBE6E),
                        titleColor: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
