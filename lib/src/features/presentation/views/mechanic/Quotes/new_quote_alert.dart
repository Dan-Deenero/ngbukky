import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class NewQuoteAlert extends StatefulWidget {
  const NewQuoteAlert({super.key});

  @override
  State<NewQuoteAlert> createState() => _NewQuoteAlertState();
}

class _NewQuoteAlertState extends State<NewQuoteAlert> {
  final MechanicRepo _mechanicRepo = MechanicRepo();
  List<BookingModel> _bookingHistory = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getAllBooking('pending').then((value) => setState(() {
          _bookingHistory = value;
          isLoading = false;
          print(_bookingHistory);
        }));
    // log(_bookingHistory.toString());
  }

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
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    color: AppColors.white.withOpacity(.5),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: EdgeInsets.only(left: 7.0),
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
                  text: "New Quote alerts",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.black),
              heightSpace(1),
              bodyText("View,accept or reject booking")
            ]),
          ),
        ),
        backgroundColor: AppColors.scaffoldColor,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: AppColors.containerGrey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Wrap(
                        children: [
                          // if (_bookingHistory.isEmpty)
                          //   Center(
                          //       heightFactor: 3.5,
                          //       child: Column(
                          //         children: [
                          //           SvgPicture.asset(AppImages.bookingWarning),
                          //           customText(
                          //               text:
                          //                   'There are no new inspection booking requests',
                          //               fontSize: 15,
                          //               textColor: AppColors.black)
                          //         ],
                          //       ))

                          GestureDetector(
                            onTap: () => context.push(AppRoutes.quoteRequest),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(1),
                              width: double.infinity,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: 10.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column())
                                  ]),
                            ),
                          ),

                          heightSpace(3)
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}


// Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 children: [
//                                                   Container(
//                                                     width: 60,
//                                                     height: 20,
//                                                     decoration: BoxDecoration(
//                                                         color: AppColors.green,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(5)),
//                                                     child: Center(
//                                                       child: customText(
//                                                         text: "New",
//                                                         fontSize: 10,
//                                                         textColor:
//                                                             AppColors.white,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   heightSpace(2.2),
//                                                   customText(
//                                                       text: "Car Insepection",
//                                                       fontSize: 12,
//                                                       textColor: AppColors.red),
//                                                 ]),