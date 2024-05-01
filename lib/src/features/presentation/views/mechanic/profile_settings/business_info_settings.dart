import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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

import '../../../../../core/shared/colors.dart';

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
  List<String> serviceNames = [];
  List<String> serviceNamed = [];
  List<String> otherList = [];
  List<String> mainList = [];
  List<Services> otherServiceList = [];
  List<String> selectServiceList = [];
  List<Services> service = [];
  final formKey = GlobalKey<FormState>();
  List<String> trueItemsString = [];
  Map<String, String> serviceNameToId = {};

  List<String> selectedServices2 = [];

  List<String> carsList = [];
  List<String> selectedCarsList = [];

  getBusinessProfile() {
    _authRepo.getMechanicProfile().then((value) {
      // String availabilityString = jsonEncode(value.availability!);
      service = value.services!;
      otherServiceList = value.otherServices!;
      serveList = service.map((service) {
        return "${service.id}: ${service.name}";
      }).toList();
      otherList = otherServiceList.map((service) {
        return "${service.id}: ${service.name}";
      }).toList();
      serveList = serveList + otherList;
      serviceNames = serveList.map((item) {
        return item.split(': ')[1];
      }).toList();
      for (var serviceString in serveList) {
        List<String> parts = serviceString.split(': ');
        if (parts.length == 2) {
          String serviceId = parts[0];
          String serviceName = parts[1];
          serviceNameToId[serviceName] = serviceId;
        }
      }
      businessName.text = value.businessName!;
      cac.text = value.cacNumber!;
      address.text = value.address!;
      cityController.text = value.city!;
      lgaController.text = value.lga!;
      stateController.text = value.state!;
      carsList = value.cars!;
      log(carsList.toString());
      // log(serveList.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(isLoading);
    final workingHour = ref.watch(stateWorkingHours);
    double size = MediaQuery.of(context).size.width;

    workingHours() {
      saveData() {
        workingHourController.clear();
        trueItemsString.clear();
        log(workingHourController.text);
        for (var item in workingHour) {
          if (item["isChecked"]) {
            var itemString =
                "day: ${item["day"]}, from: ${item["from"]}AM, to: ${item["to"]}PM";
            trueItemsString.add(itemString);
          }
        }
        workingHourController.text = trueItemsString.join(', ');
        log(workingHourController.text);
        context.pop();
      }

      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Consumer(builder: (BuildContext context, ref, child) {
            final workingHour = ref.watch(stateWorkingHours);
            // log(workingHours.toString());
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
                        ],
                      ),
                      heightSpace(2),
                      Column(
                        children: [
                          ...workingHour.mapIndexed(
                            (e, index) {
                              e["isChecked"] ?? (e["isChecked"] = false);
                              return SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    e["isChecked"]
                                        ? GestureDetector(
                                            onTap: () {
                                              final stateNotifier = ref.read(
                                                  stateWorkingHours.notifier);
                                              final currentState =
                                                  stateNotifier.state;
                                              List<Map<String, dynamic>>
                                                  updatedState =
                                                  List.from(currentState);

                                              updatedState[index]["isChecked"] =
                                                  !updatedState[index]
                                                      ["isChecked"];

                                              stateNotifier.state =
                                                  updatedState;

                                              log(ref
                                                  .read(stateWorkingHours
                                                      .notifier)
                                                  .state[index]["isChecked"]
                                                  .toString());
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 8,
                                              ),
                                              width: size * 0.32,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: AppColors.white),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .darkOrange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(1.0),
                                                      child: Icon(Icons.check,
                                                          color:
                                                              AppColors.white,
                                                          size: 15),
                                                    ),
                                                  ),
                                                  widthSpace(2),
                                                  customText(
                                                      text: e["day"],
                                                      fontSize: size * 0.0334,
                                                      textColor:
                                                          AppColors.black)
                                                ],
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              final stateNotifier = ref.read(
                                                  stateWorkingHours.notifier);
                                              final currentState = stateNotifier
                                                  .state; // Get the current state
                                              List<Map<String, dynamic>>
                                                  updatedState = List.from(
                                                      currentState); // Create a copy of the state

                                              updatedState[index]
                                                  ["isChecked"] = !updatedState[
                                                      index][
                                                  "isChecked"]; // Toggle the property

                                              stateNotifier.state =
                                                  updatedState;
                                              log(ref
                                                  .read(stateWorkingHours
                                                      .notifier)
                                                  .state[index]["isChecked"]
                                                  .toString());
                                              setState(() {});
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              width: size * 0.32,
                                              height: 40,
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
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                widthSpace(2),
                                                customText(
                                                    text: e["day"],
                                                    fontSize: size * 0.0334,
                                                    textColor: AppColors.black)
                                              ]),
                                            ),
                                          ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      width: size * 0.12,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          border: Border.all(
                                              color: AppColors.white),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Center(
                                        child: SvgPicture.asset(
                                            AppImages.boldediticon),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        final startTime =
                                            StateProvider<TimeOfDay>(
                                                (ref) => TimeOfDay.now());
                                        final time = ref.watch(startTime);
                                        final TimeOfDay? result =
                                            await showTimePicker(
                                                context: context,
                                                initialTime: time,
                                                );

                                        if (result != null) {
                                          if (context.mounted) {
                                            ref.read(startTime.notifier).state =
                                                result;
                                            String res;
                                            if (result.minute < 10) {
                                              res =
                                                  '0${result.minute.toString()}';
                                            } else {
                                              res = result.minute.toString();
                                            }
                                            final stateNotifier = ref.read(
                                                stateWorkingHours.notifier);
                                            final currentState =
                                                stateNotifier.state;
                                            List<Map<String, dynamic>>
                                                updatedState =
                                                List.from(currentState);

                                            updatedState[index]["from"] =
                                                '${result.hour.toString()}:$res';

                                            stateNotifier.state = updatedState;
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: size * 0.12,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            border: Border.all(
                                                color: AppColors.white),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: customText(
                                              text: e["from"],
                                              fontSize: size * 0.035,
                                              textColor: AppColors.black),
                                        ),
                                      ),
                                    ),
                                    widthSpace(4),
                                    GestureDetector(
                                      onTap: () async {
                                        final startTime =
                                            StateProvider<TimeOfDay>(
                                                (ref) => TimeOfDay.now());
                                        final time = ref.watch(startTime);
                                        final TimeOfDay? result =
                                            await showTimePicker(
                                                context: context,
                                                initialTime: time,
                                                );

                                        if (result != null) {
                                          if (context.mounted) {
                                            ref.read(startTime.notifier).state =
                                                result;
                                            String res;
                                            if (result.minute < 10) {
                                              res =
                                                  '0${result.minute.toString()}';
                                            } else {
                                              res = result.minute.toString();
                                            }
                                            final stateNotifier = ref.read(
                                                stateWorkingHours.notifier);
                                            final currentState =
                                                stateNotifier.state;
                                            List<Map<String, dynamic>>
                                                updatedState =
                                                List.from(currentState);

                                            updatedState[index]["to"] =
                                                '${result.hour.toString()}:$res';

                                            stateNotifier.state = updatedState;
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: size * 0.12,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            border: Border.all(
                                                color: AppColors.white),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: customText(
                                              text: e["to"],
                                              fontSize: size * 0.035,
                                              textColor: AppColors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          heightSpace(3)
                        ],
                      ),
                      AppButton(
                          // isActive: isActive.value,
                          buttonText: "Save",
                          isOrange: true,
                          onTap: saveData),
                      heightSpace(2),
                    ],
                  ),
                ));
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
                              onChanged: (val) {
                                selectedCarsList = val!;
                                log(val.toString());
                                return null;
                              },
                              selectedItems: const [
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
                                'Chevrolet',
                                'Others'
                              ],
                            ),
                            heightSpace(2),
                            customText(
                                text: "List of Services",
                                fontSize: 14,
                                textColor: AppColors.black),
                            heightSpace(1),
                            AppDropdDownSearch(
                              listOfSelectedItems: serviceNames,
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
                              selectedItems: serviceNamed,
                              // onChanged: onChanged,
                            ),
                            heightSpace(4),
                            CustomTextFormField(
                              textEditingController: serviceController,
                              label: "Other Services",
                              hintText: "separate with a comma",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: SvgPicture.asset(
                                  AppImages.serviceIcon,
                                ),
                              ),
                            ),
                            heightSpace(4),
                            customText(
                                text: "Availabiity",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                textColor: AppColors.black),
                            heightSpace(2),
                            GestureDetector(
                              onTap: workingHours,
                              child: CustomTextFormField(
                                isEnabled: false,
                                textEditingController: workingHourController,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: SvgPicture.asset(
                                    AppImages.calendarIcon,
                                  ),
                                ),
                                label: "Working hours",
                                hintText: "Set working hours",
                              ),
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
        mainList.add("${service.id}: ${service.name}");
        serviceNamed = mainList.map((item) {
          return item.split(': ')[1];
        }).toList();
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
    List<Map<String, dynamic>> newItems = [];
    final servicesState = ref.watch(services);
    final workingHour = ref.watch(stateWorkingHours);

    for (String serviceName in selectedServiceList) {
      for (SystemServices service in servicesState!.systemServices ?? []) {
        if (service.name == serviceName) {
          log(service.name.toString());
          id.add(service.id!);
        }
      }
    }

    serviceNames.forEach((serviceName) {
      final serviceId = serviceNameToId[serviceName];
      selectedServices2.add(
        serviceId!, // Convert the ID to string
      );
    });

    for (var item in workingHour) {
      if (item["isChecked"] == true) {
        item.remove("isChecked");
        newItems.add(item);
        log(newItems.toString());
      }
    }

    List<String> otservces;

    if (serviceController.text.isEmpty) {
      otservces = [];
    } else {
      otservces = serviceController.text.split(",");
    }

    if(selectedCarsList.isEmpty){
      selectServiceList + carsList;
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
      "services": id,
      "otherServices": otservces,
      "cars": selectedCarsList,
      "availability": newItems
    };

    bool result = await mechanicRepo.updateBusinessInfo(data);
    if (result) {
      if (context.mounted) {
        context.pop();
        trueItemsString.clear();
      }
    } else {
      serviceNames.clear();
      workingHourController.clear();
      // newItems.clear();
    }

    log(data.toString());
    log(newItems.toString());
  }
}
