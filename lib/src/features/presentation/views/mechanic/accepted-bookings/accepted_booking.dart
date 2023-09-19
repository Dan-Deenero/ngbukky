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
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class AcceptedBooking extends StatefulWidget {
  const AcceptedBooking({super.key});

  @override
  State<AcceptedBooking> createState() => _AcceptedBookingState();
}

class _AcceptedBookingState extends State<AcceptedBooking> {
  final MechanicRepo _mechanicRepo = MechanicRepo();
  List<BookingModel> _bookingHistory = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getAllBooking('accepted').then((value) => setState(() {
          _bookingHistory = value;
          isLoading = false;
          print(_bookingHistory);
        }));
    // log(_bookingHistory.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
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
              child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                      if (_bookingHistory.isEmpty)
                            Center(
                              heightFactor: 3.5,
                                child: Column(
                              children: [
                                SvgPicture.asset(AppImages.bookingWarning),
                                customText(
                                    text:
                                        'You have not accepted any booking yet',
                                    fontSize: 15,
                                    textColor: AppColors.black)
                              ],
                            ))
                      else
                      ..._bookingHistory.map((e) {
                        var dateString = e.date;
                        var dateTime = DateTime.parse(dateString!);
                        var formattedDate =
                            DateFormat('dd MMM yyyy').format(dateTime);

                        var formattedTime =
                            DateFormat('hh:mm a').format(dateTime);
                        return GestureDetector(
                          onTap: () {
                            context.push(AppRoutes.viewAcceptedBooking,
                                extra: e.id);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                                trailing: Column(children: [
                                  customText(
                                      text: "",
                                      fontSize: 14,
                                      textColor: AppColors.textGrey,
                                      fontWeight: FontWeight.bold),
                                  heightSpace(1),
                                  Container(
                                    width: 28.w,
                                    height: 3.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.green.withOpacity(.1)),
                                    child: Center(
                                      child: customText(
                                          text: "Accepted booking",
                                          fontSize: 10,
                                          textColor: AppColors.green),
                                    ),
                                  )
                                ]),
                                subtitle: Row(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppImages.time),
                                        customText(
                                            text: formattedTime,
                                            fontSize: 10,
                                            textColor: AppColors.textGrey)
                                      ],
                                    ),
                                    widthSpace(1),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            AppImages.calendarIcon),
                                        customText(
                                            text: formattedDate,
                                            fontSize: 10,
                                            textColor: AppColors.textGrey)
                                      ],
                                    )
                                  ],
                                ),
                                title: customText(
                                    text: e.user!.username!,
                                    fontSize: 16,
                                    textColor: AppColors.black,
                                    fontWeight: FontWeight.bold),
                                leading: Container(
                                  width: 10.w,
                                  height: 10.h,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.containerGrey),
                                )),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ],
            )),
    );
  }
}
