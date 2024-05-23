import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/domain/data/city_lga.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_dropdown.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_phone_field.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/providers/work_hours.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/shared/colors.dart';

class SpareStoreInfo extends ConsumerStatefulWidget {
  const SpareStoreInfo({super.key});

  @override
  ConsumerState<SpareStoreInfo> createState() => _SpareStoreInfoState();
}

class _SpareStoreInfoState extends ConsumerState<SpareStoreInfo> {
  static final phone = TextEditingController();
  static final email = TextEditingController();

  // static final AuthRepo _authRepo = AuthRepo();
  final formKey = GlobalKey<FormState>();

  static final MechanicRepo _mechanicRepo = MechanicRepo();

  getDealerProfile() {
    _mechanicRepo.getDealerProfile().then(
      (value) {
        String phoneStr = value.phoneNumber.toString();
        String updatedStr = phoneStr.substring(3);
        phone.text = updatedStr;
        email.text = value.email!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final loading = ref.watch(isLoading);

    // ref.read(isLoading.notifier).state = false;
    // double size = MediaQuery.of(context).size.width;

    showLocation() {
      saveData() {
        if (formKey.currentState!.validate()) {
          context.pop();
        }
      }

      showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Consumer(builder: (context, ref, _) {
              final stateState = ref.watch(states);
              final cityState = ref.watch(city);
              final townState = ref.watch(town);
              final statee = ["Select"] + stateState.map((state) => state.name!).toList();
              final cityy = ["Select"] + cityState.map((city) => city.name!).toList();
              final towns = ["Select"] + townState.map((town) => town.name!).toList();
              final loading2 = ref.watch(isLoading2);

              return Form(
                key: formKey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 600,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                            text: "Select your location",
                            fontSize: 18,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.bold),
                        heightSpace(1),
                        customText(
                            text:
                                "Let your clients know your where your business is",
                            fontSize: 14,
                            textColor: AppColors.textColor),
                        heightSpace(1),
                        AppDropdown(
                          isValue: true,
                          value: stateController.text,
                          validator: (val) {
                            if (val == "select") {
                              return "Select a state";
                            }
                            return null;
                          },
                          dropdownList: statee,
                          label: "State",
                          onChange: (val) async {
                            ref.read(isLoading2.notifier).state = true;
                            stateController.text = val.toString();
                            final selectedState = stateState.firstWhere(
                              (state) => state.name == val.toString(),
                              orElse: () =>
                                  States(), // Default value if state is not found
                            );

                            final selectedSlug = selectedState.slug;
                            CityLGA result = await mechanicRepo.getSubdomain(
                                selectedSlug.toString().toLowerCase().trim());
                            ref.read(city.notifier).state =
                                result.data!.cities!;
                            ref.read(town.notifier).state = result.data!.towns!;
                            ref.read(isLoading2.notifier).state = false;
                          },
                        ),
                        heightSpace(1),
                        loading2
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromRGBO(0, 68, 192, 0.10),
                                highlightColor:
                                    const Color.fromARGB(255, 171, 181, 197),
                                child: Container(
                                  width: double.infinity,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(24, 165, 186, 226),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  AppDropdown(
                                      isValue: false,
                                      value: cityController.text,
                                      validator: (val) {
                                        if (val == "Select") {
                                          return "Select a city";
                                        }
                                        return null;
                                      },
                                      dropdownList: cityy,
                                      label: "City",
                                      onChange: (val) =>
                                          cityController.text = val.toString()),
                                  heightSpace(1),
                                  AppDropdown(
                                      isValue: false,
                                      value: lgaController.text,
                                      validator: (val) {
                                        if (val == "Select") {
                                          return "Select a lga";
                                        }
                                        return null;
                                      },
                                      dropdownList: towns,
                                      label: "Town",
                                      onChange: (val) =>
                                          lgaController.text = val.toString()),
                                  heightSpace(1),
                                  SizedBox(
                                    height: 400,
                                    child: ListView(
                                      keyboardDismissBehavior:
                                          ScrollViewKeyboardDismissBehavior
                                              .onDrag,
                                      children: [
                                        CustomTextFormField(
                                          validator: stringValidation,
                                          textEditingController: address,
                                          label: "Street",
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(13.0),
                                            child: SvgPicture.asset(
                                              AppImages.locationIcon,
                                            ),
                                          ),
                                          hintText:
                                              "Type in your business street address",
                                        ),
                                        heightSpace(2),
                                        AppButton(
                                            // isActive: isActive.value,
                                            buttonText: "Save",
                                            isOrange: true,
                                            onTap: saveData),
                                        heightSpace(2),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              );
            });
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: 29.h,
            decoration: const BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(.5),
                      shape: BoxShape.circle),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 7.0),
                    child: Center(
                        child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.white,
                    )),
                  ),
                ),
              ),
              heightSpace(1),
              customText(
                  text: "Enterprise entity",
                  fontSize: 20,
                  textColor: AppColors.white),
              heightSpace(1),
              customText(
                  text: "Help us complete these info and get started",
                  fontSize: 15,
                  textColor: AppColors.white),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  heightSpace(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                          text: "Store Info",
                          fontSize: 18,
                          textColor: AppColors.primary),
                      Row(
                        children: [
                          Container(
                            width: 7.w,
                            height: 7.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.black),
                                shape: BoxShape.circle,
                                color: AppColors.white),
                            child: Center(
                              child: customText(
                                  text: "1",
                                  fontSize: 15,
                                  textColor: AppColors.black),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                            child: Divider(
                              height: 2,
                              color: Color.fromARGB(255, 131, 130, 133),
                            ),
                          ),
                          Container(
                            width: 7.w,
                            height: 7.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.textGrey),
                                shape: BoxShape.circle,
                                color: AppColors.white),
                            child: Center(
                                child: customText(
                                    text: "2",
                                    fontSize: 15,
                                    textColor: AppColors.black)),
                          ),
                        ],
                      )
                    ],
                  ),
                  heightSpace(2),
                  customText(
                    text:
                        'This is information about your store and the manager/handler',
                    fontSize: 14,
                    textColor: AppColors.black,
                  ),
                  heightSpace(4),
                  CustomTextFormField(
                    textEditingController: storeName,
                    label: "Store name",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SvgPicture.asset(
                        AppImages.nameIcon,
                      ),
                    ),
                    hintText: "What is the name of your business",
                  ),
                  heightSpace(2),
                  GestureDetector(
                    onTap: showLocation,
                    child: CustomTextFormField(
                      isEnabled: false,
                      textEditingController: address,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                          AppImages.locationIcon,
                        ),
                      ),
                      label: "Location of your business",
                      hintText: "Enter location",
                    ),
                  ),
                  heightSpace(2),
                  // Padding(
                  //   padding: const EdgeInsets.only(),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () {},
                  //         child: Row(
                  //           children: [
                  //             customText(
                  //               text: 'Use my present location',
                  //               fontSize: 14,
                  //               textColor: AppColors.orange,
                  //               textAlignment: TextAlign.right,
                  //             ),
                  //             widthSpace(2),
                  //             SvgPicture.asset(AppImages.googleText),
                  //             widthSpace(1),
                  //             SvgPicture.asset(AppImages.googleLocs),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  heightSpace(2),
                  AbsorbPointer(
                    absorbing: true,
                    child: Opacity(
                      opacity: 0.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                              text: "Phone number",
                              fontSize: 14,
                              textColor: AppColors.primary),
                          heightSpace(1),
                          CustomPhoneField(
                            controller: phone,
                          ),
                          heightSpace(2),
                          CustomTextFormField(
                            textEditingController: email,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: SvgPicture.asset(
                                AppImages.emailIcon,
                              ),
                            ),
                            label: "Personal email",
                            hintText: "johndoe@gmail.com",
                          ),
                        ],
                      ),
                    ),
                  ),
                  heightSpace(3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightSpace(3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: AppButton(
                              onTap: () => context.push(AppRoutes.spareBusinessInfo),
                              buttonText: "Save",
                              isOrange: true,
                              isSmall: true,
                            ),
                          ),
                          widthSpace(2),
                          Expanded(
                            child: Row(
                              children: [
                                customText(
                                    text: "Next",
                                    fontSize: 15,
                                    textColor: AppColors.textGrey),
                                widthSpace(4),
                                GestureDetector(
                                  onTap: () =>
                                      context.go(AppRoutes.spareBusinessInfo),
                                  child: Container(
                                    height: 13.h,
                                    width: 13.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.textGrey),
                                        color: AppColors.white.withOpacity(.5),
                                        shape: BoxShape.circle),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 7.0),
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.textGrey,
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      heightSpace(3),
                    ],
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getStateList() {
    mechanicRepo.getState().then((value) {
      ref.read(states.notifier).state = value;
    });
  }

  @override
  initState() {
    super.initState();
    getDealerProfile();
    getStateList();
  }

  updateDealerProfile() async {
    var data = {
      "businessName": storeName.text,
      "state": stateController.text,
      "town": lgaController.text,
      "city": cityController.text,
      "address": address.text,
    };

    bool result = await _mechanicRepo.updateDealerProfile(data, 1);
    if (result) {
      if (context.mounted) {
        context.push(AppRoutes.spareBusinessInfo);
      }
    }
  }
}
