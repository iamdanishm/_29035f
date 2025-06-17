import 'package:_29035f/providers/animation_provider/progress_notifier.dart';
import 'package:_29035f/routes/bottom_nav.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:_29035f/utils/widgets/custom_painter/progress_arc.dart';
import 'package:_29035f/utils/widgets/custom_painter/progress_text.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

final compassPercentageProvider = StateProvider<double>((ref) => 70.0);

class CompassNavigator extends ConsumerStatefulWidget {
  const CompassNavigator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompassNavigatorState();
}

class _CompassNavigatorState extends ConsumerState<CompassNavigator> {
  List compassNav = [
    {
      "id": 1,
      "title": "North Star",
      "description":
          "Define your aspirations, beliefs, achievements, values, and war cry.",
      "icon": "assets/images/icons/star.png",
      "route": "/north_star",
      "is_open": false,
    },
    {
      "id": 2,
      "title": "360° Insights",
      "description": "Comprehensive view via self assessment and peer feedback",
      "icon": "assets/images/icons/360_insights.png",
      "route": "/360_insights",
      "is_open": false,
    },
    {
      "id": 3,
      "title": "Reflection  Inventory",
      "description": "Explore your inner patterns with realm-wise reflections.",
      "icon": "assets/images/icons/reflection.png",
      "route": "/reflection_inventory",
      "is_open": false,
    },
    {
      "id": 4,
      "title": "Habit Profile Inventory",
      "description":
          "Define your aspirations, beliefs, achievements, values, and war cry.",
      "icon": "assets/images/icons/habit.png",
      "route": "/habit_profile",
      "is_open": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(compassProgressProvider.notifier)
          .animateTo(ref.read(compassPercentageProvider));
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(compassProgressProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            HomeAppBar(
              scaffoldKey: scaffoldKey.currentState!,
              title: "Shape your Journey",
            ),

            SizedBox(
              height: 205.h,
              child: NeuCircularProgress(percentage: progress),
            ),

            SizedBox(height: 20.h),

            Wrap(
              runAlignment: WrapAlignment.spaceEvenly,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: 20.h,
              spacing: 20.h,
              children: compassNav.map((item) {
                return CompassCardWidget(item: item);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CompassCardWidget extends ConsumerWidget {
  const CompassCardWidget({super.key, required this.item});

  final dynamic item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 160.w,
      child: Stack(
        children: [
          NeumorphicButton(
            onPressed: () {
              context.push(item["route"]);
            },
            style: NeumorphicStyle(
              depth: 8,
              intensity: 0.6,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(20.r),
              ),
              lightSource: LightSource.topLeft,
              color: AppColors.nueCardBg,
              shadowLightColor: Colors.white,
              shadowDarkColor: AppColors.shadowLight,
            ),
            padding: EdgeInsets.all(10.h),
            child: SizedBox(
              height: 150.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.h),
                    margin: EdgeInsets.only(left: 5.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE9E3D7),
                    ),
                    child: Image.asset(
                      item["icon"],
                      height: 30.h,
                      width: 30.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item["title"],
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Expanded(
                    child: Text(
                      item["description"],
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.lightTextColor,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (item['is_open'] == true)
            Positioned(
              top: 0,
              right: 15.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Color(0xFF6E7B91),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(6.r),
                  ),
                ),
                child: Text(
                  "Open",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class NeuCircularProgress extends ConsumerWidget {
  const NeuCircularProgress({super.key, required this.percentage});
  final double percentage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: 205.h,
          height: 205.h,
          child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
              depth: 5,
              intensity: 0.8,
              shadowLightColor: AppColors.primaryColor,
              shadowDarkColor: AppColors.shadowDark,
              lightSource: LightSource.topLeft,
              color: Color(0xFFF1F1F1),
            ),
          ),
        ),
        SizedBox(
          width: 160.h,
          height: 160.h,
          child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
              depth: -5,
              intensity: 0.6,
              shadowDarkColorEmboss: AppColors.shadowDark,
              shadowLightColorEmboss: AppColors.lightWhite,
              lightSource: LightSource.topLeft,
              color: Color(0xFFF1F1F1),
            ),
          ),
        ),

        SizedBox(
          width: 71.h,
          height: 71.h,
          child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
              depth: 2,
              intensity: 0.5,
              shadowDarkColorEmboss: AppColors.shadowDark,
              shadowLightColorEmboss: AppColors.lightWhite,
              lightSource: LightSource.topLeft,
              color: Color(0xFFF1F1F1),
            ),
          ),
        ),

        SizedBox(
          width: 56.h,
          height: 56.h,
          child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
              depth: 6,
              intensity: 0.6,
              shadowDarkColorEmboss: AppColors.shadowDark,
              shadowLightColorEmboss: AppColors.lightWhite,
              lightSource: LightSource.topLeft,
              color: Color(0xFFF1F1F1),
            ),
          ),
        ),

        SizedBox(
          width: 35.h,
          height: 35.h,
          child: Column(
            children: [
              Image.asset(
                "assets/images/icons/progress.png",
                width: 20.h,
                height: 20.h,
              ),
              SizedBox(height: 5.h),
              CustomPaint(
                painter: CustomTextPainter(
                  text: "Progress",
                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 10,
                    color: AppColors.lightTextColor,
                  ),
                  context: context,
                ),
              ),
            ],
          ),
        ),

        CustomPaint(
          size: Size(155.h, 155.h),
          painter: ProgressArcPainter(
            percentage: percentage,
            strokeCap: StrokeCap.round,
            strokeWidth: 40.h,
            color: Color(0xFFE7E3DC),
          ),
        ),

        Positioned(
          top: 130.h,
          child: CustomPaint(
            size: Size(50.h, 50.h),
            painter: PercentageTextPainter(percentage, context),
          ),
        ),
      ],
    );
  }
}
