import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class QuoteRequests extends StatefulWidget {
  final String id;
  const QuoteRequests({super.key, required this.id});

  @override
  State<QuoteRequests> createState() => _QuoteRequestsState();
}

class _QuoteRequestsState extends State<QuoteRequests> {
  final MechanicRepo _mechanicRepo = MechanicRepo();
  bool isLoading = true;
  QuotesModel? quoteModel;
  String uName = 'Kels2332';

  List<Services>? quote = [];
  List<Services>? otherQuote = [];
  List<Services>? serviceTogether = [];

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getoneQuote(widget.id).then(
          (value) => setState(
            () {
              quoteModel = value;
              isLoading = false;
              quote = quoteModel!.services!;
              otherQuote = quoteModel!.otherServices!;
              serviceTogether = quote! + otherQuote!;
              log(quote.toString());
              uName = quoteModel!.user!.username!;
            },
          ),
        );
  }

  acceptQuoteRequest() async {
    var body = {
      "action": "accepted",
    };
    bool result = await _mechanicRepo.acceptOrRejectQuote(body, widget.id);
    if (result) {
      if (context.mounted) {
        context.go(AppRoutes.sendQuotes, extra: quoteModel!.id);
        return;
      }
    }
  }

  rejectQuoteRequest() async {
    var body = {
      "action": "rejected",
    };
    bool result = await _mechanicRepo.acceptOrRejectQuote(body, widget.id);
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
                width: 700, // Set the desired width
                height: 220,
                child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ), // Adjust the radius as needed
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                child: SvgPicture.asset(AppImages.cancelModal))
                          ],
                        ),
                      ),
                      heightSpace(1),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: customText(
                            text:
                                'Confirm that you want to accept this quote request',
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
                                    textColor: AppColors.textGrey)),
                            widthSpace(3),
                            Container(
                              width: 1,
                              height: 40,
                              color: AppColors.containerGrey,
                            ),
                            widthSpace(3),
                            TextButton(
                              onPressed: acceptQuoteRequest,
                              child: customText(
                                text: 'Yes',
                                fontSize: 16,
                                textColor: AppColors.darkOrange,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
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
              borderRadius:
                  BorderRadius.circular(16.0), // Adjust the radius as needed
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                          child: SvgPicture.asset(AppImages.cancelModal))
                    ],
                  ),
                ),
                heightSpace(1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: customText(
                      text:
                          'Confirm that you want to reject this quote request',
                      fontSize: 12,
                      textColor: AppColors.black),
                ),
                heightSpace(3),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: rejectQuoteRequest,
                          child: customText(
                              text: 'Yes',
                              fontSize: 16,
                              textColor: AppColors.darkOrange)),
                      widthSpace(3),
                      Container(
                        width: 1,
                        height: 40,
                        color: AppColors.containerGrey,
                      ),
                      widthSpace(3),
                      TextButton(
                        onPressed: () => context.pop(),
                        child: customText(
                          text: 'No',
                          fontSize: 16,
                          textColor: AppColors.textGrey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
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
                height: 9.h,
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
                text: "Quote Request",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            heightSpace(1),
            bodyText("Accept or reject quote")
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
                  heightSpace(2),
                  Container(
                    padding: const EdgeInsets.symmetric(),
                    decoration:
                        const BoxDecoration(color: AppColors.backgroundGrey),
                    child: Column(
                      children: [
                        ListTile(
                          leading: SvgPicture.asset(AppImages.profile),
                          title: customText(
                              text: uName,
                              fontSize: 14,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          subtitle: customText(
                              text: "Username",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                        ),
                        heightSpace(1),
                        ListTile(
                          leading: SvgPicture.asset(AppImages.locationIcon),
                          title: customText(
                              text: quoteModel!.user!.address!,
                              fontSize: 14,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          subtitle: customText(
                              text: "Location",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                        ),
                      ],
                    ),
                  ),
                  heightSpace(1),
                  ListTile(
                    leading: SvgPicture.asset(AppImages.carIcon),
                    title: customText(
                        text: quoteModel!.brand!,
                        fontSize: 14,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold),
                    subtitle: customText(
                        text: 'Car brand',
                        fontSize: 12,
                        textColor: AppColors.textGrey),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(AppImages.carIcon),
                    title: customText(
                        text: '${quoteModel!.model}, ${quoteModel!.year}',
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
                    leading: SvgPicture.asset(AppImages.calendarIcon),
                    title: customText(
                        text: '${quoteModel!.year!}',
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
                      text: "Service requested",
                      fontSize: 14,
                      textColor: AppColors.orange,
                      fontWeight: FontWeight.bold),
                  heightSpace(3),
                  Column(
                    children: [
                      ...serviceTogether!.map(
                        (qte) {
                          return Row(
                            children: [
                              SvgPicture.asset(AppImages.serviceIcon),
                              widthSpace(2),
                              customText(
                                  text: qte.name!,
                                  fontSize: 13,
                                  textColor: AppColors.black,
                                  fontWeight: FontWeight.w600),
                              heightSpace(4),
                            ],
                          );
                        },
                      ),
                      heightSpace(4),
                    ],
                  ),
                  heightSpace(2),
                  const Divider(),
                  heightSpace(2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AppImages.serviceIcon),
                      widthSpace(2),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                                text: "${quoteModel!.description}",
                                fontSize: 13,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w600),
                            customText(
                              text: 'Message from Car owner',
                              fontSize: 13,
                              textColor: AppColors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
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
                        child: InkWell(
                          onTap: accept,
                          child: const AppButton(
                            hasIcon: false,
                            buttonText: "Accept request",
                            isOrange: true,
                          ),
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
