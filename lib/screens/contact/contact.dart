import 'package:_29035f/providers/contact/contact_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:_29035f/utils/widgets/neu_button.dart';
import 'package:_29035f/utils/widgets/neu_checkbox.dart';
import 'package:_29035f/utils/widgets/neu_dialog.dart';
import 'package:_29035f/utils/widgets/neu_loading.dart';
import 'package:_29035f/utils/widgets/neu_text_field.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends ConsumerStatefulWidget {
  const Contact({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactState();
}

class _ContactState extends ConsumerState<Contact> {
  bool _isListenerAttached = false;
  AsyncValue<void>? _previousContactState;
  bool _isLoadingDialogVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isListenerAttached) return;
    _isListenerAttached = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(contactEmailProvider.notifier).state = "";
      ref.read(contactNameProvider.notifier).state = "";
      ref.read(contactMessageProvider.notifier).state = "";
      ref.read(contactSubscribeCheckProvider.notifier).state = false;
      listenContactState();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _previousContactState = null;
  }

  void listenContactState() {
    ref.listenManual(contactProvider, (_, next) {
      // Skip if same as previous (ignore initial)
      if (_previousContactState == null) {
        _previousContactState = next;
        return;
      }

      _previousContactState = next;

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
              'Message Sent Successfully',
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
          if (mounted) {
            context.pop();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              CommanAppBar(title: "Get In Touch"),
              Text(
                "Have questions about our Blueprint?",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightTextColor,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.w),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.r)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icons/mail.png",
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () => launchUrl(
                        Uri(scheme: "mailto", path: "knowmore@29035f.co.nz"),
                      ),
                      child: Text(
                        "knowmore@29035f.co.nz",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 0.23.sw, child: Divider(thickness: 1)),
                  Text(
                    "Or Fill the Form",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.lightTextColor,
                    ),
                  ),
                  SizedBox(width: 0.23.sw, child: Divider(thickness: 1)),
                ],
              ),

              SizedBox(height: 20.h),
              NeuTextField(
                label: "Name",
                keyboardType: TextInputType.name,
                onChanged: (text) =>
                    ref.read(contactNameProvider.notifier).state = text,
                validator: (text) => null,
                labelColor: Colors.black,
                hintText: "Enter",
              ),
              SizedBox(height: 20.h),

              NeuTextField(
                label: "Email or Phone Number",
                keyboardType: TextInputType.emailAddress,
                labelColor: Colors.black,
                onChanged: (text) =>
                    ref.read(contactEmailProvider.notifier).state = text,
                validator: (text) => null,
                hintText: "Enter",
              ),
              SizedBox(height: 20.h),

              NeuTextField(
                labelColor: Colors.black,
                label: "Message",
                keyboardType: TextInputType.name,
                onChanged: (text) =>
                    ref.read(contactMessageProvider.notifier).state = text,
                validator: (text) => null,
                hintText: "Enter your query here",
                maxLine: 6,
              ),
              SizedBox(height: 30.h),

              NeuButton(
                title: "Send Message",
                onPressed: () {
                  ref
                      .read(contactProvider.notifier)
                      .sendContact(
                        ref.watch(contactEmailProvider),
                        ref.watch(contactNameProvider),
                        ref.watch(contactMessageProvider),
                        ref.watch(contactSubscribeCheckProvider),
                      );
                },
                height: 50.h,
                shadowLightColor: AppColors.shadowLight,
                color: Color(0xffB8E8F5),
                titleColor: AppColors.textColor,
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NeuCheckbox(
                    value: ref.watch(contactSubscribeCheckProvider),
                    onChanged: (value) {
                      ref.read(contactSubscribeCheckProvider.notifier).state =
                          value;
                    },
                  ),
                  SizedBox(width: 5.w),
                  SizedBox(
                    width: 0.78.sw,
                    child: Text(
                      "Subscribe to the 29035f Peak Performance Journal",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.lightTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
