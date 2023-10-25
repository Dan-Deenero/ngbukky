import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/notification_model.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({
    super.key,
    this.quoteModel,
    required this.quote,
    required this.price,
    required this.serviceFee,
    this.bookingModel,
    this.notifyModel,
    this.formattedDate,
    this.formattedTime,
    this.func1
  });

  final QuotesModel? quoteModel;
  final List<Services>? quote;
  final BookingModel? bookingModel;
  final NotificationModel? notifyModel;
  final int? price;
  final double? serviceFee;
  final formattedDate;
  final formattedTime;
  final VoidCallback? func1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightSpace(2),
            Row(
              children: [
                widthSpace(5.5),
                SvgPicture.asset(AppImages.hourGlass),
                widthSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                        text: 'Payment request',
                        fontSize: 14,
                        textColor: AppColors.orange,
                        fontWeight: FontWeight.w600),
                    customText(
                        text: 'Booking status',
                        fontSize: 12,
                        textColor: AppColors.textGrey)
                  ],
                )
              ],
            ),
            heightSpace(2),
            customText(
                text: "Personal",
                fontSize: 14,
                textColor: AppColors.orange,
                fontWeight: FontWeight.bold),
            heightSpace(1),
            ListTile(
              leading: SvgPicture.asset(AppImages.profile),
              title: customText(
                  text: quoteModel!.user!.username!,
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
                  text: quoteModel!.user!.address!,
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
                  text: quoteModel!.brand!,
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
                  text: "${quoteModel!.model!}, ${quoteModel!.year!}",
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
                  text: '${quoteModel!.year!}',
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
            Column(
              children: [
                ...quote!.map(
                  (qte) {
                    return Row(
                      children: [
                        SvgPicture.asset(AppImages.serviceIcon),
                        widthSpace(2),
                        customText(
                            text: qte.name!,
                            fontSize: 13,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w600),
                        heightSpace(4),
                      ],
                    );
                  },
                ),
              ],
            ),
            heightSpace(1),
            const Divider(),
            customText(
                text: "Schedule",
                fontSize: 14,
                textColor: AppColors.orange,
                fontWeight: FontWeight.bold),
            heightSpace(1),
            ListTile(
              leading: SvgPicture.asset(AppImages.calendarIcon),
              title: customText(
                  text: formattedDate,
                  fontSize: 14,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.bold),
              subtitle: customText(
                  text: "Scheduled date",
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
                  text: "Scheduled time",
                  fontSize: 12,
                  textColor: AppColors.textGrey),
            ),
            heightSpace(2),
            const Divider(),
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
                        text: '$price',
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
                        text: '$serviceFee',
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
                        text: '${price! + serviceFee!}',
                        fontSize: 13,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w600)
                  ],
                )
              ],
            ),
            heightSpace(2),
            heightSpace(3),
            Row(
              children: [
                SvgPicture.asset(AppImages.warning),
                widthSpace(2),
                Flexible(
                  child: customText(
                      text:
                          "For your own safety, all transactions should be done in the Ngbuka application.",
                      fontSize: 12,
                      textColor: AppColors.orange),
                )
              ],
            ),
            heightSpace(3),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 30.w,
                    height: 7.h,
                    decoration: BoxDecoration(
                        color: AppColors.containerGrey,
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: SvgPicture.asset(AppImages.warning),
                    ),
                  ),
                ),
                widthSpace(2),
                Expanded(
                  child: TextButton(
                    onPressed: func1,
                    child: customText(
                        text: 'Report client',
                        fontSize: 14,
                        textColor: AppColors.textGrey),
                  ),
                ),
              ],
            ),
            heightSpace(3)
          ],
        ),
      ),
    );
  }
}
