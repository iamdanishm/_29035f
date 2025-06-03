import 'package:_29035f/routes/router.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/text_theme.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          routerConfig: router,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundColor,
            textTheme: googleTextTheme,
          ),
        );
      },
    );
  }
}
