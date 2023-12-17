import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class WalletTile extends StatelessWidget {
  final bool isWithdrawal;
  final bool isMechanic;
  final String? orderNo;
  final String? id;
  final int? amount;
  final String? status;
  final String? date;
  final String? time;

  const WalletTile({
    super.key,
    this.id,
    required this.isWithdrawal,
    required this.isMechanic,
    this.orderNo,
    this.amount,
    this.status,
    this.date,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    bool isSuccess;
    Color bgcol;
    Color txtcol;
    if (status == 'failed' ||
        status == 'Unsuccessful' ||
        status == 'Refunded') {
      bgcol = AppColors.red.withOpacity(.3);
      txtcol = AppColors.red;
      isSuccess = false;
    } else {
      bgcol = AppColors.green.withOpacity(.3);
      txtcol = AppColors.green;
      isSuccess = true;
    }

    return GestureDetector(
      onTap: (){
        if(isMechanic && isWithdrawal){
          context.push(AppRoutes.withdrawalDetail, extra: id);
        }else if(isMechanic && !isWithdrawal){
          context.push(AppRoutes.historyDetail, extra: id);
        }else if(!isMechanic && isWithdrawal){
          context.push(AppRoutes.spareWithdrawalDetail, extra: id);
        }else if(!isMechanic && !isWithdrawal){
          context.push(AppRoutes.spareHistoryDetail, extra: id);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 10.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            isWithdrawal
                ? Row(
                    children: [
                      isSuccess
                          ? SvgPicture.asset(
                              AppImages.withdrawal,
                              width: 28,
                            )
                          : SvgPicture.asset(AppImages.unwithdrawal),
                      widthSpace(4),
                    ],
                  )
                : const SizedBox.shrink(),
            Container(
              width: isWithdrawal ? 75.w : 86.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: isWithdrawal ? 'Withdrawal' : 'Order No: #52',
                        fontSize: 14,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.time),
                              customText(
                                  text: '$time',
                                  fontSize: 10,
                                  textColor: AppColors.textGrey)
                            ],
                          ),
                          widthSpace(1),
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.calendarIcon),
                              customText(
                                  text: '$date',
                                  fontSize: 10,
                                  textColor: AppColors.textGrey)
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  heightSpace(2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: '₦ $amount',
                        fontSize: 14,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      Container(
                        width: 19.w,
                        height: 3.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: bgcol),
                        child: Center(
                          child: customText(
                              text: "$status", fontSize: 12, textColor: txtcol),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
