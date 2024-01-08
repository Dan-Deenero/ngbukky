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

import '../../../../../core/shared/colors.dart';

class SparePersonalInfo extends ConsumerStatefulWidget {
  const SparePersonalInfo({super.key});

  @override
  ConsumerState<SparePersonalInfo> createState() => _SparePersonalInfoState();
}

class _SparePersonalInfoState extends ConsumerState<SparePersonalInfo> {
  static final phone = TextEditingController();
  static final email = TextEditingController();

  // static final AuthRepo _authRepo = AuthRepo();
  final storeName = TextEditingController();
  final address = TextEditingController();
  final formKey = GlobalKey<FormState>();

  static final MechanicRepo _mechanicRepo = MechanicRepo();

  getDealerProfile() {
    _mechanicRepo.getDealerProfile().then(
      (value) {
        phone.text = value.phoneNumber!;
        email.text = value.email!;
        storeName.text = value.businessName!;
        address.text = value.address!;
        cityController.text = value.city!;
        lgaController.text = value.lga!;
        stateController.text = value.state!;

        ref.read(isLoading.notifier).state = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(isLoading);

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
              final cityState = ref.watch(city);
              final lgaState = ref.watch(lga);

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
                          dropdownList: state,
                          label: "State",
                          onChange: (val) async {
                            stateController.text = val.toString();
                            CityLGA result = await mechanicRepo
                                .getState(val.toString().toLowerCase().trim());
                            ref.read(city.notifier).state =
                                ["Select"] + result.data!.cities!;
                            ref.read(lga.notifier).state =
                                ["Select"] + result.data!.lgas!;
                            setState(() {});
                          },
                        ),
                        heightSpace(1),
                        Column(
                          children: [
                            AppDropdown(
                                isValue: false,
                                value: cityController.text,
                                validator: (val) {
                                  if (val == "select") {
                                    return "Select a city";
                                  }
                                  return null;
                                },
                                dropdownList: cityState,
                                label: "City",
                                onChange: (val) =>
                                    cityController.text = val.toString()),
                            heightSpace(1),
                            AppDropdown(
                                isValue: false,
                                value: lgaController.text,
                                validator: (val) {
                                  if (val == "select") {
                                    return "Select a lga";
                                  }
                                  return null;
                                },
                                dropdownList: lgaState,
                                label: "LGA",
                                onChange: (val) =>
                                    lgaController.text = val.toString()),
                            heightSpace(1),
                            SizedBox(
                              height: 400,
                              child: ListView(
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
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
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      child: Column(
                        children: [
                          heightSpace(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              customText(
                                  text: "Store Info",
                                  fontSize: 18,
                                  textColor: AppColors.primary),
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
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      customText(
                                        text: 'Use my present location',
                                        fontSize: 14,
                                        textColor: AppColors.orange,
                                        textAlignment: TextAlign.right,
                                      ),
                                      widthSpace(2),
                                      SvgPicture.asset(AppImages.googleText),
                                      widthSpace(1),
                                      SvgPicture.asset(AppImages.googleLocs),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                          AppButton(
                            onTap: updateDealerProfile,
                            buttonText: "Send",
                            isOrange: true,
                            hasIcon: false,
                          ),
                          heightSpace(3),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  initState() {
    super.initState();
    getDealerProfile();
  }

  updateDealerProfile() async {
    var data = {
      "businessName": businessName.text,
      "state": stateController.text,
      "lga": lgaController.text,
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
