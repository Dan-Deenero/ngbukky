import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class PaymentRequest extends StatelessWidget {
  const PaymentRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    color: AppColors.white.withOpacity(.5),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.only(left: 7.0),
                  child: Center(
                      child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.black,
                  )),
                ),
              ),
            ),
            customText(
                text: "Payment request",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            heightSpace(1),
            bodyText("Completed bookings awaiting payment")
          ]),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 10.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                        text: "Due: N5,050",
                        fontSize: 15,
                        textColor: AppColors.orange),
                    Container(
                      width: 37.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.containerGrey),
                      child: Center(
                        child: customText(
                            text: "Pending payment request",
                            fontSize: 10,
                            textColor: AppColors.black),
                      ),
                    )
                  ],
                ),
                title: customText(
                    text: "Kelechi Amadi",
                    fontSize: 16,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.bold),
                leading: Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.containerGrey),
                )),
          ),
        ],
      )),
    );
  }
}
