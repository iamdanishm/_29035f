import 'package:_29035f/model/concept.dart';
import 'package:_29035f/providers/concept/concept_provider.dart';
import 'package:_29035f/providers/read_more_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:_29035f/utils/widgets/neu_expandable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Concept extends ConsumerStatefulWidget {
  const Concept({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConceptState();
}

class _ConceptState extends ConsumerState<Concept> {
  final isShowProvider = StateProvider<bool>((ref) => false);
  final isSelectedProvider = StateProvider<String>((ref) => '');
  final isReadMoreProvider = StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<ConceptItem>> conceptsAsync = ref.watch(
      paginatedConceptProvider,
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              CommanAppBar(title: "Concept"),
              SizedBox(height: 15.h),
              NeuSearchBar(),
              SizedBox(height: 10.h),

              conceptsAsync.when(
                data: (conceptItems) {
                  if (conceptItems.isEmpty) {
                    return SizedBox(
                      height: 1.sh - 250.h,
                      child: Center(
                        child: Text(
                          'No concepts found',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: conceptItems.length,
                    itemBuilder: (context, index) {
                      final conceptItem = conceptItems[index];
                      return Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: ConceptTile(
                          conceptItem: conceptItem,
                          index: index,
                          isShowProvider: isShowProvider,
                          isReadMoreProvider: isReadMoreProvider,
                          isSelectedProvider: isSelectedProvider,
                        ),
                      );
                    },
                  );
                },
                loading: () => SizedBox(
                  height: 1.sh - 250.h,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => SizedBox(
                  height: 1.sh - 250.h,
                  child: Center(child: Text('Error: $error')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final isReadMoreProvider = StateProvider<bool>((ref) => false);

class ConceptTile extends ConsumerWidget {
  final ConceptItem conceptItem;
  final int index;
  final StateProvider<bool> isShowProvider;
  final StateProvider<bool> isReadMoreProvider;
  final StateProvider<String> isSelectedProvider;

  const ConceptTile({
    super.key,
    required this.conceptItem,
    required this.index,
    required this.isShowProvider,
    required this.isReadMoreProvider,
    required this.isSelectedProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(isSelectedProvider);
    final isShow = ref.watch(isShowProvider);
    final isReadMore = ref.watch(isReadMoreProvider);
    final isExpanded = selected == index.toString() && isShow;
    final shouldShowReadMore = ref.watch(
      readMoreProvider(conceptItem.description),
    );
    // final shouldShowReadMore = shouldShowReadMore(context, conceptItem.title);

    return NeuExpandable(
      title: Text(
        conceptItem.description,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      expandedChild: Column(
        children: [
          if (conceptItem.image != "")
            Padding(
              padding: EdgeInsets.only(bottom: 15.h, top: 10.h),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(10.r)),

                child: CachedNetworkImage(
                  imageUrl: conceptItem.image,
                  width: 1.sw,
                  fit: BoxFit.cover,
                  fadeInCurve: Curves.easeIn,
                  progressIndicatorBuilder: (context, url, progress) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

          Text(
            conceptItem.description,
            maxLines: isReadMore ? 5000 : 4,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(color: AppColors.shadowDark),
          ),
          if (!isReadMore && shouldShowReadMore)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: 110.w,
                  child: NeumorphicButton(
                    onPressed: () {
                      ref.read(isReadMoreProvider.notifier).state = true;
                    },
                    style: NeumorphicStyle(
                      depth: 6,
                      shape: NeumorphicShape.flat,
                      intensity: 0.6,
                      shadowLightColor: AppColors.shadowLight,
                      color: Color(0xFFB8E8F5),
                      lightSource: LightSource.topLeft,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(50.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Read More",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      isExpanded: isExpanded,
      onPressed: () {
        final notifierShow = ref.read(isShowProvider.notifier);
        final notifierSelected = ref.read(isSelectedProvider.notifier);

        if (selected == index.toString()) {
          notifierShow.state = !isShow;
        } else {
          notifierSelected.state = index.toString();
          notifierShow.state = true;
        }
        ref.read(isReadMoreProvider.notifier).state = false;
      },
    );
  }
}

class NeuSearchBar extends ConsumerWidget {
  const NeuSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -8,
        intensity: 0.7,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12.r)),
        lightSource: LightSource.topLeft,
        color: Colors.white,
        shadowLightColor: AppColors.shadowLight,
        shadowLightColorEmboss: Colors.white,
      ),
      child: TextField(
        keyboardType: TextInputType.name,
        onChanged: (text) {},
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 5.w),
            child: Image.asset(
              "assets/images/icons/search.png",
              width: 30.w,
              height: 30.h,
              fit: BoxFit.contain,
            ),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 30.w),
          hintText: "Search keywords",
          hintStyle: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppColors.shadowDark),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 15.h,
          ),
        ),
      ),
    );
  }
}
