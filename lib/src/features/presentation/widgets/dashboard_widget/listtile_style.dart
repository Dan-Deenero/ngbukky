import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class ListRect extends StatelessWidget {
  final bool isOrders;
  final String? image;
  final int? price;
  final String? item;
  final int? quantity;
  final String? length;
  final String? time;
  final String? date;
  final String? status;
  final String? deliveryMethod;
  final VoidCallback? ontap;


  const ListRect({
    super.key,
    required this.isOrders,
    this.image = AppImages.engineoil,
    this.price = 6000,
    this.item = 'Spark plug',
    this.quantity = 3,
    this.length = '14mm',
    this.time = '12:20pm',
    this.date = '12 Jun 2023',
    this.status = 'new',
    this.deliveryMethod = 'Out of state delivery',
    this.ontap
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.time,
                    ),
                    customText(
                      text: time!,
                      fontSize: 12,
                      textColor: AppColors.textGrey,
                    )
                  ],
                ),
                widthSpace(2),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.calendarIcon,
                    ),
                    customText(
                      text: date!,
                      fontSize: 12,
                      textColor: AppColors.textGrey,
                    ),
                  ],
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(4),
              // width: 60,
              // height: 25,
              decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Center(
                  child: customText(
                    text: status!,
                    fontSize: 10,
                    textColor: AppColors.white,
                    textAlignment: TextAlign.center
                  ),
                ),
              ),
            ),
          ],
        ),
        heightSpace(1),
        Container(
          height: 80,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Image.network(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  widthSpace(3),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: item!,
                        fontSize: 12,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          customText(
                            text: 'Quantity: ',
                            fontSize: 10,
                            textColor: AppColors.textGrey,
                          ),
                          customText(
                            text: '$quantity',
                            fontSize: 10,
                            textColor: AppColors.textGrey,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  customText(
                    text: 'N${quantity! * price!}',
                    fontSize: 12,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
        ),
        heightSpace(2),
        isOrders
            ? AppButton(
                onTap: ontap,
                buttonText: 'View details',
                hasIcon: false,
                isOrange: true,
              )
            : const SizedBox.shrink(),

        heightSpace(3)
      ],
    );
  }

  Container dot() {
    return Container(
      width: 3,
      height: 3,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.black),
    );
  }
}
