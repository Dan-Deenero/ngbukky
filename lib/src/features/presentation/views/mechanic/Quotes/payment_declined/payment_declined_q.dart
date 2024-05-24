import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/controller/helpers.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class QPaymentDeclined extends StatefulWidget {
  const QPaymentDeclined({super.key});

  @override
  State<QPaymentDeclined> createState() => _QPaymentDeclinedState();
}

class _QPaymentDeclinedState extends State<QPaymentDeclined> {
  final MechanicRepo _mechanicRepo = MechanicRepo();
  List<QuotesModel> _quoteHistory = [];

  bool isLoading = true;
  List<Quotes>? quotes = [];

  QuotesModel? quoteModel;
  int price = 0;
  double serviceFee = 0;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getAllQuotes('declined').then((value) => setState(() {
          _quoteHistory = value;
          isLoading = false;
        }));
    // log(_bookingHistory.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(21.h),
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
                text: "Payment declined",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            heightSpace(1),
            bodyText("View all payments declined by clients")
          ]),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    if (_quoteHistory.isEmpty)
                      Center(
                          heightFactor: 3.5,
                          child: Column(
                            children: [
                              SvgPicture.asset(AppImages.bookingWarning),
                              customText(
                                  text: 'You do not have any declined payment',
                                  fontSize: 15,
                                  textColor: AppColors.black)
                            ],
                          ))
                    else
                      ..._quoteHistory.map(
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
                          var dateString = e.createdAt;
                          var dateTime = DateTime.parse(dateString!);
                          var formattedDate =
                              DateFormat('dd MMM yyyy').format(dateTime);

                          var formattedTime =
                              DateFormat('hh:mm a').format(dateTime);
                          return GestureDetector(
                            onTap: () => context.push(
                              AppRoutes.quoteMiddlemen,
                              extra: {
                                'id': e.id,
                                'status': e.status,
                              },
                            ),
                            child: Card(
                              color: Colors.white,
                              surfaceTintColor: Colors.transparent,
                              child: ListTile(
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    customText(
                                        text:
                                            "₦${Helpers.formatBalance(price)}",
                                        fontSize: 14,
                                        textColor: AppColors.textGrey,
                                        fontWeight: FontWeight.bold),
                                    heightSpace(1),
                                    Container(
                                      width: 28.w,
                                      height: 3.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.red.withOpacity(.2)),
                                      child: Center(
                                        child: customText(
                                          text: "Payment declined",
                                          fontSize: 10,
                                          textColor: AppColors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppImages.time),
                                        customText(
                                            text: formattedTime,
                                            fontSize: 2.4.w,
                                            textColor: AppColors.textGrey)
                                      ],
                                    ),
                                    widthSpace(.5),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            AppImages.calendarIcon),
                                        customText(
                                            text: formattedDate,
                                            fontSize: 2.4.w,
                                            textColor: AppColors.textGrey)
                                      ],
                                    )
                                  ],
                                ),
                                title: customText(
                                  text: e.user!.username!,
                                  fontSize: 16,
                                  textColor: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
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
                          );
                        },
                      )
                  ],
                ),
              ),
            ),
    );
  }
}
