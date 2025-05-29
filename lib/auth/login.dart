import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/app_images.dart';
import 'package:_29035f/utils/widgets/neu_button.dart';
import 'package:_29035f/utils/widgets/neu_text_field.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: Text(
                  'Welcome ~ Hare Mai!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ),

              // Email or Phone number
              NeuTextField(
                label: "Email or Phone Number",
                keyboardType: TextInputType.emailAddress,
                onChanged: (text) {},
                validator: (text) {
                  return null;
                },
              ),

              SizedBox(height: 25),

              // Password
              NeuTextField(
                label: "Password",
                keyboardType: TextInputType.visiblePassword,
                onChanged: (text) {},
                validator: (text) {
                  return null;
                },
              ),

              // Forgot Password btn
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.lightTextColor,
                  ),
                  child: Text("Forgot Password?"),
                ),
              ),

              // Login Btn
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: NeuButton(
                  title: "Login",
                  onPressed: () {},
                  height: 58,
                  width: double.infinity,
                ),
              ),

              // Create Account btn
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.lightTextColor,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Create Account',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: AppColors.lightPink),
                        ),
                      ],
                      text: 'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: AppColors.lightTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Image.asset(AppImages.logo, width: 200),
              ),
              SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: Image.asset(AppImages.logo2, width: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
