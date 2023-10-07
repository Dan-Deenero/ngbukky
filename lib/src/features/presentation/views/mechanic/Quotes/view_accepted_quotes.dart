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

class ViewAcceptedQuote extends StatefulWidget {
  final String id;
  const ViewAcceptedQuote({super.key, required this.id});

  @override
  State<ViewAcceptedQuote> createState() => _ViewAcceptedQuoteState();
}

class _ViewAcceptedQuoteState extends State<ViewAcceptedQuote> {
  final MechanicRepo _mechanicRepo = MechanicRepo();

  bool isLoading = true;

  QuotesModel? quoteModel;
  List<Services>? quote = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mechanicRepo.getoneQuote(widget.id).then((value) => setState(
          () {
            quoteModel = value;
            quote = quoteModel!.services!;
            isLoading = false;
          },
        ));
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
                text: "Accepted Quotes",
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
                              text: quoteModel!.user!.username!,
                              fontSize: 14,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          subtitle: customText(
                              text: "username",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                        ),
                        heightSpace(1),
                        ListTile(
                          leading: SvgPicture.asset(AppImages.locationIcon),
                          title: customText(
                              text: "Elijiji rd, close 20, Woji, Port Harcourt",
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
                        text: 'AC Maintenance',
                        fontSize: 14,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold),
                    subtitle: customText(
                        text: 'Service selected',
                        fontSize: 12,
                        textColor: AppColors.textGrey),
                  ),
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
                      ...quote!.map(
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
                                text:
                                    'My AC keeps loosing cold air. I have replaced it with a brand new AC  but ater a while, it stops working',
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
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Container(
                      //     width: 30.w,
                      //     height: 7.h,
                      //     decoration: BoxDecoration(
                      //         color: AppColors.containerGrey,
                      //         borderRadius: BorderRadius.circular(25)),
                      //     child: Center(
                      //         child: customText(
                      //             text: "",
                      //             fontSize: 15,
                      //             textColor: AppColors.black)),
                      //   ),
                      // ),
                      widthSpace(2),
                      Expanded(
                        child: InkWell(
                          onTap: () => context.push(AppRoutes.sendQuotes),
                          child: const AppButton(
                            hasIcon: false,
                            buttonText: "Send Quote",
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
