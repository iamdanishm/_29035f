import 'package:_29035f/providers/animation_provider/progress_notifier.dart';
import 'package:_29035f/routes/bottom_nav.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:_29035f/utils/widgets/custom_painter/step_ruler.dart';
import 'package:_29035f/utils/widgets/neu_circular_progress.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final missionTargetProvider = StateProvider<double>((ref) {
  return 50.0;
});

class MissionControl extends ConsumerStatefulWidget {
  const MissionControl({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MissionControlState();
}

class _MissionControlState extends ConsumerState<MissionControl> {
  List missionNav = [
    {
      "id": 1,
      "title": "Habit Profile Inventory",
      "icon": "assets/images/icons/habit.png",
    },
    {
      "id": 2,
      "title": "360 Degree Insights",
      "icon": "assets/images/icons/360_insights.png",
    },
    {
      "id": 3,
      "title": "29 Reflection Inventory",
      "icon": "assets/images/icons/reflection.png",
    },
    {"id": 4, "title": "Daily GPS", "icon": "assets/images/icons/dailygps.png"},
    {"id": 5, "title": "North Star", "icon": "assets/images/icons/star.png"},
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(missionControlProvider.notifier)
          .animateTo(ref.read(missionTargetProvider));
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(missionControlProvider);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeAppBar(
              scaffoldKey: scaffoldKey.currentState!,
              title: "Mission Control",
            ),

            MissionProgressWidget(progress: progress),

            SizedBox(height: 20.h),

            Wrap(
              runAlignment: WrapAlignment.spaceEvenly,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: 20.h,
              spacing: 20.h,
              children: missionNav
                  .map((item) => MissionCard(item: item))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class MissionCard extends ConsumerWidget {
  const MissionCard({super.key, required this.item});

  final Map item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 160.w,
      child: NeumorphicButton(
        onPressed: () {},
        style: NeumorphicStyle(
          depth: 8,
          intensity: 0.6,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15.r)),
          lightSource: LightSource.topLeft,
          color: AppColors.nueCardBg,
          shadowLightColor: Colors.white,
          shadowDarkColor: AppColors.shadowLight,
        ),
        padding: EdgeInsets.all(10.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              margin: EdgeInsets.only(left: 5.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE3D6DD),
              ),
              child: Image.asset(
                item["icon"],
                height: 24.h,
                width: 24.w,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Text(
                item["title"],
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MissionProgressWidget extends StatelessWidget {
  const MissionProgressWidget({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(24.r)),
        depth: 8,
        intensity: 0.6,
        shadowLightColor: AppColors.shadowLight,
        shadowDarkColor: AppColors.shadowLight,
        shadowLightColorEmboss: AppColors.embossLight,
        shadowDarkColorEmboss: AppColors.embossLight,
        color: Color(0xFFF2F3F6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 330.h,
            child: NeuCircularProgress(percentage: progress),
          ),
          Text(
            "Realm Deviation",
            style: Theme.of(context).textTheme.titleLarge,
          ),

          SizedBox(height: 5.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Work ~ ", style: Theme.of(context).textTheme.bodyMedium),
              Text("Life ~ ", style: Theme.of(context).textTheme.bodyMedium),
              Text("Soul", style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: CustomPaint(
              size: Size(double.infinity, 25.h),
              painter: StepRulerPainter(
                totalSteps: 8,
                activeSteps: [0, 2],
                spacing: 10.w,
                context: context,
                circle: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
