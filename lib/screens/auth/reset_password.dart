import 'package:_29035f/providers/auth_provider/rp_provider.dart';
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

class ResetPassword extends ConsumerStatefulWidget {
  const ResetPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends ConsumerState<ResetPassword> {
  bool _isListenerAttached = false;
  AsyncValue<void>? _previousResetState;
  bool _isLoadingDialogVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isListenerAttached) return;
    _isListenerAttached = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newRPassProvider.notifier).state = "";
      ref.read(confirmRPassProvider.notifier).state = "";
      listenResetState();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _previousResetState = null;
  }

  void listenResetState() {
    ref.listenManual<AsyncValue<void>>(resetPassProvider, (previous, next) {
      // Skip if same as previous (ignore initial)
      if (_previousResetState == null) {
        _previousResetState = next;
        return;
      }

      _previousResetState = next;

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
            duration: const Duration(seconds: 2),
            content: Text(
              'Password Reset Successfully',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );

        Future.microtask(() {
          if (mounted) context.go("/");
        });
      }
    });
  }

  void resetPassFun() {
    FocusManager.instance.primaryFocus?.unfocus();
    final newPass = ref.read(newRPassProvider);
    final confirmPass = ref.read(confirmRPassProvider);
    ref.read(resetPassProvider.notifier).resetPassword(newPass, confirmPass);
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
              NeuBackBtn(),
              SizedBox(height: 40.h),
              Center(
                child: Text(
                  'Reset Password',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              NeuTextField(
                label: "Enter New Password",
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onChanged: (text) =>
                    ref.read(newRPassProvider.notifier).state = text,
                validator: (text) => null,
              ),
              SizedBox(height: 30.h),
              NeuTextField(
                label: "Re-enter New Password",
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onChanged: (text) =>
                    ref.read(confirmRPassProvider.notifier).state = text,
                validator: (text) => null,
              ),
              SizedBox(height: 30.h),
              NeuButton(
                title: "Reset Password",
                onPressed: resetPassFun,
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
