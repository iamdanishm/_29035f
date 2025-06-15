import 'package:_29035f/providers/subscription/subscription_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:_29035f/utils/widgets/neu_button.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

enum Currencies { inr, usd, nzd }

class Subscription extends ConsumerStatefulWidget {
  const Subscription({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SubscriptionState();
}

class _SubscriptionState extends ConsumerState<Subscription> {
  List plans = [
    {
      "id": 1,
      "type": "Pro Plan",
      "price": "0",
      "ispopular": false,
      "services": [
        "Habit Inventory profile",
        "Habit profile inventory dashboard",
        "29035f journal",
        "Knowledge Hub",
        "Wisdom Nudges",
      ],
    },
    {
      "id": 1,
      "type": "Plus Plan",
      "price": "49,999",
      "ispopular": true,
      "services": [
        "Habit Inventory profile",
        "North Start Aspiration",
        "Reflection Inventory",
        "Knowledge Hub",
        "Habit profile inventory dashboard",
        "Habit Inventory profile",
        "North Start Aspiration",
        "Reflection Inventory",
        "Knowledge Hub",
        "Habit profile inventory dashboard",
        "Habit Inventory profile",
        "North Start Aspiration",
        "Reflection Inventory",
        "Knowledge Hub",
        "Habit profile inventory dashboard",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10.h,
            children: [
              AppBarWidget(ref: ref),
              SizedBox(
                height: 600.h,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: plans.length,

                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: PlanCardWidget(plans: plans, index: index),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Have questions about our Pricing Plans? Reach out to us",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightTextColor,
                ),
              ),

              TextButton.icon(
                onPressed: () => launchUrl(
                  Uri(scheme: "mailto", path: "knowmore@29035f.co.nz"),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 20.h,
                  ),
                ),
                icon: Image.asset(
                  "assets/images/icons/mail.png",
                  width: 20.w,
                  height: 20.h,
                  fit: BoxFit.contain,
                ),
                label: Text("knowmore@29035f.co.nz"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanCardWidget extends ConsumerWidget {
  const PlanCardWidget({super.key, required this.plans, required this.index});

  final List plans;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final convertedPrice = ref.watch(
      convertedPriceProvider(plans[index]["price"]),
    );

    Color planColor = Color(0xFFA9DAE8);

    if (plans[index]["type"] == "Plus Plan") {
      planColor = Color(0xFFFE956F);
    }

    if (plans[index]["type"] == "Premium Plan") {
      planColor = Color(0xFF3B82F6);
    }

    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        border: NeumorphicBorder(color: Colors.white, width: 1),
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20.r)),
        depth: 8,
        intensity: 0.6,
        lightSource: LightSource.topLeft,
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 20.h,
          top: plans[index]["type"] == "Plus Plan" ? 0 : 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (plans[index]["type"] == "Plus Plan")
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 110.w,
                      height: 43.h,
                      decoration: BoxDecoration(
                        color: planColor,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10.r),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Popular",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                Row(
                  spacing: 25.h,
                  children: [
                    Container(
                      width: 7.w,
                      height: 43.h,
                      margin: EdgeInsets.only(top: 20.h),
                      decoration: BoxDecoration(
                        color: planColor,
                        borderRadius: BorderRadius.all(Radius.circular(2.r)),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plans[index]["type"],
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  fontSize: 22.spMin,
                                  color: AppColors.textColor,
                                ),
                          ),
                          Text(
                            "$convertedPrice Free to Use",
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  color: AppColors.textColor,
                                  fontSize: 25.spMin,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Divider(thickness: 1.h, endIndent: 5.w, indent: 5.w),
                ),

                SizedBox(
                  height: 0.4.sh,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...plans[index]["services"].map((e) {
                          return Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 20.h,
                              children: [
                                Icon(
                                  Icons.check_rounded,
                                  color: AppColors.lightTextColor,
                                ),
                                Expanded(
                                  child: Text(
                                    e,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.textColor),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            NeuButton(
              title: "Select Plan",
              onPressed: () {},
              height: 45.h,
              shadowLightColor: AppColors.shadowLight,
              color: Colors.white,
              titleColor: AppColors.textColor,
              width: 200.w,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(15.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return CommanAppBar(
      title: "Subscription Plans",
      actionWidget: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              border: NeumorphicBorder(color: Colors.white, width: 1),
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(12.r),
              ),
              depth: 2,
              intensity: 0.8,
              shadowLightColor: Colors.white,
              lightSource: LightSource.topLeft,
              color: AppColors.nueCardBg,
            ),
            padding: EdgeInsets.all(8.h),
            child: PopupMenuButton<Currencies>(
              offset: const Offset(8, 30),
              constraints: BoxConstraints(minWidth: 60.h),
              menuPadding: EdgeInsets.zero,
              child: Row(
                children: [
                  if (ref.watch(selectedCurrencyProvider) == "INR")
                    SizedBox(width: 5.h),
                  Text(
                    ref.watch(selectedCurrencyProvider),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 2.h),
                  Image.asset(
                    "assets/images/icons/arrow-down.png",
                    width: 20.h,
                  ),
                ],
              ),
              onSelected: (value) =>
                  ref.read(selectedCurrencyProvider.notifier).state = value.name
                      .toUpperCase(),
              itemBuilder: (context) {
                return <PopupMenuEntry<Currencies>>[
                  ...Currencies.values
                      .where(
                        (element) =>
                            element !=
                            Currencies.values.firstWhere(
                              (e) =>
                                  e.name.toUpperCase() ==
                                  ref.watch(selectedCurrencyProvider),
                            ),
                      )
                      .map(
                        (e) => PopupMenuItem<Currencies>(
                          textStyle: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: AppColors.textColor),
                          value: e,
                          child: Text(e.name.toUpperCase()),
                        ),
                      ),
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}
