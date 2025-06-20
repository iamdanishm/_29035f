import 'package:_29035f/routes/bottom_nav.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PracticalLab extends ConsumerStatefulWidget {
  const PracticalLab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PracticalLabState();
}

class _PracticalLabState extends ConsumerState<PracticalLab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(
                scaffoldKey: scaffoldKey.currentState!,
                title: "Practical Labs",
              ),
              Wrap(
                runAlignment: WrapAlignment.spaceEvenly,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 20.h,
                spacing: 20.h,
                children: practicalLabsNav.map((item) {
                  final index = practicalLabsNav.indexOf(item);
                  return PracticalLabCard(item: item, index: index);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PracticalLabCard extends ConsumerWidget {
  const PracticalLabCard({super.key, required this.item, required this.index});
  final Map item;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 160.w,
      child: NeumorphicButton(
        onPressed: () {
          context.push(item["route"]);
        },
        style: NeumorphicStyle(
          depth: 8,
          intensity: 0.6,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20.r)),
          lightSource: LightSource.topLeft,
          color: AppColors.nueCardBg,
          shadowLightColor: Colors.white,
          shadowDarkColor: AppColors.shadowLight,
        ),
        padding: EdgeInsets.all(10.h),
        child: SizedBox(
          height: 150.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(10.h),
                margin: EdgeInsets.only(left: 5.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE9E3D7),
                ),
                child: Image.asset(
                  item["icon"],
                  height: 24.h,
                  width: 24.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 8.h),
              if (index == 2)
                RichText(
                  text: TextSpan(
                    text: item['title'].toString().split(" ")[0],
                    children: [
                      TextSpan(
                        text: "f ",
                        style: GoogleFonts.passionsConflict(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          height: 0.5,
                        ),
                      ),

                      TextSpan(
                        text: item['title'].toString().split(" ")[1],
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
              if (index != 2)
                Text(
                  item['title'].toString(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 3.h),
              Expanded(
                child: Text(
                  item["description"],
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.lightTextColor,
                    fontSize: 8.spMin,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final practicalLabsNav = [
  {
    "id": 1,
    "title": "North Star Alignment",
    "description":
        "The Subtle Art of Dharma” by Gurcharan Das is a non-fiction book that explores the concepts of...",
    "icon": "assets/images/icons/star.png",
    "route": "/north",
  },
  {
    "id": 2,
    "title": "Gurukul Coaching",
    "description":
        "Let your coach handpick the practices and interventions that suit your journey. ",
    "icon": "assets/images/icons/usersGroup.png",
    "route": "/gurukul",
  },
  {
    "id": 3,
    "title": "29035 Journal",
    "description":
        "A rich library of insights from books, podcasts, and trending reflections on values like Dharma, Self, Leadership, and Mindfulness.",
    "icon": "assets/images/icons/document.png",
    "route": "/journal",
  },
  {
    "id": 4,
    "title": "Knowledge Hub",
    "description":
        "Explore curated courses across Life, Work, and Soul to deepen your awareness and potential.",
    "icon": "assets/images/icons/playbackSpeed.png",
    "route": "/knowledge",
  },
  {
    "id": 5,
    "title": "Habit in Action Compendium",
    "description":
        "Understand the deeper meaning and execution of every habit. A practical guide to bring your behavioural shifts to life.",
    "icon": "assets/images/icons/blackHole.png",
    "route": "/habit",
  },
];
