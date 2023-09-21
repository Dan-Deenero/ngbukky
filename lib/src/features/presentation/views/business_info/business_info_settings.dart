import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/domain/data/city_lga.dart';
import 'package:ngbuka/src/domain/data/services_model.dart';
import 'package:ngbuka/src/domain/data/user_model.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_dropdown.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/dropdown_search.dart';
import 'package:ngbuka/src/features/providers/work_hours.dart';
import 'package:ngbuka/src/utils/extensions/index_of_map.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

import '../../../../core/shared/colors.dart';

class BusinessInfoSettings extends ConsumerStatefulWidget {
  const BusinessInfoSettings({super.key});

  @override
  ConsumerState<BusinessInfoSettings> createState() =>
      _BusinessInfoSettingsState();
}

class _BusinessInfoSettingsState extends ConsumerState<BusinessInfoSettings> {
  static final AuthRepo _authRepo = AuthRepo();
  List<String> serviceList = [];
  List<String> selectedServiceList = [];
  List<String> serveList = [];
  List<String> otherList = [];
  List<Services> otherServiceList = [];
  List<String> selectServiceList = [];
  List<Services> service = [];
  final formKey = GlobalKey<FormState>();

  List<String> carsList = [];

  getBusinessProfile() {
    _authRepo.getMechanicProfile().then((value) {
      // String availabilityString = jsonEncode(value.availability!);
      service = value.services!;
      otherServiceList = value.otherServices!;
      serveList = service.map((service) => service.name!).toList();
      otherList = otherServiceList.map((service) => service.name!).toList();
      serveList = serveList + otherList;
      businessName.text = value.businessName!;
      cac.text = value.cacNumber!;
      address.text = value.address!;
      cityController.text = value.city!;
      // lgaController.text = value.lga!;
      // stateController.text = value.state!;
      carsList = value.cars!;
      // selectedServiceList = services.cast<String>();
      // workingHourController.text = availabilityString;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(isLoading);
    // final userModel = useState<UserModel?>(null);
    final workingHour = ref.watch(stateWorkingHours);

    workingHours() {
      saveData() {
        List<String> trueItemsString = [];

        for (var item in workingHour) {
          if (item["isChecked"]) {
            if (item["isChecked"]) {
              var itemString =
                  "from: ${item["from"]}, to: ${item["to"]}, Day: ${item["day"]}";
              trueItemsString.add(itemString);
            }
          }
        }
        workingHourController.text = trueItemsString.join(', ');
        context.pop();
      }

      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Consumer(builder: (BuildContext context, ref, child) {
              final workingHour = ref.watch(stateWorkingHours);
              return Container(
                  color: AppColors.backgroundGrey,
                  padding: const EdgeInsets.all(20),
                  height: 500,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                              text: "Working Hours",
                              fontSize: 18,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold),
                          heightSpace(1),
                          customText(
                            text: "Let your clients know your working hours",
                            fontSize: 12,
                            textColor: AppColors.black,
                          ),
                          heightSpace(2),
                          Row(
                            children: [
                              Expanded(
                                child: customText(
                                  text: "Days",
                                  fontSize: 15,
                                  textColor: AppColors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  customText(
                                    text: "From",
                                    fontSize: 12,
                                    textColor: AppColors.textGrey,
                                  ),
                                  widthSpace(2),
                                  customText(
                                    text: "AM",
                                    fontSize: 12,
                                    textColor: AppColors.black,
                                  ),
                                  widthSpace(2),
                                  customText(
                                    text: "PM",
                                    fontSize: 12,
                                    textColor: AppColors.black,
                                  ),
                                ],
                              )
                            ],
                          ),
                          heightSpace(2),
                          ...workingHour.mapIndexed((e, index) {
                            return Row(
                              children: [
                                e["isChecked"]
                                    ? GestureDetector(
                                        onTap: () {
                                          log("one two");
                                          ref
                                                  .read(stateWorkingHours.notifier)
                                                  .state[index]["isChecked"] =
                                              !ref
                                                  .read(stateWorkingHours
                                                      .notifier)
                                                  .state[index]["isChecked"];

                                          log(ref
                                              .read(stateWorkingHours.notifier)
                                              .state[index]["isChecked"]
                                              .toString());

                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 10),
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: AppColors.white),
                                          child: Row(children: [
                                            Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: AppColors.darkOrange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(1.0),
                                                  child: Icon(Icons.check,
                                                      color: AppColors.white,
                                                      size: 15),
                                                )),
                                            widthSpace(2),
                                            customText(
                                                text: e["day"],
                                                fontSize: 12,
                                                textColor: AppColors.black)
                                          ]),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          log("one two");
                                          ref
                                                  .read(stateWorkingHours.notifier)
                                                  .state[index]["isChecked"] =
                                              !ref
                                                  .read(stateWorkingHours
                                                      .notifier)
                                                  .state[index]["isChecked"];

                                          log(ref
                                              .read(stateWorkingHours.notifier)
                                              .state[index]["isChecked"]
                                              .toString());
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 10),
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: AppColors.white),
                                          child: Row(children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors
                                                          .containerGrey),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                            widthSpace(2),
                                            customText(
                                                text: e["day"],
                                                fontSize: 15,
                                                textColor: AppColors.black)
                                          ]),
                                        ),
                                      ),
                                SvgPicture.asset(AppImages.edit),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? result =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),                                            
                                            initialEntryMode:
                                                TimePickerEntryMode.input);

