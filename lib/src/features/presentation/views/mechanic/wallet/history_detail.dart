import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/controller/Helpers.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/data/transaction_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/success_modal.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class HistoryDetail extends StatefulWidget {
  final String id;

  const HistoryDetail({super.key, required this.id});

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  final MechanicRepo _mechanicRepo = MechanicRepo();

  TransactionModel? transactionModel;
  static final description = TextEditingController();
  List<Services>? quote = [];

  bool isLoading = true;

  dynamic formattedTime;
  dynamic formattedDate;
  dynamic dateString;
  dynamic dateTime;
  dynamic whatIsIt;
  dynamic isSuccess;
  dynamic bgcol;
  dynamic txtcol;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getOneTransaction(widget.id).then(
          (value) => setState(
            () {
              transactionModel = value;
              if (transactionModel!.booking == null) {
                whatIsIt = transactionModel!.quoteRequest;
              } else {
                whatIsIt = transactionModel!.booking;
              }
              quote = whatIsIt!.services!;
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
                isSuccess = false;
              } else {
                bgcol = AppColors.green.withOpacity(.1);
                txtcol = AppColors.green;
                isSuccess = true;
              }
            },
          ),
        );
  }

  showCompletedModal() {
    showDialog(
      context: context,
      builder: (context) => SuccessDialogue(
        title: 'Complete booking',
        subtitle:
            'Your have completed your booking and requested for payment from ${transactionModel!.order!.order!.user!.username}',
        action: () => context.pop(),
      ),
    );
  }

  reportClient() async {
    var data = {
      "description": description.text,
      "reportableId": transactionModel!.order!.id,
      "reportableType": "booking",
      "userId": transactionModel!.order!.order!.user!.id,
    };

    bool result = await _mechanicRepo.reportClient(data);

    if (result) {
      showCompletedModal();
    }
  }

  showReportClient() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the radius as needed
        ),
        contentPadding: const EdgeInsets.all(20.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                  text: 'Report client?',
                  fontSize: 24,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w700),
              InkWell(
                  onTap: () => context.pop(),
                  child: SvgPicture.asset(AppImages.cancelModal))
            ],
          ),
          heightSpace(1),
          customText(
              text: 'Do you want to report this client? ',
              fontSize: 12,
              textColor: AppColors.black),
          heightSpace(2),
          modalForm('Air conditioning', description, 8),
          heightSpace(1),
          Row(
            children: [
              SvgPicture.asset(AppImages.warning),
              widthSpace(2),
              Flexible(
                child: customText(
                    text:
                        'Ensure this action is totally needed, or settle your differences with the client.',
                    fontSize: 11,
                    textColor: AppColors.textGrey),
              )
            ],
          ),
          heightSpace(2),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () => context.pop(),
                    child: customText(
                        text: 'cancel',
                        fontSize: 16,
                        textColor: AppColors.textGrey)),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.containerGrey,
                ),
                TextButton(
                  onPressed: reportClient,
                  child: customText(
                    text: 'Send report',
                    fontSize: 16,
                    textColor: AppColors.darkOrange,
                  ),
                )
              ],
            ),
          )
        ],
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
                            text:
                                '₦${Helpers.formatBalance(transactionModel!.amount)}',
                            fontSize: 24,
                            textColor: AppColors.green,
                            fontWeight: FontWeight.bold),
                        heightSpace(2),
                        customText(
                            text: "Booking Completed  - Paid🎉",
                            fontSize: 14,
                            textColor: AppColors.green),
                        heightSpace(1),
                        customText(
                          text: "Booking status",
                          fontSize: 12,
                          textColor: AppColors.textGrey,
                        ),
                        heightSpace(1),
                        customText(
                          text: "Receipt no: 234",
                          fontSize: 12,
                          textColor: AppColors.black,
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
                            text: "Personal",
                            fontSize: 14,
                            textColor: AppColors.orange,
                            fontWeight: FontWeight.bold),
                        heightSpace(1),
                        ListTile(
                          leading:
                              Image.network(whatIsIt!.user!.profileImageUrl!),
                          title: customText(
                              text: whatIsIt!.user!.username!,
                              fontSize: 14,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          subtitle: customText(
                              text: "Client name",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                        ),
                        heightSpace(1),
                        ListTile(
                          leading: SvgPicture.asset(AppImages.locationIcon),
                          title: customText(
                              text: whatIsIt!.user!.address!,
                              fontSize: 14,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          subtitle: customText(
                              text: "Location",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                        ),
                        heightSpace(1),
                        ListTile(
                          leading: SvgPicture.asset(AppImages.calendarIcon),
                          title: customText(
                              text: whatIsIt!.brand!,
                              fontSize: 14,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          subtitle: customText(
                              text: 'Car brand',
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(AppImages.calendarIcon),
                          title: customText(
                              text: "${whatIsIt!.model}, ${whatIsIt!.year}",
                              fontSize: 14,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          subtitle: customText(
                              text: 'Car model',
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                        ),
                        heightSpace(1),
                        ListTile(
                          leading: SvgPicture.asset(AppImages.carIcon),
                          title: customText(
                              text: '${whatIsIt!.year}',
                              fontSize: 14,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          subtitle: customText(
                              text: "Year of manufacture",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                        ),
                        const Divider(),
                        customText(
                            text: "Service rendered",
                            fontSize: 14,
                            textColor: AppColors.orange,
                            fontWeight: FontWeight.bold),
                        heightSpace(3),
                        ...quote!.map(
                          (qte) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(AppImages.serviceIcon),
                                    widthSpace(2),
                                    customText(
                                        text: qte.name!,
                                        fontSize: 13,
                                        textColor: AppColors.black,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        heightSpace(1),
                        const Divider(),
                        heightSpace(1),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText(
                                    text: 'Sub-total (₦)',
                                    fontSize: 13,
                                    textColor: AppColors.black),
                                customText(
                                    text: '${transactionModel!.amount}.00',
                                    fontSize: 13,
                                    textColor: AppColors.black)
                              ],
                            ),
                            heightSpace(2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText(
                                    text: 'Ngbuka Charge (1%)',
                                    fontSize: 13,
                                    textColor: AppColors.black),
                                customText(
                                    text: '${50.00}',
                                    fontSize: 13,
                                    textColor: AppColors.black)
                              ],
                            ),
                            heightSpace(2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText(
                                    text: 'Total',
                                    fontSize: 13,
                                    textColor: AppColors.black,
                                    fontWeight: FontWeight.w600),
                                customText(
                                    text:
                                        '${transactionModel!.amount! + 50.00}',
                                    fontSize: 13,
                                    textColor: AppColors.black,
                                    fontWeight: FontWeight.w600)
                              ],
                            )
                          ],
                        ),
                        heightSpace(3),
                        const Divider(),
                        heightSpace(3),
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }

  TextFormField modalForm(
    String hint,
    TextEditingController control,
    int line,
  ) {
    return TextFormField(
      controller: control,
      maxLines: line,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textformGrey),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textformGrey),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textformGrey),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 10, top: 10),
        errorStyle: const TextStyle(fontSize: 14),
      ),
    );
  }
}
