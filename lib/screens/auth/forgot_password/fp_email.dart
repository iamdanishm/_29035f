import 'package:_29035f/providers/auth_provider/fp_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/neu_back_btn.dart';
import 'package:_29035f/utils/widgets/neu_button.dart';
import 'package:_29035f/utils/widgets/neu_dialog.dart';
import 'package:_29035f/utils/widgets/neu_loading.dart';
import 'package:_29035f/utils/widgets/neu_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      // Skip if same as previous (ignore initial)
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
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        Future.delayed(
          const Duration(seconds: 1),
          // ignore: use_build_context_synchronously
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
                padding: const EdgeInsets.symmetric(horizontal: 50),
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
              SizedBox(height: 40),
              Image.asset('assets/images/illustrations/email.png'),
              SizedBox(height: 40),
              NeuTextField(
                label: "Email ID",
                keyboardType: TextInputType.emailAddress,
                onChanged: (p0) {
                  ref.read(fpEmailProvider.notifier).state = p0;
                },
                validator: (text) => null,
              ),
              SizedBox(height: 40),
              NeuButton(
                title: "Send Code",
                onPressed: () {
                  final email = ref.read(fpEmailProvider);
                  ref.read(fpProvider.notifier).forgotPassword(email);
                },
                shadowLightColor: AppColors.shadowLight,
                color: AppColors.embossLight,
                titleColor: AppColors.textColor,
                height: 58,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
