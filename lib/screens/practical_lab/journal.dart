import 'package:_29035f/model/journal.dart' as journaldarmodel;
import 'package:_29035f/providers/practical_lab/journal_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:_29035f/utils/widgets/journal_video.dart';
import 'package:_29035f/utils/widgets/neu_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Journal extends ConsumerStatefulWidget {
  const Journal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JournalState();
}

class _JournalState extends ConsumerState<Journal> {
  @override
  Widget build(BuildContext context) {
    final journal = ref.watch(journalProvider);
    final journalVideos = ref.watch(journalVideoProvider);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(isVideoPlayingProvider.notifier).state = false;
          ref.read(videoControllerProvider.notifier).disposeController();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    left: 20.w,
                    right: 20.w,
                    // bottom: 10.h,
                  ),
                  child: CommanAppBar(title: "29035 Journal"),
                ),
                journal.when(
                  data: (item) {
                    final data = item.data.first;
                    final popularList = item.data.sublist(1);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: JournalCard(data: data),
                        ),
                        SizedBox(height: 25.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10.h,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                "Popular Posts",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            SizedBox(
                              height: 230.h,
                              child: ListView.builder(
                                itemCount: popularList.length,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                itemBuilder: (context, index) {
                                  final item = popularList[index];
                                  return PostWidget(item: item);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => SizedBox(
                    height: 1.sh - 100.h,

                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Something went wrong, please try again',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                  ),
                  loading: () => SizedBox(
                    height: 1.sh - 100.h,
                    child: Center(child: NeuLoading()),
                  ),
                ),
                SizedBox(height: 15.h),

                journalVideos.when(
                  data: (data) {
                    final videoList = data.data.sublist(1);
                    return Column(
                      spacing: 25.h,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: JournalVideoCard(data: data.data.first),
                        ),

                        SizedBox(
                          height: 170.h,
                          child: ListView.builder(
                            itemCount: videoList.length,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemBuilder: (context, index) {
                              final item = videoList[index];
                              return SizedBox(
                                width: 150.w,
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    depth: 8,
                                    intensity: 0.8,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(15.r),
                                    ),
                                    lightSource: LightSource.topLeft,
                                    color: AppColors.nueCardBg,
                                    shadowLightColor: Colors.white,
                                    shadowDarkColor: AppColors.shadowLight,
                                  ),
                                  padding: EdgeInsets.all(12.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          5.r,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: item.photoUrl,
                                          height: 90.h,
                                          width: 1.sw,
                                          fit: BoxFit.cover,
                                          fadeInCurve: Curves.easeIn,
                                          progressIndicatorBuilder:
                                              (context, url, progress) {
                                                return Padding(
                                                  padding: EdgeInsets.all(10.w),
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          value:
                                                              progress.progress,
                                                        ),
                                                  ),
                                                );
                                              },
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                size: 40.sp,
                                              ),
                                        ),
                                      ),
                                      SizedBox(height: 5.h),

                                      Expanded(
                                        child: Text(
                                          item.title,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => SizedBox.shrink(),
                  loading: () => SizedBox.shrink(),
                ),
                SizedBox(height: 20.h),

                journal.when(
                  data: (item) {
                    final popularList = item.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10.h,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            "Latest Posts",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          height: 230.h,
                          child: ListView.builder(
                            itemCount: popularList.length,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemBuilder: (context, index) {
                              final item = popularList[index];
                              return PostWidget(item: item);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => SizedBox.shrink(),
                  loading: () => SizedBox.shrink(),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostWidget extends ConsumerWidget {
  const PostWidget({super.key, required this.item});
  final journaldarmodel.Journal item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 10, bottom: 15),
      child: SizedBox(
        width: 150.w,
        child: NeumorphicButton(
          onPressed: () {},
          style: NeumorphicStyle(
            depth: 8,
            intensity: 0.8,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15.r)),
            lightSource: LightSource.topLeft,
            color: AppColors.nueCardBg,
            shadowLightColor: Colors.white,
            shadowDarkColor: AppColors.shadowLight,
          ),
          padding: EdgeInsets.all(12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  height: 90.h,
                  width: 1.sw,
                  fit: BoxFit.cover,
                  fadeInCurve: Curves.easeIn,
                  progressIndicatorBuilder: (context, url, progress) {
                    return Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: Colors.red, size: 40.sp),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                item.category.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: 3.h),
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: Text(
                  item.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.lightTextColor,
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

class JournalCard extends StatelessWidget {
  const JournalCard({super.key, required this.data});

  final journaldarmodel.Journal data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: NeumorphicButton(
        onPressed: () {
          context.push("/journalDetial", extra: data);
        },
        style: NeumorphicStyle(
          depth: 8,
          intensity: 0.8,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25.r)),
          lightSource: LightSource.topLeft,
          color: AppColors.nueCardBg,
          shadowLightColor: Colors.white,
          shadowDarkColor: AppColors.shadowLight,
        ),
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
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
                    child: Center(child: CircularProgressIndicator.adaptive()),
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
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}
