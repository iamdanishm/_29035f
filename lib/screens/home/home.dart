import 'package:_29035f/providers/animation_provider/progress_notifier.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/custom_painter/step_ruler.dart';
import 'package:_29035f/utils/widgets/neu_circular_progress.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final targetPercentageProvider = StateProvider<double>((ref) => 90);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
      // appBar: AppBar(
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 30),
      //     child: NeuBackBtn(),
      //   ),
      //   leadingWidth: 80.w,
      //   centerTitle: true,
      //   title: Text('Home'),
      //   forceMaterialTransparency: true,
      //   clipBehavior: Clip.none,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 520.h,
                child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(24.r),
                    ),
                    depth: 6.r.clamp(2, 6),
                    intensity: 0.6,
                    shadowLightColor: AppColors.lightWhite,
                    lightSource: LightSource.topLeft,
                    color: Color(0xFFF2F3F6),
                  ),
                  child: Column(
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
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
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
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
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
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),

                      SizedBox(
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
                    ],
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
