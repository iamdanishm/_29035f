import 'package:_29035f/utils/app_colors.dart';
import 'package:_29035f/utils/widgets/app_bar.dart';
import 'package:_29035f/utils/widgets/neu_text_field.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
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
                      // TODO: add date of birth field
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
