import 'package:_29035f/screens/compass_nav/compass_nav.dart';
import 'package:_29035f/screens/home/home.dart';
import 'package:_29035f/screens/practical_lab/practical_lab.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

final bottomSelectedProvider = StateProvider<int>((ref) => 0);
final scaffoldKey = GlobalKey<ScaffoldState>();

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
  List bottomNavWidget = [
    SafeArea(child: HomeScreen()),
    SafeArea(child: CompassNavigator()),
    SafeArea(child: Center(child: Text("Mission Control"))),
    SafeArea(child: Center(child: Text("Daily GPS"))),
    SafeArea(child: PracticalLab()),
  ];

  List bottomNavList = [
    {"id": 1, "icon": "assets/images/bottom_nav/home.png", "label": "29035F"},
    {
      "id": 2,
      "icon": "assets/images/bottom_nav/compass.png",
      "label": "Compass Navigator",
    },
    {
      "id": 3,
      "icon": "assets/images/bottom_nav/mission.png",
      "label": "Mission Control",
    },
    {"id": 4, "icon": "assets/images/bottom_nav/gps.png", "label": "Daily GPS"},
    {
      "id": 5,
      "icon": "assets/images/bottom_nav/lab.png",
      "label": "Practice Labs",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: MyDrawer(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20.r),
            right: Radius.circular(20.r),
          ),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 0,
          children: List.generate(
            bottomNavList.length,
            (index) => Flexible(
              fit: FlexFit.tight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                       
                      ],
                    ),
                    child: IconButton(
                      color: AppColors.errorColor,
                      icon: Image.asset(
                        bottomNavList[index]["icon"].toString(),
                        width: 26.h,
                        height: 26.h,
                        fit: BoxFit.contain,
                        color: ref.watch(bottomSelectedProvider) == index
                            ? AppColors.secondaryColor
                            : null,
                      ),
                      style: IconButton.styleFrom(
                        elevation: ref.watch(bottomSelectedProvider) == index
                            ? 8
                            : 0,
                        shadowColor: AppColors.accentColor,
                        backgroundColor: AppColors.embossLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () {
                        ref
                            .read(bottomSelectedProvider.notifier)
                            .update((state) => index);
                      },
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    bottomNavList[index]["label"].toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: ref.watch(bottomSelectedProvider) == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: bottomNavWidget[ref.watch(bottomSelectedProvider)],
    );
  }
}

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      elevation: 10,
      shadowColor: AppColors.shadowLight,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  "Aditi Soni",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 5.h),
                Text(
                  "aditisoni240298@gmail.com",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5.h,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    context.push("/profile");
                    scaffoldKey.currentState!.closeDrawer();
                  },
                  leading: Image.asset(
                    "assets/images/icons/user.png",
                    width: 30.w,
                    height: 30.h,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    "Profile",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {},
                  leading: Image.asset(
                    "assets/images/icons/settings.png",
                    width: 30.w,
                    height: 30.h,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    "Change Password",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    ref.read(bottomSelectedProvider.notifier).state = 0;
                    scaffoldKey.currentState!.closeDrawer();
                  },
                  leading: Image.asset(
                    "assets/images/bottom_nav/home.png",
                    width: 30.w,
                    height: 30.h,
                    fit: BoxFit.contain,
                    color: Color(0xFF5FB3CC),
                  ),
                  title: Text(
                    "29035F",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    ref.read(bottomSelectedProvider.notifier).state = 1;
                    scaffoldKey.currentState!.closeDrawer();
                  },
                  leading: Image.asset(
                    "assets/images/bottom_nav/compass.png",
                    width: 30.w,
                    height: 30.h,
                    color: Color(0xFF5FB3CC),
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    "Compass Navigator",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    ref.read(bottomSelectedProvider.notifier).state = 2;
                    scaffoldKey.currentState!.closeDrawer();
                  },
                  leading: Image.asset(
                    "assets/images/bottom_nav/mission.png",
                    width: 30.w,
                    height: 30.h,
                    color: Color(0xFF5FB3CC),
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    "Mission Control",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    ref.read(bottomSelectedProvider.notifier).state = 3;
                    scaffoldKey.currentState!.closeDrawer();
                  },
                  leading: Image.asset(
                    "assets/images/bottom_nav/gps.png",
                    width: 30.w,
                    height: 30.h,
                    color: Color(0xFF5FB3CC),
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    "Daily GPS",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    ref.read(bottomSelectedProvider.notifier).state = 4;
                    scaffoldKey.currentState!.closeDrawer();
                  },
                  leading: Image.asset(
                    "assets/images/bottom_nav/lab.png",
                    width: 30.w,
                    height: 30.h,
                    color: Color(0xFF5FB3CC),
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    "Practice Labs",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {},
                  leading: Image.asset(
                    "assets/images/icons/logout.png",
                    width: 30.w,
                    height: 30.h,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    "Logout",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
