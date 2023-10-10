import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class PDQInspectionDetails extends StatefulWidget {
  final String id;
  const PDQInspectionDetails({super.key, required this.id});

  @override
  State<PDQInspectionDetails> createState() => _PDQInspectionDetailsState();
}

class _PDQInspectionDetailsState extends State<PDQInspectionDetails> {
  final MechanicRepo _mechanicRepo = MechanicRepo();
  final service = TextEditingController();

  bool isLoading = true;
  List<Quotes>? quotes = [];

  QuotesModel? quoteModel;

  int? totalPrice;
  List<Services>? quote = [];

  int price = 0;
  double serviceFee = 0;
  Services? requestedSystemService;
  OtherServices? requestedPersonalisedService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mechanicRepo.getoneQuote(widget.id).then((value) => setState(
          () {
            quoteModel = value;
            isLoading = false;
            quote = quoteModel!.services!;
            for (Quotes quote in quotes!) {
              if (quote.price != null) {
                price += quote.price!;
              }
            }
            serviceFee = price * 0.01;
          },
        ));
  }

  // void resendOTP() async {

  reportClient() {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius as needed
              ),
              contentPadding: const EdgeInsets.all(20.0),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                        text: 'Report client?',
                        fontSize: 24,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w700),
                    InkWell(
                        onTap: () => context.pop(),
                        child: SvgPicture.asset(AppImages.cancelModal))
                  ],
                ),
                heightSpace(1),
                customText(
                    text: 'Do you want to report this client? ',
                    fontSize: 12,
                    textColor: AppColors.black),
                heightSpace(2),
                modalForm('Air conditioning', service, 8),
                heightSpace(1),
                Row(
                  children: [
                    SvgPicture.asset(AppImages.warning),
                    widthSpace(2),
                    Flexible(
                      child: customText(
                          text:
                              'Ensure this action is totally needed, or settle your differences with the client.',
                          fontSize: 11,
                          textColor: AppColors.textGrey),
                    )
                  ],
                ),
                heightSpace(2),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () => context.pop(),
                          child: customText(
                              text: 'cancel',
                              fontSize: 16,
                              textColor: AppColors.textGrey)),
                      Container(
                        width: 1,
                        height: 40,
                        color: AppColors.containerGrey,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: customText(
                              text: 'Send report',
                              fontSize: 16,
                              textColor: AppColors.darkOrange))
                    ],
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: AppColors.backgroundGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
                text: "Inspection details",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            // heightSpace(1),
            bodyText("View all necessary information \nabout this booking ")
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 12.h,
            width: 10.w,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.black),
                color: AppColors.white.withOpacity(.5),
                shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.only(),
              child: Center(
                  child: GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(
                  Icons.close,
                  color: AppColors.black,
                ),
              )),
            ),
          ),
        ],
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
                  Row(
                    children: [
                      widthSpace(5.5),
                      SvgPicture.asset(AppImages.hourGlass),
                      widthSpace(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                              text: 'Quote not approved by client',
                              fontSize: 14,
                              textColor: AppColors.green,
                              fontWeight: FontWeight.w600),
                          customText(
                              text: 'Booking status',
                              fontSize: 12,
                              textColor: AppColors.textGrey)
                        ],
                      )
                    ],
                  ),
                  heightSpace(2),
                  customText(
                      text: "Personal",
                      fontSize: 14,
                      textColor: AppColors.orange,
                      fontWeight: FontWeight.bold),
                  heightSpace(1),
                  ListTile(
                    leading: SvgPicture.asset(AppImages.profile),
                    title: customText(
                        text: quoteModel!.user!.username!,
                        fontSize: 14,
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
                        text: quoteModel!.user!.address!,
                        fontSize: 14,
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
                    leading: SvgPicture.asset(AppImages.calendarIcon),
                    title: customText(
                        text: "${quoteModel!.model!}, $quoteModel!.year!}",
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
                    leading: SvgPicture.asset(AppImages.carIcon),
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
                      text: "Service rendered",
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
                    ],
                  ),
                  heightSpace(1),
                  const Divider(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                              text: 'Sub-total (₦)',
                              fontSize: 13,
                              textColor: AppColors.black),
                          customText(
                              text: '$price',
                              fontSize: 13,
                              textColor: AppColors.black)
                        ],
                      ),
                      heightSpace(2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                              text: 'Ngbuka Charge (1%)',
                              fontSize: 13,
                              textColor: AppColors.black),
                          customText(
                              text: '$serviceFee',
                              fontSize: 13,
                              textColor: AppColors.black)
                        ],
                      ),
                      heightSpace(2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                              text: 'Total',
                              fontSize: 13,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.w600),
                          customText(
                              text: '${price + serviceFee}',
                              fontSize: 13,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.w600)
                        ],
                      )
                    ],
                  ),
                  heightSpace(2),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 30.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                              color: AppColors.containerGrey,
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                            child: SvgPicture.asset(AppImages.warning),
                          ),
                        ),
                      ),
                      widthSpace(2),
                      Expanded(
                        child: TextButton(
                          onPressed: reportClient,
                          child: customText(
                              text: 'Report client',
                              fontSize: 14,
                              textColor: AppColors.textGrey),
                        ),
                      ),
                    ],
                  ),
                  heightSpace(3),
                ],
              ),
            )),
    );
  }

  TextFormField modalForm(
      String hint, TextEditingController control, int line) {
    return TextFormField(
      controller: control,
      maxLines: line,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textformGrey),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textformGrey),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textformGrey),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        contentPadding: const EdgeInsets.only(left: 10, top: 10),
        errorStyle: const TextStyle(fontSize: 14),
      ),
    );
  }
}
