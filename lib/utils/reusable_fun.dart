import 'package:_29035f/utils/constant.dart';

bool validatePhoneNumber(String phone) {
  if (phone.startsWith('+91') ||
      phone.startsWith('91') ||
      RegExp(r'^[6-9]').hasMatch(phone)) {
    return indiaPhoneRegex.hasMatch(phone);
  } else if (phone.startsWith('+31') || phone.startsWith('0')) {
    return netherlandsPhoneRegex.hasMatch(phone);
  } else if (phone.startsWith('+64') || phone.startsWith('0')) {
    return nzPhoneRegex.hasMatch(phone);
  }
  return false;
}
