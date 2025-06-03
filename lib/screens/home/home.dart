import 'package:_29035f/providers/animation_provider/progress_notifier.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/neu_circular_progress.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final targetPercentageProvider = StateProvider<double>((ref) => 40);

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
                height: 400.r,
                child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(24.r),
                    ),
                    depth: 6,
                    intensity: 0.6,
                    shadowLightColor: AppColors.lightWhite,
                    lightSource: LightSource.topLeft,
                    color: Color(0xFFF2F3F6),
                  ),
                  child: NeuCircularProgress(percentage: percentage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
