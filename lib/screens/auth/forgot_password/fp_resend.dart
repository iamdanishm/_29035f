import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/neu_back_btn.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FPResend extends ConsumerWidget {
  const FPResend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeuBackBtn(),
              SizedBox(height: 40),
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
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
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
              SizedBox(height: 40),
              Image.asset('assets/images/illustrations/email.png'),
              SizedBox(height: 40),
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
