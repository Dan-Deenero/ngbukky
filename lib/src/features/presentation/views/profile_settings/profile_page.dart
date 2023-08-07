import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

import '../../../../core/shared/colors.dart';

Widget card(
  String title,
  String subtitle,
  String image,
) =>
    Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 8.h,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 223, 222, 222),
          blurRadius: 1,
          offset: Offset(1, 1), // Shadow position
        ),
      ], borderRadius: BorderRadius.circular(20), color: AppColors.white),
      child: ListTile(
        leading: SvgPicture.asset(
          image,
          width: 25,
          height: 25,
        ),
        trailing: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
            child: customText(
                text: title,
                fontSize: 15,
                textColor: AppColors.black,
                fontWeight: FontWeight.bold),
          ),
          customText(
              text: subtitle, fontSize: 12, textColor: AppColors.textColor)
        ]),
      ),
    );

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: 20.h,
          decoration: const BoxDecoration(
              color: AppColors.containerGrey,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            heightSpace(5),
            customText(
                text: "Profile settings",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            heightSpace(1),
            customText(
                text: "View analytics and withdraw from your wallet",
                fontSize: 15,
                textColor: AppColors.black),
          ]),
        ),
        heightSpace(2),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              customText(
                  text: "Damino Otobo",
                  fontSize: 26,
                  textColor: AppColors.orange),
              heightSpace(2),
              Row(
                children: [
                  SvgPicture.asset(AppImages.emailIcon),
                  widthSpace(2),
                  bodyText("dadaobo@gmail.com")
                ],
              ),
              heightSpace(1),
              Row(
                children: [
                  SvgPicture.asset(AppImages.phone),
                  widthSpace(2),
                  bodyText("+234 701 111 0153")
                ],
              ),
              heightSpace(5),
              card("Personal profile", "Edit your personal information",
                  AppImages.nameIcon),
              card("Business profile", "Edit your business information",
                  AppImages.box),
              card("Contact Ngbuka", "Edit your business information",
                  AppImages.box),
              card("Wallet", "Edit your business information",
                  AppImages.contact),
            ]),
          ),
        )
      ]),
    );
  }
}
