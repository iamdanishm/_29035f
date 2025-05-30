import 'package:_29035f/providers/auth_provider/login_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/app_images.dart';
import 'package:_29035f/utils/widgets/neu_button.dart';
import 'package:_29035f/utils/widgets/neu_dialog.dart';
import 'package:_29035f/utils/widgets/neu_loading.dart';
import 'package:_29035f/utils/widgets/neu_text_field.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    listenLoginState();
  }

  void listenLoginState() {
    ref.listenManual<AsyncValue<void>>(loginProvider, (_, next) {
      if (next is AsyncError) {
        if (Navigator.of(context, rootNavigator: true).canPop()) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        showDialog(
          context: context,
          builder: (context) => NeuDialog(
            title: "Error",
            titleStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.errorColor,
            ),
            description: next.error.toString(),
          ),
        );
      }
      if (next is AsyncData<void> &&
          Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  goToRegister() => {
    FocusManager.instance.primaryFocus?.unfocus(),
    context.push('/register'),
  };

  loginFun(loginState) {
    FocusManager.instance.primaryFocus?.unfocus();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const NeuLoading(),
    );
    final email = ref.read(emailProvider);
    final password = ref.read(passwordProvider);
    ref.read(loginProvider.notifier).login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Welcome ~ Hare Mai!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 30),

                NeuTextField(
                  label: "Email or Phone Number",
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (text) =>
                      ref.read(emailProvider.notifier).state = text,
                  validator: (text) => null,
                ),
                const SizedBox(height: 25),

                NeuTextField(
                  label: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onChanged: (text) =>
                      ref.read(passwordProvider.notifier).state = text,
                  validator: (text) => null,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.lightTextColor,
                    ),
                    child: const Text("Forgot Password?"),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: NeuButton(
                    title: loginState.isLoading ? "Logging in..." : "Login",
                    shadowLightColor: AppColors.shadowLight,
                    color: AppColors.embossLight,
                    titleColor: AppColors.textColor,
                    height: 58,
                    width: double.infinity,
                    onPressed: loginState.isLoading
                        ? null
                        : () => loginFun(loginState),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => goToRegister(),
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
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(AppImages.logo, width: 200),
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(AppImages.logo2, width: 200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
