import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Contact extends ConsumerStatefulWidget {
  const Contact({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactState();
}

class _ContactState extends ConsumerState<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              CommanAppBar(title: "Get In Touch"),
              Text(
                "Have questions about our Blueprint?",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightTextColor,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.w),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.r)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icons/mail.png",
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "knowmore@29035f.co.nz",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 0.23.sw, child: Divider(thickness: 1)),
                  Text(
                    "Or Fill the Form",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.lightTextColor,
                    ),
                  ),
                  SizedBox(width: 0.23.sw, child: Divider(thickness: 1)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
