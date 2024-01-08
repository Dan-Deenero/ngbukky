import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/orders_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/dashboard_widget/order_card.dart';

class OrdersInfo extends StatefulWidget {
  final String id;
  const OrdersInfo({super.key, required this.id});

  @override
  State<OrdersInfo> createState() => _OrdersInfoState();
}

class _OrdersInfoState extends State<OrdersInfo> {
  final MechanicRepo _mechanicRepo = MechanicRepo();

  OrdersModel? ordersModel;
  var dateString;
  var dateTime;
  bool isLoading = true;
  var formattedTime;
  var formattedDate;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getOneOrder(widget.id).then(
          (value) => setState(
            () {
              ordersModel = value;
              isLoading = false;
              dateString = ordersModel!.createdAt!;
              dateTime = DateTime.parse(dateString);
              formattedDate = DateFormat('E, d MMM y').format(dateTime);

              formattedTime = DateFormat('hh:mm a').format(dateTime);
            },
          ),
        );
  }

  confirmOrder() async {
    var body = {
      "status": "awaiting processing",
    };
    bool result = await _mechanicRepo.processOrder(body, widget.id);
    if (result) {
      if (context.mounted) {
        context.push(AppRoutes.processOrder, extra: widget.id);
        return;
      }
    }
  }

  declineOrder() async {
    var body = {
      "status": "declined",
    };
    bool result = await _mechanicRepo.processOrder(body, widget.id);
    if (result) {
      if (context.mounted) {
        context.pop();
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(19.h),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    color: AppColors.white.withOpacity(.5),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
              customText(
                text: "Order info",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black,
              ),
              heightSpace(1),
              bodyText("View and keep track of your orders here")
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundGrey,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderCard(
                      id: ordersModel!.id!,
                      image: ordersModel!.product!.imageUrl,
                      price: ordersModel!.product!.price! -
                          ordersModel!.product!.discount!,
                      item: ordersModel!.product!.name,
                      quantity: ordersModel!.quantity,
                      length: ordersModel!.product!.specifications!.length,
                    ),
                    heightSpace(1),
                    // Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         customText(
                    //             text: 'Delivery fee',
                    //             fontSize: 13,
                    //             textColor: AppColors.black),
                    //         customText(
                    //           text: 'N4000',
                    //           fontSize: 13,
                    //           textColor: AppColors.black,
                    //           fontWeight: FontWeight.w600,
                    //         )
                    //       ],
                    //     ),
                    //     heightSpace(2),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         customText(
                    //             text: 'Discount applied:',
                    //             fontSize: 13,
                    //             textColor: AppColors.black),
                    //         customText(
                    //           text: '(8%) -N600',
                    //           fontSize: 13,
                    //           textColor: AppColors.black,
                    //           fontWeight: FontWeight.w600,
                    //         )
                    //       ],
                    //     ),
                    //     heightSpace(2),
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         customText(
                    //           text: 'Total price',
                    //           fontSize: 13,
                    //           textColor: AppColors.black,
                    //         ),
                    //         customText(
                    //           text: 'N12,500',
                    //           fontSize: 13,
                    //           textColor: AppColors.black,
                    //           fontWeight: FontWeight.w600,
                    //         )
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    heightSpace(3),
                    customText(
                      text: 'Shipping Information',
                      fontSize: 14,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    heightSpace(2),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            text: 'Transaction Date',
                            fontSize: 12,
                            textColor: AppColors.textGrey,
                          ),
                          heightSpace(1),
                          customText(
                            text: formattedDate,
                            fontSize: 14,
                            textColor: AppColors.black,
                          ),
                          heightSpace(3),
                          customText(
                            text: 'Shipping Method',
                            fontSize: 12,
                            textColor: AppColors.textGrey,
                          ),
                          heightSpace(1),
                          customText(
                            text: ordersModel!.order!.deliveryMethod!,
                            fontSize: 14,
                            textColor: AppColors.black,
                          ),
                          heightSpace(3),
                          // customText(
                          //   text: 'Pick-up Area',
                          //   fontSize: 12,
                          //   textColor: AppColors.textGrey,
                          // ),
                          // heightSpace(1),
                          // customText(
                          //   text: 'Ibeju-Lekki',
                          //   fontSize: 14,
                          //   textColor: AppColors.black,
                          // ),
                          // heightSpace(3),
                          // customText(
                          //   text: 'Pick-up Address',
                          //   fontSize: 12,
                          //   textColor: AppColors.textGrey,
                          // ),
                          // heightSpace(1),
                          // customText(
                          //   text:
                          //       '14 Lekki-Ekpe Expressway, Ibeju-Lekki, Lagos',
                          //   fontSize: 14,
                          //   textColor: AppColors.black,
                          // ),
                        ],
                      ),
                    ),
                    heightSpace(3),
                    if (ordersModel!.status == 'processed')
                    SizedBox(
                      width: 100.h,
                      child: Row(
                        children: [
                          SvgPicture.asset(AppImages.packageR),
                          widthSpace(3),
                          customText(text: 'Order packed and awaiting pick-up by agent', fontSize: 14, textColor: AppColors.black)
                        ],
                      ),
                    )
                    else
                    const SizedBox.shrink(),
                    heightSpace(3),
                    if (ordersModel!.status == 'processed')
                    const SizedBox.shrink()
                    else
                    AppButton(
                      onTap: confirmOrder,
                      buttonText: ordersModel!.status == 'processed'
                          ? 'Confirm pickup'
                          : 'Accept order',
                      hasIcon: false, 
                      isOrange: true,
                    ),
                    heightSpace(3),
                    if (ordersModel!.status == 'processed')
                      const SizedBox.shrink()
                    else
                      GestureDetector(
                        onTap: declineOrder,
                        child: Container(
                          width: double.infinity,
                          height: 7.h,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundGrey,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                width: 1.0, color: AppColors.darkOrange),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customText(
                                  text: 'Decline order',
                                  textColor: AppColors.darkOrange,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
    );
  }
}
