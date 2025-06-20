import 'package:_29035f/model/journal.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';

class JournalDetial extends ConsumerWidget {
  const JournalDetial({super.key, required this.data});
  final Journal data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              CommanAppBar(title: "29035 Journal"),
              SizedBox(
                width: 1.sw,
                child: Neumorphic(
                  style: NeumorphicStyle(
                    depth: 8,
                    intensity: 0.8,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(25.r),
                    ),
                    lightSource: LightSource.topLeft,
                    color: AppColors.nueCardBg,
                    shadowLightColor: Colors.white,
                    shadowDarkColor: AppColors.shadowLight,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 18.h,
                    horizontal: 20.w,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.h,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: CachedNetworkImage(
                          imageUrl: data.imageUrl,
                          height: 200.h,
                          width: 1.sw,
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.easeIn,
                          progressIndicatorBuilder: (context, url, progress) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10.h,
                            children: [
                              Icon(Icons.error, color: Colors.red, size: 40.sp),
                              Text("Failed to load image"),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        data.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 5.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/icons/clock.png",
                            width: 28.h,
                            height: 28.h,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            "6 mins Read, Published On ${DateFormat("d MMM yyyy").format(data.createdAt)}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      HtmlWidget(data.content),
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
