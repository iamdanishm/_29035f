import 'package:_29035f/model/concept.dart';
import 'package:_29035f/providers/concept/concept_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
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
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<ConceptItem>> conceptsAsync = ref.watch(
      conceptListProvider,
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
                        key: ValueKey("$index ${conceptItem.isExpanded}"),
                        padding: EdgeInsets.only(top: 20.h),
                        child: ConceptTile(
                          conceptItem: conceptItem,
                          index: index,
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

  const ConceptTile({
    super.key,
    required this.conceptItem,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        title: Text(
          conceptItem.header,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
            color: conceptItem.isExpanded
                ? AppColors.shadowLight
                : AppColors.lightWhite,
          ),
          child: Icon(
            conceptItem.isExpanded ? Icons.remove : Icons.add,
            color: AppColors.shadowDark,
          ),
        ),
        initiallyExpanded: conceptItem.isExpanded,
        onExpansionChanged: (value) {
          ref.read(isReadMoreProvider.notifier).state = false;
          ref.read(conceptListProvider.notifier).togglePanel(index, value);
        },
        children: [
          Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              children: [
                if (conceptItem.image != "")
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(10.r),
                      ),

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
                  conceptItem.body,
                  maxLines: ref.watch(isReadMoreProvider) ? 5000 : 5,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: AppColors.shadowDark),
                ),
                if (!ref.watch(isReadMoreProvider))
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
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(
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
          ),
        ],
      ),
    );
  }
}

class NeuSearchBar extends ConsumerWidget {
  const NeuSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -6,
        intensity: 0.6,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12.r)),
        lightSource: LightSource.topLeft,
        color: AppColors.lightWhite,
        shadowLightColor: AppColors.shadowLight,
        shadowLightColorEmboss: AppColors.embossLight,
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
