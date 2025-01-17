import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/controller/helpers.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class PaymentRequest extends StatefulWidget {
  const PaymentRequest({super.key});

  @override
  State<PaymentRequest> createState() => _PaymentRequestState();
}

class _PaymentRequestState extends State<PaymentRequest> {
  final MechanicRepo _mechanicRepo = MechanicRepo();
  List<BookingModel> _bookingHistory = [];
  List<BookingModel> _bookingHistory2 = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getAllBooking('approved').then((value) => setState(() {
          _bookingHistory = value;
          isLoading = false;
        }));
    _mechanicRepo
        .getAllBooking('awaiting payment')
        .then((value) => setState(() {
              _bookingHistory2 = value;
              isLoading = false;
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
                text: "Payment request",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            heightSpace(1),
            bodyText("Completed bookings awaiting payment")
          ]),
        ),
      ),
      backgroundColor: AppColors.backgroundGrey,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (_bookingHistory.isEmpty && _bookingHistory2.isEmpty)
                    Center(
                        heightFactor: 3.5,
                        child: Column(
                          children: [
                            SvgPicture.asset(AppImages.bookingWarning),
                            customText(
                                text:
                                    'You do not have any booking awaiting client approval',
                                fontSize: 15,
                                textColor: AppColors.black,
                                textAlignment: TextAlign.center)
                          ],
                        ))
                  else
                    ..._bookingHistory.map((e) {
                      int price = 0;
                      for (Quotes quote in e.quotes!) {
                        if (quote.price != null) {
                          price += quote.price!;
                        }
                      }
                      dynamic profile;

                      if (e.user!.profileImageUrl == null) {
                        profile =
                            'https://cdn-icons-png.flaticon.com/512/149/149071.png';
                      } else {
                        profile = e.user!.profileImageUrl!;
                      }
                      return GestureDetector(
                        onTap: () {
                          context.push(
                            AppRoutes.bookingMiddleman,
                            extra: {
                              'id': e.id,
                              'status': e.status,
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            color: Colors.white,
                            surfaceTintColor: Colors.transparent,
                            child: ListTile(
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customText(
                                      text:
                                          "Due: ₦${Helpers.formatBalance(price)}",
                                      fontSize: 15,
                                      textColor: AppColors.orange),
                                  Container(
                                    width: 37.w,
                                    height: 3.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.containerGrey),
                                    child: Center(
                                      child: customText(
                                          text: "Pending payment request",
                                          fontSize: 10,
                                          textColor: AppColors.black),
                                    ),
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
                                child: CircleAvatar(
                                  backgroundColor: AppColors.backgroundGrey,
                                  backgroundImage: NetworkImage(profile),
                                  radius:
                                      55, // Adjust the size of the circle as needed
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ..._bookingHistory2.map(
                    (e) {
                      int price = 0;
                      for (Quotes quote in e.quotes!) {
                        if (quote.price != null) {
                          price += quote.price!;
                        }
                      }
                      String profile;

                      if (e.user!.profileImageUrl == null) {
                        profile =
                            'https://cdn-icons-png.flaticon.com/512/149/149071.png';
                      } else {
                        profile = e.user!.profileImageUrl!;
                      }
                      return GestureDetector(
                        onTap: () {
                          context.push(
                            AppRoutes.bookingMiddleman,
                            extra: {
                              'id': e.id,
                              'status': e.status,
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            color: Colors.white,
                            surfaceTintColor: Colors.transparent,
                            child: ListTile(
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customText(
                                      text:
                                          "Due: ₦${Helpers.formatBalance(price)}",
                                      fontSize: 15,
                                      textColor: AppColors.orange),
                                  Container(
                                    width: 32.w,
                                    height: 3.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.containerGrey,
                                    ),
                                    child: Center(
                                      child: customText(
                                        text: "payment request",
                                        fontSize: 10,
                                        textColor: AppColors.black,
                                      ),
                                    ),
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
                                  color: AppColors.containerGrey,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.backgroundGrey,
                                  backgroundImage: NetworkImage(profile),
                                  radius:
                                      55, // Adjust the size of the circle as needed
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
