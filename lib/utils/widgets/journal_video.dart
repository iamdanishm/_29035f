import 'package:_29035f/model/journal_videos.dart';
import 'package:_29035f/providers/practical_lab/journal_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class JournalVideoCard extends ConsumerStatefulWidget {
  const JournalVideoCard({super.key, required this.data});

  final JournalVideoData data;

  @override
  ConsumerState<JournalVideoCard> createState() => _JournalVideoCardState();
}

class _JournalVideoCardState extends ConsumerState<JournalVideoCard> {
  @override
  Widget build(BuildContext context) {
    final isVideoPlaying = ref.watch(isVideoPlayingProvider);
    return SizedBox(
      width: 1.sw,
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: 8,
          intensity: 0.8,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25.r)),
          lightSource: LightSource.topLeft,
          color: AppColors.nueCardBg,
          shadowLightColor: Colors.white,
          shadowDarkColor: AppColors.shadowLight,
        ),
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.h,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: isVideoPlaying
                  ? Consumer(
                      builder: (context, ref, _) {
                        final videoState = ref.watch(videoControllerProvider);
                        return videoState.when(
                          data: (controller) {
                            if (controller == null) return SizedBox();
                            return AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              child: VideoPlayer(controller),
                            );
                          },
                          loading: () => SizedBox(
                            height: 200.h,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          error: (e, _) => SizedBox(
                            height: 200.h,
                            child: Center(child: Text('Error loading video')),
                          ),
                        );
                      },
                    )
                  : CachedNetworkImage(
                      imageUrl: widget.data.photoUrl,
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
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 40.sp),
                          Text("Failed to load image"),
                        ],
                      ),
                    ),
            ),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5.h,
                    children: [
                      Text(
                        widget.data.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Published On ${DateFormat("d MMM yyyy").format(widget.data.createdAt)}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

                NeumorphicButton(
                  padding: EdgeInsets.all(6.h),
                  style: NeumorphicStyle(
                    depth: 6,
                    intensity: 0.5,
                    boxShape: NeumorphicBoxShape.circle(),
                    lightSource: LightSource.topLeft,
                    color: Color(0xFFF9817E),
                    shadowLightColor: AppColors.shadowLight,
                    shadowLightColorEmboss: AppColors.embossLight,
                  ),
                  child: Icon(
                    isVideoPlaying ? Icons.pause_sharp : Icons.play_arrow_sharp,
                    size: 30.sp,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (isVideoPlaying) {
                      ref.read(isVideoPlayingProvider.notifier).state = false;
                      ref
                          .read(videoControllerProvider.notifier)
                          .disposeController();
                    } else {
                      ref.read(isVideoPlayingProvider.notifier).state = true;
                      await ref
                          .read(videoControllerProvider.notifier)
                          .initialize(widget.data.videoUrl);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
