import 'package:_29035f/providers/auth_provider/fp_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/neu_back_btn.dart';
import 'package:_29035f/utils/widgets/neu_button.dart';
import 'package:_29035f/utils/widgets/neu_dialog.dart';
import 'package:_29035f/utils/widgets/neu_loading.dart';
import 'package:_29035f/utils/widgets/neu_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FPEmailScreen extends ConsumerStatefulWidget {
  const FPEmailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FPEmailScreenState();
}

class _FPEmailScreenState extends ConsumerState<FPEmailScreen> {
  bool _hasInitialized = false;
  AsyncValue<void>? _previousFPState;
  bool _isLoadingDialogVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasInitialized) return;
    _hasInitialized = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(fpEmailProvider.notifier).state = "";
      listenFpState();
    });
  }

  @override
  void dispose() {
    _previousFPState = null;
    super.dispose();
  }

  void listenFpState() {
    ref.listenManual<AsyncValue<void>>(fpProvider, (previous, next) {
      if (_previousFPState == null) {
        _previousFPState = next;
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
        final email = ref.read(fpEmailProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Verification code has been sent to $email',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        Future.delayed(
          const Duration(seconds: 1),
          () => context.push("/verify_otp"),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NeuBackBtn(),
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
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Center(
                  child: Text(
                    'Enter your email address to receive a verification code to reset your password.',
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
                height: 180.h,
              ),
              SizedBox(height: 40.h),
              NeuTextField(
                label: "Email ID",
                keyboardType: TextInputType.emailAddress,
                onChanged: (p0) {
                  ref.read(fpEmailProvider.notifier).state = p0;
                },
                validator: (text) => null,
              ),
              SizedBox(height: 40.h),
              NeuButton(
                title: "Send Code",
                onPressed: () {
                  final email = ref.read(fpEmailProvider);
                  ref.read(fpProvider.notifier).forgotPassword(email);
                },
                shadowLightColor: AppColors.shadowLight,
                color: AppColors.embossLight,
                titleColor: AppColors.textColor,
                height: 58.h,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
