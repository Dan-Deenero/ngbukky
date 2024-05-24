import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/success_modal.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

import '../../../../../core/shared/colors.dart';

class SendQuote extends ConsumerStatefulWidget {
  final String id;
  const SendQuote({super.key, required this.id});

  @override
  ConsumerState<SendQuote> createState() => _SendQuoteState();
}

class _SendQuoteState extends ConsumerState<SendQuote> {
  final MechanicRepo _mechanicRepo = MechanicRepo();
  static final costOnly = TextEditingController();

  bool isLoading = true;

  QuotesModel? quoteModel;
  List<Services>? quote = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _mechanicRepo.getoneQuote(widget.id).then(
          (value) => setState(
            () {
              quoteModel = value;
              quote = quoteModel!.services!;
              isLoading = false;
            },
          ),
        );
  }

  sendQuote() async {
    var data = {};
    data = {"isOnlyAmount": 'true', "amount": costOnly.text};

    bool result = await _mechanicRepo.sendQuoteForQuotes(data, widget.id);
    log(result.toString());

    if (result) {
      costOnly.clear();
      showSuccesModal();
    }
  }
showSuccesModal()
   async {
    await showDialog(
      context: context,
      builder: (context) => SuccessDialogue(
        title: 'Quote sent',
        subtitle:
            'Your quote of ${costOnly.text} has been sent successfully to ${quoteModel!.user!.username!}',
        action: () {
          context.go(AppRoutes.bottomNav);
        },
      ),
    );
  }

  String isOnlyAmount = 'true';

  BookingModel? bookingModel;

  int subtotal = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(16.h),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(
                    text: "Send Quote",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.black),
                GestureDetector(
                  onTap: () => context.go(AppRoutes.bottomNav),
                  child: Container(
                    height: 10.h,
                    width: 10.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.black),
                        color: AppColors.white.withOpacity(.5),
                        shape: BoxShape.circle),
                    child: Center(child: SvgPicture.asset(AppImages.badIcon)),
                  ),
                ),
              ],
            ),
            bodyText("Let the client know what it will cost")
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
                      ],
                    ),
                    heightSpace(3),
                    CustomTextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textEditingController: costOnly,
                      label: "Service",
                      hintText: "Enter your service cost (₦)",
                      keyboardType: TextInputType.number,
                      validator: numericValidation,
                    ),
                    heightSpace(2),
                    heightSpace(8),
                    Container(
                      margin: const EdgeInsets.only(top: 180),
                      child: Column(
                        children: [
                          const Divider(),
                          heightSpace(3),
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
                          heightSpace(4),
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
                                      child: customText(
                                          text: "Cancel",
                                          fontSize: 15,
                                          textColor: AppColors.black)),
                                ),
                              ),
                              widthSpace(2),
                              Expanded(
                                child: AppButton(
                                  onTap: sendQuote,
                                  hasIcon: false,
                                  buttonText: "Send now",
                                  isOrange: true,
                                ),
                              ),
                            ],
                          ),
                          heightSpace(2),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
