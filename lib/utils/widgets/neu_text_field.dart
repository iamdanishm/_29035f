import 'package:_29035f/providers/auth_provider/register_provider.dart';
import 'package:_29035f/utils/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NeuTextField extends ConsumerWidget {
  const NeuTextField({
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
          ).textTheme.labelLarge!.copyWith(color: AppColors.lightTextColor),
        ),

        SizedBox(height: 5),
        Neumorphic(
          style: NeumorphicStyle(
            depth: -6,
            intensity: 0.8,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
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
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
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
          ).textTheme.labelLarge!.copyWith(color: AppColors.lightTextColor),
        ),

        SizedBox(height: 5),
        Neumorphic(
          style: NeumorphicStyle(
            depth: -6,
            intensity: 0.8,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            lightSource: LightSource.topLeft,
            color: AppColors.lightWhite,
            shadowLightColor: AppColors.shadowLight,
            shadowLightColorEmboss: AppColors.embossLight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    borderRadius: BorderRadius.circular(5),
                  ),
                  builder: (country) {
                    return Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            country!.flagUri.toString(),
                            package: 'country_code_picker',
                            fit: BoxFit.contain,
                            width: 25,
                          ),
                        ),
                        const SizedBox(width: 5),
                        RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.chevron_right_rounded, size: 22),
                        ),
                        RotatedBox(
                          quarterTurns: 1,
                          child: SizedBox(width: 25, child: Divider()),
                        ),
                        Text(
                          country.toString(),
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppColors.lightTextColor),
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
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
