import 'dart:developer';

import 'package:_29035f/providers/auth_provider/otp_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/neu_back_btn.dart';
import 'package:_29035f/utils/widgets/neu_dialog.dart';
import 'package:_29035f/utils/widgets/neu_loading.dart';
import 'package:_29035f/utils/widgets/neu_otp_field.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class VerifyOtp extends ConsumerStatefulWidget {
  const VerifyOtp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends ConsumerState<VerifyOtp> {
  bool _hasInitialized = false;
  AsyncValue<void>? _previousOTPState;
  bool _isLoadingDialogVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasInitialized) return;
    _hasInitialized = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listenOtpState();
      ref.read(otpProvider.notifier).resetDigits();
      ref.read(otpProvider.notifier).clearVerificationFlag();
      ref.read(otpTimerProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _previousOTPState = null;
    super.dispose();
  }

  void listenOtpState() {
    ref.listenManual(otpProvider, (previous, next) {
      log("Next: $next");
      // Skip if same as previous (ignore initial)
      if (_previousOTPState == null) {
        _previousOTPState = next;
        return;
      }
      _previousOTPState = next;
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

      if (next is AsyncData<OtpState> && next.value.isVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'OTP has been verified',
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
        // Clear the flag so it doesn't trigger again
        Future.microtask(() {
          ref.read(otpProvider.notifier).clearVerificationFlag();
          if (mounted) context.pushReplacement("/reset_password");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final otpNotifier = ref.read(otpProvider.notifier);
    final timer = ref.watch(otpTimerProvider);
    final timerNotifier = ref.read(otpTimerProvider.notifier);
    final resetCounter = ref.watch(otpResetCounterProvider);

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
                  'OTP Verification',
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
                    'Enter the verification code we just sent on your phone number',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.lightTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              TrueEmbossedOtp(
                enable: timer != 0,
                key: ValueKey(resetCounter),
                onDigitChanged: (index, val) {
                  otpNotifier.updateDigit(index, val);
                },
                onSubmit: (otp) async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await otpNotifier.submitOtp();
                },
              ),
              SizedBox(height: 40.h),
              Visibility(
                visible: timer != 0,
                replacement: const SizedBox(),
                child: Center(
                  child: Text(
                    "Remaining $timer secs",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.lightTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: timer == 0
                      ? () {
                          timerNotifier.reset();
                          ref.read(otpProvider.notifier).resetDigits();
                          ref.read(otpResetCounterProvider.notifier).state++;
                        }
                      : null,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.errorColor,
                  ),
                  child: const Text("Resend OTP"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