                                    if (result != null) {
                                      if (context.mounted) {
                                        setState(() {
                                          String res;
                                          if (result.minute < 10) {
                                            res =
                                                '0${result.minute.toString()}';
                                          } else {
                                            res = result.minute.toString();
                                          }
                                          workingHour[index]["from"] =
                                              '${result.hour.toString()}:$res';
                                        });
                                      }
                                    }
                                  },
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          border: Border.all(
                                              color: AppColors.white),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: customText(
                                            text: e["from"],
                                            fontSize: 15,
                                            textColor: AppColors.black),
                                      )),
                                ),
                                widthSpace(4),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? result =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      initialEntryMode: TimePickerEntryMode.input
                                    );

                                    if (result != null) {
                                      if (context.mounted) {
                                        setState(() {
                                          String ses;
                                          if(result.minute < 10){
                                            ses = '0${result.minute.toString()}';
                                          }else{
                                            ses = result.minute.toString();
                                          }
                                          workingHour[index]["to"] =
                                              '${result.hour.toString()}:$ses';
                                        });
                                      }
                                    }
                                  },
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          border: Border.all(
                                              color: AppColors.white),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: customText(
                                            text: e["to"],
                                            fontSize: 15,
                                            textColor: AppColors.black),
                                      )),
                                ),
                              ],
                            );
                          }),
                          AppButton(
                              // isActive: isActive.value,
                              buttonText: "Save",
                              isOrange: true,
                              onTap: saveData),
                          heightSpace(2),
                        ]),
                  ));
            });
          });
        },
      );
    }

    showLocation() {
      saveData() {
        if (formKey.currentState!.validate()) {
          context.pop();
        }
      }

      showModalBottomSheet<void>(
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
                    height: 500,
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
                              // isValue: true,
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
                                CityLGA result = await mechanicRepo.getState(
                                    val.toString().toLowerCase().trim());
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
                                    // isValue: false,
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
                                    // isValue: false,
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
                              ],
                            ),
                            heightSpace(2),
                            AppButton(
                                // isActive: isActive.value,
                                buttonText: "Save",
                                isOrange: true,
                                onTap: saveData),
                            heightSpace(2),
                          ]),
                    )),
              );
            });
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 25.h,
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
                            text: "Edit your business information",
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
                                text: "Business information",
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                textColor: AppColors.primary),
                          ],
                        ),
                        heightSpace(4),
                        CustomTextFormField(
                          textEditingController: businessName,
                          label: "Business name",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: SvgPicture.asset(
                              AppImages.nameIcon,
                            ),
                          ),
                          hintText: "What is the name of your business",
                        ),
                        heightSpace(2),
                        CustomTextFormField(
                          textEditingController: cac,
                          label: "CAC",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: SvgPicture.asset(
                              AppImages.nameIcon,
                            ),
                          ),
                          hintText: "Type in business registration number",
                        ),
                        heightSpace(2),
                        CustomTextFormField(
                          textEditingController: address,
                          onTap: showLocation,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: SvgPicture.asset(
                              AppImages.locationIcon,
                            ),
                          ),
                          label: "Location of your business",
                          hintText: "Enter location",
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
                        heightSpace(3),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                                text: "What cars are you familiar with?",
                                fontSize: 14,
                                textColor: AppColors.black),
                            heightSpace(1),
                            AppDropdDownSearch(
                              listOfSelectedItems: carsList,
                              hintText: "Select cars",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: SvgPicture.asset(
                                  AppImages.mechanicIcon,
                                ),
                              ),
                              selectedItems: const [
                                'None',
                                'Toyota',
                                'Honda',
                                'Ford',
                                'BMW',
                                'Audi',
                                'Lexus',
                                'Nissan',
                                'Mercedes-Benz',
                                'Volkswagen',
                                'Tesla',
                                'Chevrolet'
                                    'Others'
                              ],
                              // onChanged: onChanged,
                            ),
                            heightSpace(2),
                            customText(
                                text: "List of Services",
                                fontSize: 14,
                                textColor: AppColors.black),
                            heightSpace(1),
                            AppDropdDownSearch(
                              listOfSelectedItems: serveList,
                              onChanged: (val) {
                                selectedServiceList = val!;
                                log(val.toString());
                                return null;
                              },
                              hintText: "Select your list of services",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: SvgPicture.asset(
                                  AppImages.serviceIcon,
                                ),
                              ),
                              selectedItems: serviceList,
                              // onChanged: onChanged,
                            ),
                            heightSpace(4),
                            customText(
                                text: "Availabiity",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                textColor: AppColors.black),
                            heightSpace(2),
                            CustomTextFormField(
                              textEditingController: workingHourController,
                              onTap: () => workingHours(),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: SvgPicture.asset(
                                  AppImages.calendarIcon,
                                ),
                              ),
                              label: "Working hours",
                              hintText: "Set working hours",
                            ),
                            heightSpace(3),
                            Row(
                              children: [
                                Expanded(
                                  child: AppButton(
                                    onTap: updateBusinessProfile,
                                    buttonText: "Save",
                                    isOrange: true,
                                    isSmall: true,
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

  getMechanicServices() {
    mechanicRepo.getMechanicProfile().then((value) {
      ref.read(services.notifier).state = value;
      final servicesState = ref.watch(services);
      log(servicesState!.systemServices!.length.toString());
      for (SystemServices service in servicesState.systemServices ?? []) {
        serviceList.add(service.name!);
      }
      // servicesState.systemServices?.map((e) {
      //   log(e.name.toString());
      //   serviceList.add(e.name!);
      // });

      ref.read(isLoading.notifier).state = false;
    });
  }

  @override
  initState() {
    super.initState();
    getMechanicServices();
    getBusinessProfile();
  }

  updateBusinessProfile() async {
    List<String> id = [];
    List<String> name = [];
    List<Map<String, dynamic>> newItems = [];
    final servicesState = ref.watch(services);
    final workingHour = ref.watch(stateWorkingHours);

    for (String serviceName in selectedServiceList) {
      for (SystemServices service in servicesState!.systemServices ?? []) {
        if (service.name == serviceName) {
          log(service.name.toString());
          id.add(service.id!);
          name.add(service.name!);
        }
      }
    }

    for (var item in workingHour) {
      if (item["isChecked"] == true) {
        item.remove("isChecked");
        newItems.add(item);
      }
    }
    var data = {
      "businessName": businessName.text,
      "cacNumber": cac.text,
      "state": stateController.text,
      "lga": lgaController.text,
      "city": cityController.text,
      "address": address.text,
      "longitude": "-122.33221",
      "latitude": "789.9987",
      "services": selectedServiceList,
      "otherServices": serviceController.text.split(","),
      "cars": carsList + carsFamiliar.text.split(","),
      "availability": newItems
    };

    bool result = await mechanicRepo.updateBusinessInfo(data);
    if (result) {
      if (context.mounted) {
        context.push(AppRoutes.profileSettings);
      }
    }

    log(data.toString());
  }
}