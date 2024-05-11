import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/get_account.dart';
import 'package:ngbuka/src/domain/data/transaction_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class SpareWithdrawalDetail extends StatefulWidget {
  final String id;

  const SpareWithdrawalDetail({super.key, required this.id});

  @override
  State<SpareWithdrawalDetail> createState() => _SpareWithdrawalDetailState();
}

class _SpareWithdrawalDetailState extends State<SpareWithdrawalDetail> {
  final MechanicRepo _mechanicRepo = MechanicRepo();

  TransactionModel? transactionModel;
  GetAccount? getAccount;

  bool isLoading = true;

  dynamic formattedTime;
  dynamic formattedDate;
  dynamic dateString;
  dynamic dateTime;
  dynamic whatIsIt;
  dynamic isSuccess;
  dynamic bgcol;
  dynamic statustext;
  dynamic txtcol;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getAccount().then(
          (value) => setState(
            () {
              getAccount = value;
            },
          ),
        );
    _mechanicRepo.getOneTransaction(widget.id).then(
          (value) => setState(
            () {
              transactionModel = value;
              isLoading = false;
              dateString = transactionModel!.createdAt;
              dateTime = DateTime.parse(dateString!);
              formattedDate = DateFormat('E, d MMM y').format(dateTime);

              formattedTime = DateFormat('hh:mm a').format(dateTime);
              if (transactionModel!.status! == 'failed' ||
                  transactionModel!.status! == 'Unsuccessful' ||
                  transactionModel!.status! == 'Refunded') {
                bgcol = AppColors.red.withOpacity(.1);
                txtcol = AppColors.red;
                statustext = 'Insufficient funds';
                isSuccess = false;
              } else {
                bgcol = AppColors.green.withOpacity(.1);
                txtcol = AppColors.green;
                statustext = 'Successful withdrawal';
                isSuccess = true;
              }
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(25.h),
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: isSuccess
                        ? AppColors.green.withOpacity(0.1)
                        : AppColors.red.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, top: 40),
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.black)),
                            child: Center(
                                child: SvgPicture.asset(AppImages.badIcon)),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            backgroundColor: AppColors.backgroundGrey,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(
                    height: 0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration:
                        BoxDecoration(color: AppColors.green.withOpacity(0.1)),
                    child: Column(
                      children: [
                        isSuccess
                            ? SvgPicture.asset(AppImages.successModal)
                            : SvgPicture.asset(AppImages.unsuccessModal),
                        heightSpace(1.5),
                        customText(
                            text: "N${transactionModel!.amount}",
                            fontSize: 24,
                            textColor: AppColors.green,
                            fontWeight: FontWeight.bold),
                        heightSpace(2),
                        customText(
                            text: statustext,
                            fontSize: 14,
                            textColor: AppColors.green),
                        heightSpace(1),
                        customText(
                          text: "Booking status",
                          fontSize: 12,
                          textColor: AppColors.textGrey,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                            text: "Details",
                            fontSize: 14,
                            textColor: AppColors.orange,
                            fontWeight: FontWeight.bold),
                        heightSpace(1),
                        ListTile(
                          leading: isSuccess
                              ? SvgPicture.asset(
                                  AppImages.withdrawal,
                                  width: 28,
                                )
                              : SvgPicture.asset(AppImages.unwithdrawal),
                          title: customText(
                              text: '123-000',
                              fontSize: 14,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          subtitle: customText(
                              text: "Transaction number",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                        ),
                        heightSpace(1),
                        ListTile(
                          leading: isSuccess
                              ? SvgPicture.asset(
                                  AppImages.withdrawal,
                                  width: 28,
                                )
                              : SvgPicture.asset(AppImages.unwithdrawal),
                          title: customText(
                              text: formattedDate,
                              fontSize: 14,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          subtitle: customText(
                              text: "Date",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                        ),
                        heightSpace(1),
                        ListTile(
                          leading: SvgPicture.asset(AppImages.time),
                          title: customText(
                              text: formattedTime,
                              fontSize: 14,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          subtitle: customText(
                              text: 'Time',
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                        ),
                        // ListTile(
                        //   leading: SvgPicture.asset(AppImages.accountDet),
                        //   title: customText(
                        //       text: getAccount!.bankName!,
                        //       fontSize: 14,
                        
                        //       textColor: AppColors.black,
                        //       fontWeight: FontWeight.bold),
                        //   subtitle: customText(
                        //       text: 'Bank',
                        //       fontSize: 12,
                        //       textColor: AppColors.textGrey),
                        // ),
                        // heightSpace(1),
                        // ListTile(
                        //   leading: SvgPicture.asset(AppImages.accountDet),
                        //   title: customText(
                        //       text: getAccount!.accountNumber!,
                        //       fontSize: 14,
                        //       textColor: AppColors.black,
                        //       fontWeight: FontWeight.bold),
                        //   subtitle: customText(
                        //       text: "Account number",
                        //       fontSize: 12,
                        //       textColor: AppColors.textGrey),
                        // ),
                        // ListTile(
                        //   leading: SvgPicture.asset(AppImages.profile),
                        //   title: customText(
                        //       text: getAccount!.bankCode!,
                        //       fontSize: 14,
                        //       textColor: AppColors.black,
                        //       fontWeight: FontWeight.bold),
                        //   subtitle: customText(
                        //       text: "Bank code",
                        //       fontSize: 12,
                        //       textColor: AppColors.textGrey),
                        // ),
                        const Divider(),
                        heightSpace(2),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: GestureDetector(
                        //         onTap: () {},
                        //         child: Container(
                        //           width: 3,
                        //           height: 7.h,
                        //           decoration: BoxDecoration(
                        //               border: Border.all(
                        //                   width: 1.0,
                        //                   color: AppColors.textGrey),
                        //               borderRadius: BorderRadius.circular(20)),
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               customText(
                        //                 text: "Download",
                        //                 fontSize: 15,
                        //                 textColor: AppColors.orange,
                        //               ),
                        //               widthSpace(2),
                        //               SvgPicture.asset(AppImages.download)
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     widthSpace(4),
                        //     Expanded(
                        //       child: GestureDetector(
                        //         onTap: () {},
                        //         child: Container(
                        //           width: 30.w,
                        //           height: 7.h,
                        //           decoration: BoxDecoration(
                        //               border: Border.all(
                        //                   width: 1.0,
                        //                   color: AppColors.textGrey),
                        //               borderRadius: BorderRadius.circular(20)),
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               customText(
                        //                 text: "Share",
                        //                 fontSize: 15,
                        //                 textColor: AppColors.orange,
                        //               ),
                        //               widthSpace(2),
                        //               SvgPicture.asset(AppImages.share)
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        heightSpace(3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
