import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/statistics_for_quote.dart';
import 'package:ngbuka/src/domain/data/statistics_model.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/booking_things/bookings_provider.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

Widget card(String title, String subtitle, String number, String color) => Card(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: ListTile(
        leading: SvgPicture.asset(
          AppImages.file,
          width: 35,
          height: 35,
        ),
        trailing: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Flexible(
                child: customText(
                    text: title,
                    fontSize: 15,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.bold),
              ),
              widthSpace(2),
              Container(
                  width: 5.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (() {
                        if (color == "red") {
                          return AppColors.red.withOpacity(.3);
                        }
                        if (color == "green") {
                          return AppColors.green.withOpacity(.3);
                        }
                        if (color == "grey") {
                          return AppColors.textGrey.withOpacity(.3);
                        }
                        return AppColors.orange.withOpacity(.3);
                      }())),
                  child: Center(
                    child: customText(
                        text: number,
                        fontSize: 12,
                        textColor: (() {
                          if (color == "red") {
                            return AppColors.red;
                          }
                          if (color == "green") {
                            return AppColors.green;
                          }
                          if (color == "grey") {
                            return AppColors.black;
                          }
                          return AppColors.orange;
                        }())),
                  ))
            ],
          ),
          customText(
              text: subtitle, fontSize: 12, textColor: AppColors.textColor)
        ]),
      ),
    );

