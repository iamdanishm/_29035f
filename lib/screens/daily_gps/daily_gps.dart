// ignore_for_file: constant_identifier_names

import 'package:_29035f/providers/daily_gps/daily_gps_provider.dart';
import 'package:_29035f/routes/bottom_nav.dart';
import 'package:_29035f/screens/daily_gps/today_gps.dart';
import 'package:_29035f/screens/daily_gps/week_gps.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

enum Menu { Today, Yestarday }

final selectedMenuProvider = StateProvider<String>((ref) {
  return "Today";
});

class DailyGps extends ConsumerStatefulWidget {
  const DailyGps({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DailyGpsState();
}

class _DailyGpsState extends ConsumerState<DailyGps> {
  List tabs = ["Today", "Week", "Month"];
  PageController pageController = PageController(initialPage: 0);
  final selectedTabProvider = StateProvider<int>((ref) => 0);

  @override
  Widget build(BuildContext context) {
    final todayData = ref.watch(dailyGPSControllerNotifierProvider);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            HomeAppBar(
              scaffoldKey: scaffoldKey.currentState!,
              title: "Track Your Habit in Action",
              actionWidget: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NeumorphicButton(
                    style: NeumorphicStyle(
                      depth: 5,
                      intensity: 0.5,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(12.r),
                      ),
                      lightSource: LightSource.topLeft,
                      color: AppColors.lightWhite,
                      shadowLightColor: Colors.white,
                      shadowLightColorEmboss: AppColors.embossLight,
                    ),
                    padding: EdgeInsets.all(12.h),
                    child: Image.asset(
                      'assets/images/icons/settings2.png',
                      width: 22.h,
                      height: 22.h,
                      fit: BoxFit.contain,
                    ),
                    onPressed: () {
                      context.push("/dailysettings");
                    },
                  ),
                ],
              ),
            ),

            DailyTabs(
              tabs: tabs,
              ref: ref,
              selectedTabProvider: selectedTabProvider,
              pageController: pageController,
            ),

            Expanded(
              child: PageView(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  ref.read(selectedTabProvider.notifier).state = value;
                },
                children: [
                  todayData.when(
                    data: (data) => TodayGps(data: data),
                    error: (error, stackTrace) =>
                        Center(child: Text(error.toString())),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                  WeekGps(),
                  Center(child: Text(tabs[2])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyTabs extends StatelessWidget {
  const DailyTabs({
    super.key,
    required this.tabs,
    required this.ref,
    required this.selectedTabProvider,
    required this.pageController,
  });

  final List tabs;
  final WidgetRef ref;
  final StateProvider<int> selectedTabProvider;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 55.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(tabs.length, (index) {
          final selectedTab = ref.watch(selectedTabProvider);
          final isSelected = selectedTab == index;

          if (index == 0) {
            return Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  ref.read(selectedTabProvider.notifier).state = 0;
                  pageController.jumpToPage(0);
                },
                child: AnimatedContainer(
                  width: 120.w,
                  height: 40.h,
                  duration: Durations.short2,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 11.w),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFFFFBE6E) : Colors.white,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 4),
                            ),
                          ]
                        : [],
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          ref.watch(selectedMenuProvider),
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.textColor,
                              ),
                        ),
                      ),

                      Expanded(
                        child: PopupMenuButton<Menu>(
                          padding: EdgeInsets.zero,
                          menuPadding: EdgeInsets.zero,
                          offset: Offset(-75, 45.h),
                          constraints: BoxConstraints(minWidth: 90.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          color: AppColors.white,
                          icon: Image.asset(
                            "assets/images/icons/chevron-down.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                          onSelected: (value) {
                            ref.read(selectedMenuProvider.notifier).state =
                                value.name;
                            ref.read(selectedTabProvider.notifier).state = 0;
                            pageController.jumpToPage(0);
                          },
                          itemBuilder: (context) => Menu.values
                              .where(
                                (element) =>
                                    element.name !=
                                    ref.watch(selectedMenuProvider),
                              )
                              .map(
                                (e) => PopupMenuItem<Menu>(
                                  value: e,
                                  child: Text(
                                    e.name,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelLarge,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                ref.read(selectedTabProvider.notifier).state = index;
                pageController.jumpToPage(index);
              },
              child: AnimatedContainer(
                width: 110.w,
                height: 40.h,
                duration: Durations.short2,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 11.w),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFFFFBE6E) : Colors.white,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.shadowLight,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 4),
                          ),
                        ]
                      : [],
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Text(
                  tabs[index],
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: isSelected ? AppColors.white : AppColors.textColor,
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
