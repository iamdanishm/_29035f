import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/neu_back_btn.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FPResend extends ConsumerWidget {
  const FPResend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeuBackBtn(),
              SizedBox(height: 40.h),
              Center(
                child: Text(
                  'Forgot Password?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: Center(
                  child: Text(
                    'We have sent a reset password link to your email account',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.lightTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Image.asset(
                'assets/images/illustrations/email.png',
                height: 150.h,
                width: 150.w,
              ),
              SizedBox(height: 40.h),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () => (),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.lightTextColor,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Resend Link',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.copyWith(color: Colors.blue),
                        ),
                      ],
                      text: 'Don\'t receive the link? ',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: AppColors.lightTextColor,
                      ),
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
