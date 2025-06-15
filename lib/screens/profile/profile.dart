import 'dart:developer';

import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:_29035f/utils/widgets/neu_text_field.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

//TODO: WORKING ON THIS ON MAC

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  String? validateDate(String? input) {
    if (input == null || input.isEmpty) return 'Date is required';

    final regex = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$');
    final match = regex.firstMatch(input);
    if (match == null) return 'Enter a valid date format (DD/MM/YYYY)';

    final int day = int.parse(match.group(1)!);
    final int month = int.parse(match.group(2)!);
    final int year = int.parse(match.group(3)!);

    if (month < 1 || month > 12) return 'Invalid month';
    if (day < 1) return 'Invalid day';

    if (DateTime(year, month, day).isAfter(DateTime.now())) {
      return 'Date cannot be in the future';
    }

    // Days in each month
    final daysInMonth = <int>[
      31,
      _isLeapYear(year) ? 29 : 28,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31,
    ];

    if (day > daysInMonth[month - 1]) {
      return 'Invalid day for the given month/year';
    }

    return null; // valid
  }

  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                CommanAppBar(title: "My Profile"),
                NeumorphicButton(
                  style: NeumorphicStyle(
                    depth: 6,
                    intensity: 0.6,
                    boxShape: NeumorphicBoxShape.circle(),
                    lightSource: LightSource.topLeft,
                    color: AppColors.lightWhite,
                    shadowLightColor: AppColors.shadowLight,
                    shadowLightColorEmboss: AppColors.embossLight,
                  ),
                  onPressed: () {},
                  padding: EdgeInsets.all(45.h),
                  child: Image.asset(
                    "assets/images/icons/upload.png",
                    width: 30.w,
                    height: 30.h,
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.h,
                  children: [
                    NeuTextField(
                      label: "Name",
                      labelColor: Colors.black,
                      keyboardType: TextInputType.name,
                      onChanged: (text) {},
                      validator: (text) => null,
                    ),
                    NeuTextField(
                      label: "Preferred Name (optional)",
                      labelColor: Colors.black,
                      keyboardType: TextInputType.name,
                      onChanged: (text) {},
                      validator: (text) => null,
                    ),
                    NeuTextField(
                      label: "Email ID",
                      labelColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (text) {},
                      validator: (text) => null,
                    ),
                    NeuTextField(
                      label: "Phone Number",
                      labelColor: Colors.black,
                      keyboardType: TextInputType.phone,
                      onChanged: (text) {},
                      validator: (text) => null,
                    ),

                    NeuDateTextField(
                      label: "Date of Birth",
                      labelColor: Colors.black,
                      keyboardType: TextInputType.datetime,
                      onChanged: (text) {},
                      validator: (text) => validateDate(text),
                      onPressed: () async {
                        try {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            final formattedDate = DateFormat(
                              'dd/MM/yyyy',
                            ).format(pickedDate);

                            log("Selected Date: $formattedDate");
                          }
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                    ),
                    NeuTextField(
                      label: "Current Role / Title",
                      labelColor: Colors.black,
                      keyboardType: TextInputType.text,
                      onChanged: (text) {},
                      validator: (text) => null,
                    ),
                    NeuTextField(
                      label: "Organization / Department",
                      labelColor: Colors.black,
                      keyboardType: TextInputType.text,
                      onChanged: (text) {},
                      validator: (text) => null,
                    ),
                    NeuTextField(
                      label: "Total Experience",
                      labelColor: Colors.black,
                      keyboardType: TextInputType.number,
                      onChanged: (text) {},
                      validator: (text) => null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
