import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NeuTextField extends ConsumerStatefulWidget {
  const NeuTextField({
    super.key,
    required this.label,
    this.controller,
    required this.keyboardType,
    required this.onChanged,
    required this.validator,
  });
  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final FormFieldValidator validator;

  @override
  ConsumerState<NeuTextField> createState() => _NeuTextFieldState();
}

class _NeuTextFieldState extends ConsumerState<NeuTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
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
            controller: widget.controller,
            keyboardType: TextInputType.emailAddress,
            onChanged: widget.onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
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
