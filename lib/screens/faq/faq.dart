import 'package:_29035f/model/faq.dart';
import 'package:_29035f/providers/debounce_provider.dart';
import 'package:_29035f/providers/faq/faq_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:_29035f/utils/widgets/neu_expandable.dart';
import 'package:_29035f/utils/widgets/neu_loading.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Faq extends ConsumerStatefulWidget {
  const Faq({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FaqState();
}

class _FaqState extends ConsumerState<Faq> {
  final isShowProvider = StateProvider<bool>((ref) => false);
  final isSelectedProvider = StateProvider<String>((ref) => '');
  final isReadMoreProvider = StateProvider<bool>((ref) => false);

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    final query = ref.read(faqSearchQueryProvider);
    if (query.isEmpty &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 300) {
      ref.read(paginatedFaqProvider.notifier).fetchFaqs();
    }
  }

  Future onRefresh() async {
    ref.read(faqSearchQueryProvider.notifier).state = '';
    ref.read(faqTextControllerProvider).clear();

    final notifier = ref.refresh(paginatedFaqProvider.notifier);

    if (!ref.context.mounted) return;

    await notifier.fetchFaqs();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<FaqItem>> faqAsync = ref.watch(paginatedFaqProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    CommanAppBar(title: "FAQs"),
                    SizedBox(height: 15.h),
                    NeuSearchBar(),
                  ],
                ),
              ),

              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: onRefresh,
                  child: faqAsync.when(
                    data: (faqItems) {
                      return CustomScrollView(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.h,
                              vertical: 10.h,
                            ),
                            sliver: faqItems.isEmpty
                                ? SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: Center(
                                      child: Text(
                                        'No FAQs found',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineMedium,
                                      ),
                                    ),
                                  )
                                : SliverList(
                                    delegate: SliverChildBuilderDelegate((
                                      context,
                                      index,
                                    ) {
                                      final faqItem = faqItems[index];
                                      return Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: FaqTile(
                                          faqItem: faqItem,
                                          index: index,
                                          isShowProvider: isShowProvider,
                                          isSelectedProvider:
                                              isSelectedProvider,
                                          isReadMoreProvider:
                                              isReadMoreProvider,
                                        ),
                                      );
                                    }, childCount: faqItems.length),
                                  ),
                          ),
                        ],
                      );
                    },
                    loading: () => CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(child: NeuLoading()),
                        ),
                      ],
                    ),
                    error: (error, stack) => CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              'Error: $error',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
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

class FaqTile extends ConsumerWidget {
  final FaqItem faqItem;
  final int index;
  final StateProvider<bool> isShowProvider;
  final StateProvider<bool> isReadMoreProvider;
  final StateProvider<String> isSelectedProvider;

  const FaqTile({
    super.key,
    required this.faqItem,
    required this.index,
    required this.isShowProvider,
    required this.isSelectedProvider,
    required this.isReadMoreProvider,
  });

  bool shouldShowReadMore(BuildContext context, String text) {
    final TextSpan span = TextSpan(
      text: text,
      style: Theme.of(
        context,
      ).textTheme.labelLarge!.copyWith(color: AppColors.shadowDark),
    );

    final TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      maxLines: 4,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 60);

    return tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(isSelectedProvider);
    final isShow = ref.watch(isShowProvider);
    final isReadMore = ref.watch(isReadMoreProvider);
    final isExpanded = selected == index.toString() && isShow;
    final isShowReadMore = shouldShowReadMore(context, faqItem.answer);

    return NeuExpandable(
      title: Text(
        faqItem.question,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      expandedChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: AppColors.shadowLight),
          Text(
            faqItem.answer,
            maxLines: isReadMore ? 5000 : 4,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(color: AppColors.shadowDark),
          ),
          if (!isReadMore && isShowReadMore)
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
          SizedBox(height: 10.h),
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
    final debouncer = ref.read(
      debouncerProvider(const Duration(milliseconds: 500)),
    );
    final controller = ref.watch(faqTextControllerProvider);

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
        controller: controller,
        keyboardType: TextInputType.name,
        onChanged: (text) {
          debouncer.run(() {
            ref.read(faqSearchQueryProvider.notifier).state = text.trim();
          });
        },
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
