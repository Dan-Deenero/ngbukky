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
import 'package:ngbuka/src/features/presentation/views/mechanic/success_modal.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class InspectionBooking extends StatefulWidget {
  final String id;
  const InspectionBooking({
    super.key,
    required this.id,
  });

  @override
  State<InspectionBooking> createState() => _InspectionBookingState();
}

class _InspectionBookingState extends State<InspectionBooking> {
  final MechanicRepo _mechanicRepo = MechanicRepo();

  bool isLoading = true;

  BookingModel? bookingModel;
  NotificationModel? notifyModel;

  dynamic dateString;
  dynamic dateTime;
  dynamic viewedString;
  dynamic viewed;
  dynamic formattedTime;
  dynamic formattedDate;
  dynamic viewedDate;
  dynamic viewedTime;
  dynamic modeling;

  String username = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mechanicRepo.getoneBooking(widget.id).then(
          (value) => setState(
            () {
              bookingModel = value;
              isLoading = false;
              dateString = bookingModel!.date;
              dateTime =
                  DateTime.parse(dateString!).add(const Duration(hours: 1));
              formattedDate = DateFormat('E, d MMM y').format(dateTime);

              formattedTime = DateFormat('hh:mm a').format(dateTime);
            },
          ),
        );
    // _mechanicRepo.getOneNotification(widget.id).then(
    //       (value) => setState(
    //         () {
    //           notifyModel = value;
    //           isLoading = false;
    //           bookingModel = notifyModel!.booking;
    //           dateString = notifyModel!.booking!.date!;
    //           viewedString = notifyModel!.viewedAt;
    //           dateTime = DateTime.parse(dateString!);
    //           viewed = DateTime.parse(viewedString!);
    //           formattedDate = DateFormat('E, d MMM y').format(dateTime);
    //           formattedTime = DateFormat('hh:mm a').format(dateTime);
    //           viewedDate = DateFormat('E, d MMM y').format(viewed);
    //           viewedTime = DateFormat('hh:mm a').format(viewed);
    //         },
    //       ),
    //     );
  }

  // void resendOTP() async {
  @override
  Widget build(BuildContext context) {
    showSuccesModal() async {
      await showDialog(
        context: context,
        builder: (context) => SuccessDialogue(
          title: 'Proceed to client location',
          subtitle:
              'You can start heading to the client’s location immediately to offer your service.',
          action: () {
            context.go(AppRoutes.bottomNav);
          },
        ),
      );
    }

    acceptBooking() async {
      var body = {
        "action": "accepted",
      };
      bool result = await _mechanicRepo.acceptOrRejectBooking(body, widget.id);
      if (result) {
        showSuccesModal();
      }
    }

    rejectBooking() async {
      var body = {
        "action": "rejected",
      };
      bool result = await _mechanicRepo.acceptOrRejectBooking(body, widget.id);
      if (result) {
        if (context.mounted) {
          context.go(AppRoutes.bottomNav);
          return;
        }
      }
    }

    accept() {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: SizedBox(
            // padding: const EdgeInsets.all(10.0),
            width: 700, // Set the desired width
            height: 220,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16.0), // Adjust the radius as needed
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                            text: 'Confirm acceptance',
                            fontSize: 20,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w500),
                        InkWell(
                          onTap: () => context.pop(),
                          child: SvgPicture.asset(
                            AppImages.cancelModal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  heightSpace(1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: customText(
                        text: 'Confirm that you want to accept this booking',
                        fontSize: 12,
                        textColor: AppColors.black),
                  ),
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
                            textColor: AppColors.textGrey,
                          ),
                        ),
                        widthSpace(3),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppColors.containerGrey,
                        ),
                        widthSpace(3),
                        TextButton(
                          onPressed: () {
                            context.pop();
                            acceptBooking();
                          },
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

    reject() {
      showDialog(
          context: context,
          builder: (context) => Center(
                child: SizedBox(
                  width: 700, // Set the desired width
                  height: 220,
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          16.0), // Adjust the radius as needed
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText(
                                  text: 'Confirm rejection',
                                  fontSize: 20,
                                  textColor: AppColors.black,
                                  fontWeight: FontWeight.w500),
                              InkWell(
                                  onTap: () => context.pop(),
                                  child:
                                      SvgPicture.asset(AppImages.cancelModal))
                            ],
                          ),
                        ),
                        heightSpace(1),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: customText(
                              text:
                                  'Confirm that you want to reject this booking',
                              fontSize: 12,
                              textColor: AppColors.black),
                        ),
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
                                  textColor: AppColors.textGrey,
                                ),
                              ),
                              widthSpace(3),
                              Container(
                                width: 1,
                                height: 40,
                                color: AppColors.containerGrey,
                              ),
                              widthSpace(3),
                              TextButton(
                                onPressed: rejectBooking,
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
              ));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                text: "View inspection booking",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black,
              ),
              heightSpace(1),
              bodyText("Accept or reject booking")
            ],
          ),
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
                        text: '${bookingModel!.user!.username}',
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
                        onTap: reject,
                        child: Container(
                          width: 30.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                              color: AppColors.containerGrey,
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: customText(
                                  text: "Reject",
                                  fontSize: 15,
                                  textColor: AppColors.black)),
                        ),
                      ),
                      widthSpace(2),
                      Expanded(
                        child: AppButton(
                          onTap: accept,
                          hasIcon: false,
                          buttonText: "Accept",
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
