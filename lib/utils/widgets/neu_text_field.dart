import 'package:_29035f/providers/auth_provider/register_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeuTextField extends ConsumerWidget {
  const NeuTextField({
    super.key,
    required this.label,
    this.controller,
    required this.keyboardType,
    required this.onChanged,
    required this.validator,
    this.obscureText = false,
    this.labelColor = AppColors.lightTextColor,
    this.hintText,
    this.maxLine = 1,
  });

  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final FormFieldValidator validator;
  final bool obscureText;
  final Color labelColor;
  final String? hintText;
  final int maxLine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: labelColor),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          height: null,
          child: Neumorphic(
            style: NeumorphicStyle(
              depth: -6,
              intensity: 0.8,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(12.r),
              ),
              lightSource: LightSource.topLeft,
              color: AppColors.lightWhite,
              shadowLightColor: AppColors.shadowLight,
              shadowLightColorEmboss: AppColors.embossLight,
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              onChanged: onChanged,
              maxLines: maxLine,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: obscureText,
              validator: validator,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColors.shadowDark),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 15.h,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NeuPhoneTextField extends ConsumerWidget {
  const NeuPhoneTextField({
    super.key,
    required this.label,
    this.controller,
    required this.keyboardType,
    required this.onChanged,
    required this.validator,
    this.obscureText = false,
  });

  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final FormFieldValidator validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppColors.lightTextColor),
        ),
        SizedBox(height: 5.h),
        Neumorphic(
          style: NeumorphicStyle(
            depth: -6,
            intensity: 0.8,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12.r)),
            lightSource: LightSource.topLeft,
            color: AppColors.lightWhite,
            shadowLightColor: AppColors.shadowLight,
            shadowLightColorEmboss: AppColors.embossLight,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CountryCodePicker(
                  onChanged: (country) {
                    ref.read(registerCountryCodeProvider.notifier).state =
                        country.dialCode.toString();
                  },
                  initialSelection: 'IN',
                  favorite: const ['+91', 'IN'],
                  showCountryOnly: false,
                  flagDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  builder: (country) {
                    return Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.r),
                          child: Image.asset(
                            country!.flagUri.toString(),
                            package: 'country_code_picker',
                            fit: BoxFit.contain,
                            width: 25.w,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.chevron_right_rounded, size: 22.sp),
                        ),
                        RotatedBox(
                          quarterTurns: 1,
                          child: SizedBox(
                            width: 25.w,
                            child: Divider(thickness: 1.h),
                          ),
                        ),
                        Text(
                          country.toString(),
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: AppColors.lightTextColor,
                                fontSize: 14.sp,
                              ),
                        ),
                      ],
                    );
                  },
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    keyboardType: keyboardType,
                    onChanged: onChanged,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: obscureText,
                    validator: validator,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 15.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NeuDateTextField extends ConsumerWidget {
  const NeuDateTextField({
    super.key,
    required this.label,
    this.controller,
    required this.keyboardType,
    required this.onChanged,
    required this.validator,
    this.obscureText = false,
    this.labelColor = AppColors.lightTextColor,
    required this.onPressed,
  });

  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final FormFieldValidator validator;
  final bool obscureText;
  final Color labelColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: labelColor),
        ),
        SizedBox(height: 5.h),
        Neumorphic(
          style: NeumorphicStyle(
            depth: -6,
            intensity: 0.8,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12.r)),
            lightSource: LightSource.topLeft,
            color: AppColors.lightWhite,
            shadowLightColor: AppColors.shadowLight,
            shadowLightColorEmboss: AppColors.embossLight,
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: obscureText,
            validator: validator,
            inputFormatters: [DateInputFormatter()],
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 15.h,
              ),
              suffixIcon: IconButton(
                icon: Image.asset(
                  "assets/images/icons/calendar.png",
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.contain,
                ),
                onPressed: onPressed,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.length > 8) {
      text = text.substring(0, 8);
    }

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i == 1 || i == 3) && i != text.length - 1) {
        buffer.write('/');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
