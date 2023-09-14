import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

Widget card(String title, String subtitle, String number, String color) =>
    Container(
      width: double.infinity,
      height: 12.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColors.white),
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
  static final MechanicRepo _mechanicRepo = MechanicRepo();

  Bookings({super.key});

  @override
  Widget build(BuildContext context) {
    final pending = useState<int?>(0);
    final declined = useState<int?>(0);
    final completed = useState<int?>(0);
    final accepted = useState<int?>(0);
    final rejected = useState<int?>(0);
    final bargaining = useState<int?>(0);
    final approved = useState<int?>(0);
    final disapproved = useState<int?>(0);
    final awaitingPayment = useState<int?>(0);

    getStatisticsInfo() {
      _mechanicRepo.getStatisticsInfo().then((value) {
        pending.value = value.pENDING;
        declined.value = value.dECLINED;
        completed.value = value.cOMPLETED;
        accepted.value = value.aCCEPTED;
        rejected.value = value.rEJECTED;
        bargaining.value = value.bARGAINING;
        approved.value = value.aPPROVED;
        disapproved.value = value.dISAPPROVED;
        awaitingPayment.value = value.aWAITINGPAYMENT;
      });
    }

    final tabIndex = useState<int>(0);
    useEffect(() {
      getStatisticsInfo();
      return null;
    }, []);
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
                  SvgPicture.asset(AppImages.notification)
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
              )),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
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
            Expanded(
              child: TabBarView(children: [
                InspectionBookings(
                  pending: pending.value,
                  declined: declined.value,
                  completed: completed.value,
                  accepted: accepted.value,
                  rejected: rejected.value,
                  bargaining: bargaining.value,
                  approved: approved.value,
                  disapproved: disapproved.value,
                  awaitingPayment: awaitingPayment.value,
                ),
                Quotes()
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class InspectionBookings extends StatelessWidget {
  final int? pending;
  final int? declined;
  final int? completed;
  final int? accepted;
  final int? rejected;
  final int? bargaining;
  final int? approved;
  final int? disapproved;
  final int? awaitingPayment;

  const InspectionBookings(
      {super.key,
      this.pending,
      this.declined,
      this.completed,
      this.accepted,
      this.rejected,
      this.bargaining,
      this.approved,
      this.disapproved,
      this.awaitingPayment});

  @override
  Widget build(BuildContext context) {
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
              onTap: ()  => context.push(AppRoutes.bookingAlert),
              child: card("New booking alerts", "New inspection bookings",
                  "$pending", "orange"),
            ),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.acceptedBooking),
              child: card(
                  "Accepted booking",
                  "You have accepted these inspection bookings",
                  "$accepted",
                  "orange"),
            ),
            heightSpace(2),
            card(
                "Pending client approval",
                "Done with requirements, awaiting client approval",
                "$bargaining",
                "orange"),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.paymentRequest),
              child: card(
                  "Payment request",
                  "Done with requirements, awaiting client approval",
                  "$awaitingPayment",
                  "grey"),
            ),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.completedBooking),
              child: card(
                  "Completed",
                  "Payment made and deal closed",
                  "$completed",
                  "green"),
            ),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.completedBooking),
              child: card(
                  "Booking rejected",
                  "The client rejected your booking quote",
                  "$completed",
                  "green"),
            ),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.paymentDeclined),
              child: card(
                  "Payment declined",
                  "The client declined these payment",
                  "$declined",
                  "red"),
            ),
            heightSpace(2),
            card("Rejected", "You rejected these booking quote",
                "$rejected", "red"),
          ],
        ),
      ),
    );
  }
}

class Quotes extends StatelessWidget {
  const Quotes({super.key});

  @override
  Widget build(BuildContext context) {
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
              onTap: () => context.push(AppRoutes.bookingAlert),
              child: card(
                  "New quote request", "View new quote request", "0", "orange"),
            ),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.acceptedBooking),
              child: card("Accepted quotes",
                  "All you accepted bookings are here", "1", "orange"),
            ),
            heightSpace(2),
            card(
                "Pending booking request",
                "YYou sent yoru quote to a client for some services",
                "1",
                "grey"),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.paymentRequest),
              child:
                  card("Payment request", "Your payment requests", "1", "grey"),
            ),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.completedBooking),
              child: card("Completed", "You were paid for these bookings", "30",
                  "green"),
            ),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.paymentDeclined),
              child: card("Rejected", "You rejected these offers", "2", "red"),
            ),
            heightSpace(2),
            card("Declined", "Quotation is declined by the client", "4", "red"),
          ],
        ),
      ),
    );
  }
}
