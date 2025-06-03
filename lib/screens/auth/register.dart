import 'package:_29035f/providers/auth_provider/register_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/neu_button.dart';
import 'package:_29035f/utils/widgets/neu_dialog.dart';
import 'package:_29035f/utils/widgets/neu_loading.dart';
import 'package:_29035f/utils/widgets/neu_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  bool _hasInitialized = false;
  AsyncValue<void>? _previousRegisterState;
  bool _isLoadingDialogVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasInitialized) return;
    _hasInitialized = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(registerEmailProvider.notifier).state = "";
      ref.read(registerPasswordProvider.notifier).state = "";
      ref.read(registerConfirmPasswordProvider.notifier).state = "";
      ref.read(registerNameProvider.notifier).state = "";
      ref.read(registerPhoneNoProvider.notifier).state = "";
      ref.read(registerCountryCodeProvider.notifier).state = "+91";
      registerListenState();
    });
  }

  @override
  void dispose() {
    _previousRegisterState = null;
    super.dispose();
  }

  void registerListenState() {
    ref.listenManual<AsyncValue<void>>(registerProvider, (_, next) {
      // Skip if same as previous (ignore initial)
      if (_previousRegisterState == null) {
        _previousRegisterState = next;
        return;
      }
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Account Created Successfully',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
        // context.go('/login');
      }
    });
  }

  registerFun(registerState) {
    FocusManager.instance.primaryFocus?.unfocus();
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 30.h),
                NeuTextField(
                  label: "Name",
                  keyboardType: TextInputType.name,
                  onChanged: (text) =>
                      ref.read(registerNameProvider.notifier).state = text,
                  validator: (text) => null,
                ),
                SizedBox(height: 25.h),
                NeuTextField(
                  label: "Email ID",
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (text) =>
                      ref.read(registerEmailProvider.notifier).state = text,
                  validator: (text) => null,
                ),
                SizedBox(height: 25.h),
                NeuPhoneTextField(
                  label: "Phone Number",
                  keyboardType: TextInputType.phone,
                  onChanged: (text) =>
                      ref.read(registerPhoneNoProvider.notifier).state = text,
                  validator: (text) => null,
                ),
                SizedBox(height: 25.h),
                NeuTextField(
                  label: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onChanged: (text) =>
                      ref.read(registerPasswordProvider.notifier).state = text,
                  validator: (text) => null,
                ),
                SizedBox(height: 25.h),
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
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: NeuButton(
                    title: "Create",
                    onPressed: registerState.isLoading
                        ? null
                        : () => registerFun(registerState),
                    shadowLightColor: AppColors.shadowLight,
                    color: AppColors.embossLight,
                    titleColor: AppColors.textColor,
                    height: 58.h,
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
