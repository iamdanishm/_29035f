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
  bool _isListenerAttached = false;
  AsyncValue<void>? _previousLoginState;
  bool _isLoadingDialogVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isListenerAttached) return;
    _isListenerAttached = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(emailProvider.notifier).state = "";
      ref.read(passwordProvider.notifier).state = "";
      listenLoginState();
    });
  }

  void listenLoginState() {
    ref.listenManual<AsyncValue<void>>(loginProvider, (_, next) {
      // Skip if same as previous (ignore initial)
      if (_previousLoginState == null) {
        _previousLoginState = next;
        return;
      }

      _previousLoginState = next;

      if (next is AsyncLoading) {
        if (!_isLoadingDialogVisible) {
          _isLoadingDialogVisible = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const NeuLoading(),
          );
        }
        return;
      }

      if (_isLoadingDialogVisible) {
        if (Navigator.of(context, rootNavigator: true).canPop()) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        _isLoadingDialogVisible = false;
      }

      if (next is AsyncError) {
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
      if (next is AsyncData<void>) {
        // Show success dialog and navigate to home screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login successfull',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        Future.microtask(() {
          if (mounted) {
            context.push("/splash");
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _previousLoginState = null;
  }

  goToRegister() => {
    FocusManager.instance.primaryFocus?.unfocus(),
    context.push('/register'),
  };
  goToFP() => {
    FocusManager.instance.primaryFocus?.unfocus(),
    context.push('/fpemail'),
  };

  loginFun(loginState) {
    FocusManager.instance.primaryFocus?.unfocus();
    final email = ref.read(emailProvider);
    final password = ref.read(passwordProvider);
    ref.read(loginProvider.notifier).login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Welcome ~ Hare Mai!',
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
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
                                ref.read(passwordProvider.notifier).state =
                                    text,
                            validator: (text) => null,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => goToFP(),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.lightTextColor,
                              ),
                              child: const Text("Forgot Password?"),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: NeuButton(
                              title: loginState.isLoading
                                  ? "Logging in..."
                                  : "Login",
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: AppColors.lightPink),
                                    ),
                                  ],
                                  text: 'Don\'t have an account? ',
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(
                                        color: AppColors.lightTextColor,
                                      ),
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),

                          /// 👇 Centered logo above bottom
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(AppImages.logo, width: 200),
                          ),

                          const Spacer(),

                          /// 👇 Bottom-aligned logo
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(AppImages.logo2, width: 210),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
