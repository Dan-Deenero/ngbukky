import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
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
            10.h,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                      text: "Bookings",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.black),
                  SvgPicture.asset(AppImages.notification)
                ],
              ),
              bodyText("View your bookings and Quotes "),
              heightSpace(2)
            ]),
          ),
        ),
        body: Column(
          children: [
            heightSpace(4),
            Container(
              height: 2.h,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.borderGrey),
                )
              ),
            ),
            Container(
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
              child: TabBarView(children: [InspectionBookings(), Quotes()]),
            )
          ],
        ),
      ),
    );
  }
}

class InspectionBookings extends StatelessWidget {
  const InspectionBookings({super.key});

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
              child: card("New booking alerts", "New inspection bookings", "0",
                  "orange"),
            ),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.acceptedBooking),
              child: card("Accepted booking",
                  "You have accepted these inspection bookings", "1", "orange"),
            ),
            heightSpace(2),
            card("Pending client approval",
                "You have accepted these inspection bookings", "1", "orange"),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.paymentRequest),
              child: card("Payment request",
                  "You have accepted these inspection bookings", "1", "grey"),
            ),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.completedBooking),
              child: card("Completed",
                  "You have accepted these inspection bookings", "30", "green"),
            ),
            heightSpace(2),
            GestureDetector(
              onTap: () => context.push(AppRoutes.paymentDeclined),
              child: card("Payment declined",
                  "You have accepted these inspection bookings", "2", "red"),
            ),
            heightSpace(2),
            card("Rejected", "You have accepted these inspection bookings", "4",
                "red"),
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
