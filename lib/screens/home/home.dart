import 'package:_29035f/providers/animation_provider/progress_notifier.dart';
import 'package:_29035f/routes/bottom_nav.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:_29035f/utils/widgets/custom_painter/step_ruler.dart';
import 'package:_29035f/utils/widgets/neu_circular_progress.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

final targetPercentageProvider = StateProvider<double>((ref) => 90);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List homeNav = [
    {
      "id": 1,
      "title": "Concepts",
      "description": "Understand the “why” and “how”",
      "icon": "assets/images/icons/concept.png",
      "route": "/concept",
    },
    {
      "id": 2,
      "title": "Subscription Plans",
      "description": "Choose a plan that fits you.",
      "icon": "assets/images/icons/subscription.png",
      "route": "/subscription",
    },
    {
      "id": 3,
      "title": "FAQs",
      "description": "Answers to your common questions.",
      "icon": "assets/images/icons/faq.png",
      "route": "/faqs",
    },
    {
      "id": 4,
      "title": "Contact and Help",
      "description": "Reach out for support or query.",
      "icon": "assets/images/icons/help.png",
      "route": "/contact",
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(progressProvider.notifier)
          .animateTo(ref.read(targetPercentageProvider));
    });
  }

  @override
  Widget build(BuildContext context) {
    final percentage = ref.watch(progressProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeAppBar(
              scaffoldKey: scaffoldKey.currentState!,
              title: "Welcome",
            ),
            HomeProgress(percentage: percentage),
            SizedBox(height: 20.h),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.h,
                childAspectRatio: 1.h,
              ),
              itemCount: homeNav.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = homeNav[index];
                return HomeNueCard(item: item);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeNueCard extends StatelessWidget {
  const HomeNueCard({super.key, required this.item});

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: () {
        context.push(item["route"]);
      },
      style: NeumorphicStyle(
        depth: 8,
        intensity: 0.6,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20.r)),
        lightSource: LightSource.bottomRight,
        color: AppColors.nueCardBg,
        shadowLightColor: AppColors.shadowLight,
        shadowDarkColor: AppColors.shadowLight,
        shadowLightColorEmboss: AppColors.embossLight,
        shadowDarkColorEmboss: AppColors.embossLight,
      ),
      padding: EdgeInsets.all(10.w),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            margin: EdgeInsets.only(left: 5.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFDBEEF5),
            ),
            child: Image.asset(
              item["icon"],
              height: 30.h,
              width: 30.w,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            item["title"],
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 3.h),
          Text(
            item["description"],
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: AppColors.lightTextColor),
          ),
        ],
      ),
    );
  }
}

class HomeProgress extends StatelessWidget {
  const HomeProgress({super.key, required this.percentage});

  final double percentage;

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
        color: AppColors.nueCardBg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 330.h,
            child: NeuCircularProgress(percentage: percentage),
          ),
          Text(
            "Realm Deviation",
            style: Theme.of(context).textTheme.titleLarge,
          ),

          SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 40.w,
            children: [
              Row(
                spacing: 8.w,
                children: [
                  Container(
                    height: 16.h,
                    width: 16.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFC5DAE9),
                      shape: BoxShape.circle,
                    ),
                  ),

                  Text(
                    "Work",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 8.w,
                children: [
                  Container(
                    height: 16.h,
                    width: 16.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF81B5DC),
                      shape: BoxShape.circle,
                    ),
                  ),

                  Text(
                    "Life",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 8.w,
                children: [
                  Container(
                    height: 16.h,
                    width: 16.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF4E97CE),
                      shape: BoxShape.circle,
                    ),
                  ),

                  Text(
                    "Soul",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: 40.h, bottom: 30.h),
            child: SizedBox(
              height: 80.h,
              width: double.infinity,
              child: CustomPaint(
                painter: StepRulerPainter(
                  totalSteps: 8,
                  activeSteps: [0, 2],
                  spacing: 10.w,
                  context: context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
