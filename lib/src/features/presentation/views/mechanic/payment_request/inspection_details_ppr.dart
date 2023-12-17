import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/success_modal.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class PPRInspectionDetails extends StatefulWidget {
  final String id;
  const PPRInspectionDetails({super.key, required this.id});

  @override
  State<PPRInspectionDetails> createState() => _PPRInspectionDetailsState();
}

class _PPRInspectionDetailsState extends State<PPRInspectionDetails> {
  final MechanicRepo _mechanicRepo = MechanicRepo();

  List<Quotes>? quotes = [];

  bool isLoading = true;
  BookingModel? bookingModel;
  var dateString;
  var formattedDate;
  var formattedTime;
  var dateTime;

  int price = 0;
  double serviceFee = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mechanicRepo.getoneBooking(widget.id).then((value) => setState(
          () {
            bookingModel = value;
            dateString = bookingModel!.date;
            dateTime = DateTime.parse(dateString!);
            formattedDate = DateFormat('E, d MMM y').format(dateTime);
            formattedTime = DateFormat('hh:mm a').format(dateTime);
            isLoading = false;
            quotes = bookingModel!.quotes;
            for (Quotes quote in quotes!) {
              if (quote.price != null) {
                price += quote.price!;
              }
            }
            serviceFee = price * 0.01;
          },
        ));
  }

  completeBooking() async {
    var body = {
      "": "",
    };
    bool result =
        await _mechanicRepo.markInspectionAsCompleted(body, widget.id);
    if (result) {
      if (context.mounted) {
        context.pop();
        return;
      }
    }
  }

  showCompletedModal() {
    showDialog(
      context: context,
      builder: (context) => SuccessDialogue(
          title: 'Complete booking',
          subtitle:
              'Your have completed your booking and requested for payment from Kels2323',
          action: () => context.go(AppRoutes.paymentRequest)),
    );
  }

  completedBooking() {
    completeBooking();
    showCompletedModal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: AppColors.backgroundGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
                text: "Inspection details",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            // heightSpace(1),
            bodyText("View all necessary information \nabout this booking ")
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 12.h,
            width: 10.w,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.black),
                color: AppColors.white.withOpacity(.5),
                shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.only(),
              child: Center(
                  child: GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(
                  Icons.close,
                  color: AppColors.black,
                ),
              )),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                              text: 'Pending payment request',
                              fontSize: 14,
                              textColor: AppColors.black,
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
                        text: bookingModel!.user!.username!,
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
                        text: bookingModel!.user!.address!,
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
                        text: bookingModel!.brand!,
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
                        text: "${bookingModel!.model!}, ${bookingModel!.year!}",
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
                        text: '${bookingModel!.year!}',
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
                  ...quotes!.map((quote) {
                    String serviceName = '';
                    if (quote.requestedPersonalisedService != null) {
                      serviceName = quote.requestedPersonalisedService!.name!;
                    } else if (quote.requestedSystemService != null) {
                      serviceName = quote.requestedSystemService!.name!;
                    }
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppImages.serviceIcon),
                                widthSpace(2),
                                customText(
                                    text: serviceName,
                                    fontSize: 13,
                                    textColor: AppColors.black,
                                    fontWeight: FontWeight.w600),
                              ],
                            ),
                            customText(
                                text: '${quote.price!}',
                                fontSize: 13,
                                textColor: AppColors.black)
                          ],
                        ),
                        heightSpace(4),
                      ],
                    );
                  }),
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
                              text: 'Total',
                              fontSize: 13,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.w600),
                          customText(
                              text: '$price',
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
                        child: AppButton(
                          onTap: completedBooking,
                          hasIcon: false,
                          buttonText: "Complete Booking",
                          isOrange: true,
                        ),
                      ),
                    ],
                  ),
                  heightSpace(3),
                ],
              ),
            )),
    );
  }
}
