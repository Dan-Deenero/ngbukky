import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/notification_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class ViewAcceptedBooking extends StatefulWidget {
  final dynamic id;
  const ViewAcceptedBooking({
    super.key,
    required this.id,
  });

  @override
  State<ViewAcceptedBooking> createState() => _ViewAcceptedBookingState();
}

class _ViewAcceptedBookingState extends State<ViewAcceptedBooking> {
  final MechanicRepo _mechanicRepo = MechanicRepo();

  NotificationModel? notifyModel;
  bool isLoading = true;

  var dateString;
  var viewedString;
  var dateTime;
  var viewed;
  var formattedTime;
  var formattedDate;
  var viewedDate;
  var viewedTime;
  var modeling;

  BookingModel? bookingModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mechanicRepo.getoneBooking(widget.id).then(
          (value) => setState(
            () {
              bookingModel = value;
              isLoading = false;
              dateString = bookingModel!.date!;
              dateTime = DateTime.parse(dateString);
              formattedDate = DateFormat('E, d MMM y').format(dateTime);

              formattedTime = DateFormat('hh:mm a').format(dateTime);
            },
          ),
        );
    _mechanicRepo.getOneNotification(widget.id).then(
          (value) => setState(
            () {
              notifyModel = value;
              isLoading = false;
              bookingModel = notifyModel!.booking;
              dateString = notifyModel!.booking!.date!;
              viewedString = notifyModel!.viewedAt;
              dateTime = DateTime.parse(dateString!);
              viewed = DateTime.parse(viewedString!);
              formattedDate = DateFormat('E, d MMM y').format(dateTime);
              formattedTime = DateFormat('hh:mm a').format(dateTime);
              viewedDate = DateFormat('E, d MMM y').format(viewed);
              viewedTime = DateFormat('hh:mm a').format(viewed);
            },
          ),
        );
  }

  finishBooking() async {
    var body = {
      "action": "accepted",
    };
    bool result = await _mechanicRepo.markInspection(body, widget.id);
    if (result) {
      if (context.mounted) {
        context.go(AppRoutes.bottomNav);
        return;
      }
    }
  }

  inspectionComplete() {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          // padding: EdgeInsets.all(10.0),
          width: 700, // Set the desired width
          height: 30.h,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(16.0), // Adjust the radius as needed
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customText(
                        text: 'Inspection completed',
                        fontSize: 20,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w500),
                    InkWell(
                        onTap: () => context.pop(),
                        child: SvgPicture.asset(AppImages.cancelModal))
                  ],
                ),
                heightSpace(1),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customText(
                      text:
                          'Completed the car inspection and is ready to send a quote?',
                      fontSize: 12,
                      textColor: AppColors.black),
                ),
                heightSpace(2),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () => context.go(AppRoutes.bottomNav),
                          child: customText(
                              text: 'No',
                              fontSize: 16,
                              textColor: AppColors.textGrey)),
                      widthSpace(3),
                      Container(
                        width: 1,
                        height: 40,
                        color: AppColors.containerGrey,
                      ),
                      widthSpace(3),
                      TextButton(
                        onPressed: () => context.push(AppRoutes.quotesSend,
                            extra: bookingModel!.id),
                        child: customText(
                          text: 'Yes',
                          fontSize: 16,
                          textColor: AppColors.darkOrange,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  finish() {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          // padding: EdgeInsets.all(10.0),
          width: 700, // Set the desired width
          height: 200,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(16.0), // Adjust the radius as needed
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customText(
                        text: 'Confirm Completion',
                        fontSize: 20,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w500),
                    InkWell(
                        onTap: () => context.pop(),
                        child: SvgPicture.asset(AppImages.cancelModal))
                  ],
                ),
                heightSpace(1),
                customText(
                    text: 'Confirm that you\'ve completed this booking',
                    fontSize: 12,
                    textColor: AppColors.black),
                heightSpace(3),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () => context.pop(),
                          child: customText(
                              text: 'No',
                              fontSize: 16,
                              textColor: AppColors.textGrey)),
                      widthSpace(3),
                      Container(
                        width: 1,
                        height: 40,
                        color: AppColors.containerGrey,
                      ),
                      widthSpace(3),
                      TextButton(
                          onPressed: finishBooking,
                          child: customText(
                              text: 'Yes',
                              fontSize: 16,
                              textColor: AppColors.darkOrange))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void resendOTP() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 9.h,
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
                )),
              ),
            ),
            customText(
                text: "Accepted bookings",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            heightSpace(1),
            bodyText("Send quote or reject booking")
          ]),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: SvgPicture.asset(AppImages.profile),
                    title: customText(
                        text: bookingModel!.user!.username!,
                        fontSize: 15,
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
                        fontSize: 15,
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
                        fontSize: 15,
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
                        fontSize: 15,
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
                        fontSize: 15,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold),
                    subtitle: customText(
                        text: "Year of manufacture",
                        fontSize: 12,
                        textColor: AppColors.textGrey),
                  ),
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
                        fontSize: 15,
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
                        fontSize: 15,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold),
                    subtitle: customText(
                        text: "Scheduled time",
                        fontSize: 12,
                        textColor: AppColors.textGrey),
                  ),
                  heightSpace(2),
                  const Divider(),
                  heightSpace(2),
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
                  heightSpace(2),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: finish,
                        child: Container(
                          width: 30.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                              color: AppColors.containerGrey,
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: customText(
                                  text: "Complete",
                                  fontSize: 15,
                                  textColor: AppColors.black)),
                        ),
                      ),
                      widthSpace(2),
                      Expanded(
                        child: AppButton(
                          onTap: inspectionComplete,
                          hasIcon: false,
                          buttonText: "Send Quote",
                          isOrange: true,
                        ),
                      )
                    ],
                  ),
                  heightSpace(2)
                ],
              ),
            )),
    );
  }
}
