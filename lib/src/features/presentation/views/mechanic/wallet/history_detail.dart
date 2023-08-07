import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class HistoryDetail extends StatelessWidget {
  const HistoryDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        elevation: 0.0,
        backgroundColor: AppColors.backgroundGrey,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.borderGrey)),
                child: Center(child: SvgPicture.asset(AppImages.badIcon)),
              ),
            ),
          )
        ],
      ),
      backgroundColor: AppColors.backgroundGrey,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(.2),
                  shape: BoxShape.circle),
              child: Center(child: SvgPicture.asset(AppImages.tick)),
            ),
          ),
          heightSpace(3),
          customText(
              text: "N5,050",
              fontSize: 24,
              textColor: AppColors.green,
              fontWeight: FontWeight.bold),
          heightSpace(2),
          customText(
              text: "Booking Completed - Paid",
              fontSize: 14,
              textColor: AppColors.green),
          heightSpace(1),
          customText(
              text: "Booking Completed - Paid",
              fontSize: 14,
              textColor: AppColors.textGrey),
        ],
      )),
    );
  }
}
