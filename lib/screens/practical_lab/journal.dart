import 'package:_29035f/model/journal.dart' as journaldarmodel;
import 'package:_29035f/providers/practical_lab/journal_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:_29035f/utils/widgets/neu_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

// TODO: WORKING ON THIS

class Journal extends ConsumerStatefulWidget {
  const Journal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JournalState();
}

class _JournalState extends ConsumerState<Journal> {
  final popularList = [
    {
      "id": 1,
      "title": "The Subtle Art of Dharma” by Gurcharan Das",
      "author": "Gurcharan Das",
      "description":
          "The Subtle Art of Dharma” by Gurcharan Das is a non-fiction book that explores the concepts of Dharma, Self, Leadership, and Mindfulness.",
      "image":
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
    },
    {
      "id": 2,
      "title": "The 7 Habits of Highly Effective People",
      "author": "Zig Ziglar",
      "description":
          "The 7 Habits of Highly Effective People is a self-help book that provides advice on how to improve personal and professional relationships.",
      "image":
          'https://images.unsplash.com/photo-1518806118471-f28b20d1d079?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2071&q=80',
    },
    {
      "id": 3,
      "title": "The Power of Now",
      "author": "Eckhart Tolle",
      "description":
          "The Power of Now is a spiritual self-help book that emphasizes the importance of living in the present moment.",
      "image":
          'https://images.unsplash.com/photo-1525130413817-d45c1d127c42?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
    },
    {
      "id": 4,
      "title":
          "Daring Greatly: How the Courage to Be Vulnerable Transforms the Way We Live, Love, Parent, and Lead",
      "author": "Daring Greatly",
      "description":
          "Daring Greatly is a self-help book that explores the importance of vulnerability in personal and professional relationships.",
      "image":
          'https://images.unsplash.com/photo-1551445697-3a5f7f5cb3e7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
    },
    {
      "id": 5,
      "title": "The Alchemist",
      "author": "Paulo Coelho",
      "description":
          "The Alchemist is a novel that explores the themes of spirituality, self-discovery, and personal growth.",
      "image":
          'https://images.unsplash.com/photo-1523906834653-8fcf6c53f2a1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final journal = ref.watch(journalProvider);
    return Scaffold(
      body: SafeArea(
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
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
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
                        SizedBox(height: 15.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10.h,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                "Videos",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              error: (error, stackTrace) => Expanded(
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
              loading: () => Expanded(child: Center(child: NeuLoading())),
            ),
          ],
        ),
      ),
    );
  }
}

class PostWidget extends ConsumerWidget {
  const PostWidget({super.key, required this.item});
  final Map item;

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
                  imageUrl: item['image'].toString(),
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
                item['author'].toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: 3.h),
              Text(
                item['title'].toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: Text(
                  item['description'].toString(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall,
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
        onPressed: () {},
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
