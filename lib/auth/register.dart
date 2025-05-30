import 'package:_29035f/providers/auth_provider/register_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/neu_button.dart';
import 'package:_29035f/utils/widgets/neu_dialog.dart';
import 'package:_29035f/utils/widgets/neu_loading.dart';
import 'package:_29035f/utils/widgets/neu_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    registerListenState();
  }

  void registerListenState() {
    ref.listenManual<AsyncValue<void>>(registerProvider, (_, next) {
      if (next is AsyncError) {
        if (_isDialogShowing) {
          Navigator.of(context, rootNavigator: true).pop();
          _isDialogShowing = false;
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

      if (next is AsyncData<void>) {
        if (_isDialogShowing) {
          Navigator.of(context, rootNavigator: true).pop();
          _isDialogShowing = false;
        }
        // TODO: Navigate and show success here
        // context.go('/login');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  registerFun(registerState) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_isDialogShowing) {
      _isDialogShowing = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const NeuLoading(),
      );
    }
    String name = ref.read(registerNameProvider);
    String email = ref.read(registerEmailProvider);
    String countryCode = ref.read(registerCountryCodeProvider);
    String phoneNumber = ref.read(registerPhoneNoProvider);
    String password = ref.read(registerPasswordProvider);
    String confirmPassword = ref.read(registerConfirmPasswordProvider);
    ref
        .read(registerProvider.notifier)
        .register(
          name,
          email,
          countryCode,
          phoneNumber,
          password,
          confirmPassword,
        );
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerProvider);
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
                  'Create Account',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 30),
                NeuTextField(
                  label: "Name",
                  keyboardType: TextInputType.name,
                  onChanged: (text) =>
                      ref.read(registerNameProvider.notifier).state = text,
                  validator: (text) => null,
                ),
                const SizedBox(height: 25),
                NeuTextField(
                  label: "Email ID",
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (text) =>
                      ref.read(registerEmailProvider.notifier).state = text,
                  validator: (text) => null,
                ),

                const SizedBox(height: 25),
                NeuPhoneTextField(
                  label: "Phone Number",
                  keyboardType: TextInputType.phone,
                  onChanged: (text) =>
                      ref.read(registerPhoneNoProvider.notifier).state = text,
                  validator: (text) => null,
                ),
                const SizedBox(height: 25),
                NeuTextField(
                  label: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onChanged: (text) =>
                      ref.read(registerPasswordProvider.notifier).state = text,
                  validator: (text) => null,
                ),
                const SizedBox(height: 25),
                NeuTextField(
                  label: "Re-Enter Password",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onChanged: (text) =>
                      ref.read(registerConfirmPasswordProvider.notifier).state =
                          text,
                  validator: (text) => null,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: NeuButton(
                    title: "Create",
                    onPressed: registerState.isLoading
                        ? null
                        : () => registerFun(registerState),
                    shadowLightColor: AppColors.shadowLight,
                    color: AppColors.embossLight,
                    titleColor: AppColors.textColor,
                    height: 58,
                    width: double.infinity,
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => context.pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.lightTextColor,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Login',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(color: AppColors.lightPink),
                          ),
                        ],
                        text: 'Have an account already? ',
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
      ),
    );
  }
}
