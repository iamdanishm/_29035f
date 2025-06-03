import 'dart:developer';

import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrueEmbossedOtp extends ConsumerStatefulWidget {
  final int fieldCount;
  final void Function(int index, String val)? onDigitChanged;
  final void Function(String otp)? onSubmit;
  final bool enable;

  const TrueEmbossedOtp({
    super.key,
    this.fieldCount = 4,
    this.onDigitChanged,
    this.onSubmit,
    this.enable = true,
  });

  @override
  ConsumerState<TrueEmbossedOtp> createState() => _TrueEmbossedOtpState();
}

class _TrueEmbossedOtpState extends ConsumerState<TrueEmbossedOtp> {
  late final List<TextEditingController> controllers;
  late final List<FocusNode> textFieldFocusNodes;
  late final List<FocusNode> keyboardFocusNodes;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      widget.fieldCount,
      (_) => TextEditingController(),
    );
    textFieldFocusNodes = List.generate(widget.fieldCount, (_) => FocusNode());
    keyboardFocusNodes = List.generate(widget.fieldCount, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final node in textFieldFocusNodes) {
      node.dispose();
    }
    for (final node in keyboardFocusNodes) {
      node.dispose();
    }
    for (final ctrl in controllers) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void _checkAndSubmit() {
    if (_isSubmitting) return;

    final otp = controllers.map((c) => c.text).join();
    log("UI OTP: $otp");

    if (otp.length == widget.fieldCount &&
        !controllers.any((c) => c.text.isEmpty)) {
      setState(() {
        _isSubmitting = true;
      });

      FocusScope.of(context).unfocus();
      log("UI OTP 2: $otp");

      widget.onSubmit?.call(otp);

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.fieldCount, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SizedBox(
            width: 60.w,
            height: 60.w,
            child: Neumorphic(
              style: NeumorphicStyle(
                depth: widget.enable ? -6 : -2,
                intensity: 0.8,
                surfaceIntensity: 0.2,
                color: AppColors.lightWhite,
                shadowLightColor: AppColors.shadowLight,
                shadowLightColorEmboss: AppColors.embossLight,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.all(Radius.circular(16.r)),
                ),
                lightSource: LightSource.topLeft,
                shape: NeumorphicShape.flat,
              ),
              child: Center(
                child: KeyboardListener(
                  focusNode: keyboardFocusNodes[index],
                  onKeyEvent: (event) {
                    if (event.logicalKey == LogicalKeyboardKey.backspace &&
                        event is KeyDownEvent &&
                        controllers[index].text.isEmpty &&
                        index > 0) {
                      FocusScope.of(
                        context,
                      ).requestFocus(textFieldFocusNodes[index - 1]);
                      controllers[index - 1].clear();
                      widget.onDigitChanged?.call(index - 1, '');
                    }
                  },
                  child: TextField(
                    enabled: widget.enable,
                    controller: controllers[index],
                    focusNode: textFieldFocusNodes[index],
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      widget.onDigitChanged?.call(index, val);
                      if (val.isNotEmpty) {
                        if (index < widget.fieldCount - 1) {
                          FocusScope.of(
                            context,
                          ).requestFocus(textFieldFocusNodes[index + 1]);
                        } else {
                          _checkAndSubmit();
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
