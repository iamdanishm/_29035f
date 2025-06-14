import 'package:_29035f/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (ref) => GlobalKey<NavigatorState>(),
);

final readMoreProvider = Provider.family<bool, String>((ref, text) {
  final context = ref.read(navigatorKeyProvider).currentContext!;
  return _shouldShowReadMore(context, text);
});

bool _shouldShowReadMore(BuildContext context, String text) {
  final TextSpan span = TextSpan(
    text: text,
    style: Theme.of(
      context,
    ).textTheme.labelLarge!.copyWith(color: AppColors.shadowDark),
  );

  final TextPainter tp = TextPainter(
    text: span,
    textDirection: TextDirection.ltr,
    maxLines: 4,
  )..layout(maxWidth: MediaQuery.of(context).size.width - 60); // approx padding

  return tp.didExceedMaxLines;
}