class Bookings extends HookWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context) {
    final tabIndex = useState<int>(0);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            13.h,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 60),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                          text: "Bookings",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.black),
                      bodyText("View your bookings and Quotes "),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.notification),
                    child: SvgPicture.asset(AppImages.notification),
                  )
                ],
              ),
            ]),
          ),
        ),
        body: Column(
          children: [
            heightSpace(1),
            Container(
              height: 2.h,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.borderGrey),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.borderGrey,
                  borderRadius: BorderRadius.circular(5)),
              child: TabBar(
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: AppColors.primary,
                labelColor: AppColors.primary,
                indicator: const BoxDecoration(),
                onTap: (value) {
                  tabIndex.value = value;
                },
                tabs: [
                  Container(
                    width: 400,
                    height: 40,
                    decoration: BoxDecoration(
                        color: tabIndex.value == 0
                            ? AppColors.white
                            : AppColors.borderGrey,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Tab(
                      text: "Inspection booking",
                    ),
                  ),
                  Container(
                    width: 400,
                    height: 40,
                    decoration: BoxDecoration(
                        color: tabIndex.value == 1
                            ? AppColors.white
                            : AppColors.borderGrey,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Tab(
                      text: "Quotes",
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  InspectionBookings(),
                  Quotes(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InspectionBookings extends ConsumerWidget {
  const InspectionBookings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(bookingDataProvider);
    return data.when(
      data: (StatisticsModel data) {
        // int cancelled = data.cANCELED ?? 0;
        int pending = data.pENDING ?? 0;
        int accepted = data.aCCEPTED ?? 0;
        int rejected = data.rEJECTED ?? 0;
        int bargaining = data.bARGAINING ?? 0;
        int approved = data.aPPROVED ?? 0;
        int disapproved = data.dISAPPROVED ?? 0;
        int awaitingPayment = data.aWAITINGPAYMENT ?? 0;
        int declined = data.dECLINED ?? 0;
        int completed = data.cOMPLETED ?? 0;
        num total = (awaitingPayment) + (approved);
        
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                heightSpace(2),
                Container(
                  padding: const EdgeInsets.all(13),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: AppColors.borderGrey),
                          top: BorderSide(color: AppColors.borderGrey))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          customText(
                              text: "Paid Bookings",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                          customText(
                              text: "$approved",
                              fontSize: 25,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          heightSpace(1),
                          Container(
                            width: 25.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                                color: AppColors.backgroundGrey,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Center(child: bodyText("This month")),
                            ),
                          )
                        ],
                      ),
                      widthSpace(5),
                      Container(
                        width: 3,
                        height: 70,
                        color: AppColors.containerGrey,
                      ),
                      widthSpace(5),
                      Column(
                        children: [
                          customText(
                              text: "Rejected",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                          customText(
                              text: "$disapproved",
                              fontSize: 25,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          heightSpace(1),
                          Container(
                            width: 25.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                                color: AppColors.backgroundGrey,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Center(child: bodyText("This month")),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.bookingAlert),
                  child: card(
                    "New booking alerts",
                    "New inspection bookings",
                    "$pending",
                    "orange",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.acceptedBooking),
                  child: card(
                    "Accepted booking",
                    "You have accepted these inspection bookings",
                    "$accepted",
                    "orange",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.pendingQuoteApproval),
                  child: card(
                    "Pending client approval",
                    "Quote sent and awaiting client approval",
                    "$bargaining",
                    "orange",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.paymentRequest),
                  child: card(
                    "Payment request",
                    "I have requested for payment for this service",
                    "$total",
                    "grey",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.completedBooking),
                  child: card(
                    "Completed",
                    "Payment made and deal closed",
                    "$completed",
                    "green",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.bookingRejected),
                  child: card(
                    "Booking rejected",
                    "The client rejected your booking quote",
                    "$disapproved",
                    "red",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.paymentDeclined),
                  child: card(
                    "Payment declined",
                    "The client declined these payment",
                    "$declined",
                    "red",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.rejectedBooking),
                  child: card(
                    "Rejected",
                    "You rejected these bookings",
                    "$rejected",
                    "red",
                  ),
                ),
                heightSpace(2),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class Quotes extends ConsumerWidget {
  const Quotes({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(quoteDataProvider);
    return _data.when(
      data: (StatisticsModelForQuote data) {
        int pending = data.pENDING ?? 0;
        int accepted = data.aCCEPTED ?? 0;
        int rejected = data.rEJECTED ?? 0;
        int bargaining = data.bARGAINING ?? 0;
        int approved = data.aPPROVED ?? 0;
        int disapproved = data.dISAPPROVED ?? 0;
        int awaitingPayment = data.aWAITINGPAYMENT ?? 0;
        int declined = data.dECLINED ?? 0;
        int completed = data.cOMPLETED ?? 0;
        num total = (awaitingPayment) + (approved);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                heightSpace(2),
                Container(
                  padding: const EdgeInsets.all(13),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: AppColors.borderGrey),
                          top: BorderSide(color: AppColors.borderGrey))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          customText(
                              text: "Accepted",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                          customText(
                              text: "$accepted",
                              fontSize: 25,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          heightSpace(1),
                          Container(
                            width: 25.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                                color: AppColors.backgroundGrey,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Center(child: bodyText("This month")),
                            ),
                          )
                        ],
                      ),
                      widthSpace(5),
                      Container(
                        width: 3,
                        height: 70,
                        color: AppColors.containerGrey,
                      ),
                      widthSpace(5),
                      Column(
                        children: [
                          customText(
                              text: "Rejected",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                          customText(
                              text: "0",
                              fontSize: 25,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          heightSpace(1),
                          Container(
                            width: 25.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                                color: AppColors.backgroundGrey,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Center(child: bodyText("This month")),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.newQuoteAlert),
                  child: card(
                    "New quote request",
                    "View new quote request",
                    "$pending",
                    "orange",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.acceptedQuotes),
                  child: card(
                    "Accepted quotes",
                    "All your accepted bookings are here",
                    "$accepted",
                    "orange",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.pendingClientApproval),
                  child: card(
                      "Pending Client Approval",
                      "You are awaiting clients approval of quote you sent",
                      "$bargaining",
                      "grey"),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.quotePaymentRequest),
                  child: card(
                    "Payment requests",
                    "Your payment requests",
                    "$total",
                    "grey",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.completedQuoteRequest),
                  child: card(
                    "Completed",
                    "You were paid for these bookings",
                    "$completed",
                    "green",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.quoteRejected),
                  child: card(
                    "Quote Rejected",
                    "The client rejected your sent quote",
                    "$disapproved",
                    "red",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.rejectedQuote),
                  child: card(
                    "Rejected Quotes",
                    "You rejected these quote requests",
                    "$rejected",
                    "red",
                  ),
                ),
                heightSpace(2),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.quotePaymentDecline),
                  child: card(
                    "Declined Payment",
                    "Payment was declined by the client",
                    "$declined",
                    "red",
                  ),
                ),
                heightSpace(2),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}