import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/neu_checkbox.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List weekList = List.generate(7, (index) {
  return {
    "id": index + 1,
    'week': ['S', 'M', 'T', 'W', 'TH', 'F', 'S'][index],
    "isCheck": index.isEven,
  };
});

final List<double> percentages = [0.75, 0.45, 0.65, 0.78, 0.6, 0.4, 0.42];

class WeekGps extends ConsumerWidget {
  const WeekGps({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TrackWidget(),

          SizedBox(height: 20.h),

          BarChartWidget(),
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
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              spacing: 10.w,
              children: [
                Container(
                  height: 50.h,
                  width: 50.w,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightWhite,
                  ),
                  child: Image.asset(
                    'assets/images/icons/dashboard.png',
                    fit: BoxFit.contain,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dashboard",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      "Dive into all Habit Analytics",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.lightTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: 5,
          intensity: 0.5,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16.r)),
          lightSource: LightSource.topLeft,
          color: AppColors.white,
          shadowLightColor: Colors.white,
          shadowLightColorEmboss: AppColors.embossLight,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            spacing: 30.h,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: 5,
                      intensity: 0.5,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.circle(),
                      lightSource: LightSource.topLeft,
                      color: AppColors.white,
                      shadowLightColor: Colors.white,
                      shadowLightColorEmboss: AppColors.embossLight,
                    ),
                    padding: EdgeInsets.all(8.w),
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 24.h,
                      color: AppColors.lightTextColor,
                    ),
                  ),
                  Text(
                    "12 May 2025 - 18 May 2025",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: 5,
                      intensity: 0.5,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.circle(),
                      lightSource: LightSource.topLeft,
                      color: AppColors.white,
                      shadowLightColor: Colors.white,
                      shadowLightColorEmboss: AppColors.embossLight,
                    ),
                    padding: EdgeInsets.all(8.w),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 24.h,
                      color: AppColors.lightTextColor,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    maxY: 1.0,
                    groupsSpace: 20.w,
                    alignment: BarChartAlignment.start,
                    barTouchData: BarTouchData(enabled: false),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 0.25,
                          getTitlesWidget: (value, _) => Text(
                            '${(value * 100).toInt()}%',
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(color: AppColors.lightTextColor),
                          ),
                          reservedSize: 50,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            const days = [
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat',
                              'Sun',
                            ];
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                days[value.toInt()],
                                style: Theme.of(context).textTheme.labelSmall!
                                    .copyWith(color: AppColors.lightTextColor),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(7, (index) {
                      final value = percentages[index];
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: value,
                            width: 18,
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0xFFFFBE6E), Color(0xFFFFE88B)],
                            ),
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: 1.0,
                              color: AppColors.embossLight,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrackWidget extends StatelessWidget {
  const TrackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      style: NeumorphicStyle(
        depth: 5,
        intensity: 0.5,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16.r)),
        lightSource: LightSource.topLeft,
        color: AppColors.white,
        shadowLightColor: Colors.white,
        shadowLightColorEmboss: AppColors.embossLight,
      ),
      child: Column(
        spacing: 10.h,
        children: [
          // Top
          Padding(
            padding: EdgeInsets.only(top: 12.h, left: 12.h, right: 12.h),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 10.w,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 45.h,
                      width: 45.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.lightWhite,
                      ),
                    ),

                    SizedBox(
                      width: 200.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Drinking water',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            'Target 2000ml / day',
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: AppColors.lightTextColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 30.h,
                  width: 30.w,
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFBE6E),
                  ),
                  child: Image.asset(
                    'assets/images/icons/week_star.png',

                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),

          // Bottom
          Container(
            color: Color(0xFFF4F7F9),
            padding: EdgeInsets.only(
              top: 6.h,
              bottom: 12.h,
              left: 12.h,
              right: 12.h,
            ),

            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: weekList
                  .map(
                    (e) => Column(
                      spacing: 5.h,
                      children: [
                        NeuCheckbox(
                          value: e['isCheck'],
                          iconSize: 10.h,
                          style: NeumorphicCheckboxStyle(
                            boxShape: NeumorphicBoxShape.circle(),
                            selectedColor: Color(0xFFFFBE6E),
                            selectedDepth: 0,
                            unselectedDepth: 0,
                          ),
                          onChanged: (_) {},
                        ),
                        Text(
                          e['week'],
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: AppColors.lightTextColor),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
