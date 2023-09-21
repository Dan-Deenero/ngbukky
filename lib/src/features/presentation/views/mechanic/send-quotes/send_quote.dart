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
import 'package:ngbuka/src/domain/data/user_model.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/dialogue.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/success_modal.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/providers/work_hours.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

import '../../../../../core/shared/colors.dart';

class SendQuote extends ConsumerStatefulWidget {
  final String id;

  const SendQuote({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<SendQuote> createState() => _SendQuoteState();
}

class _SendQuoteState extends ConsumerState<SendQuote> {
  // final MechanicRepo _mechanicRepo = MechanicRepo();
  static final AuthRepo _authRepo = AuthRepo();
  static final MechanicRepo _mechanicRepo = MechanicRepo();
  static final costOnly = TextEditingController();
  static var serv = TextEditingController();
  static var price = TextEditingController();

  bool isLoadings = true;

  List<String> serviceList = [];
  List<String> otherList = [];
  List<Services> otherServiceList = [];
  List<String> selectedServiceList = [];
  List<Services> service = [];

  List<String> servicesItems = [];
  Map<String, int> selectedServices = {};
  List<String> serviceNames = [];
  Map<String, String> serviceNameToId = {};


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authRepo.getMechanicProfile().then((value) => setState(
          () {
            service = value.services!;
            otherServiceList = value.otherServices!;
            // serviceList = service.map((service,) => service.id!).toList();
            // otherList =
            //     otherServiceList.map((service) => service.id!).toList();
            serviceList = service.map((service) {
              return "${service.id}: ${service.name}";
            }).toList();

            otherList = otherServiceList.map((service) {
              return "${service.id}: ${service.name}";
            }).toList();
            serviceList = serviceList + otherList;  

            serviceNames = serviceList.map((item) {
              return item.split(': ')[1];
            }).toList();
            log(serviceNames.toString());

            serviceList.forEach((serviceString) {
              List<String> parts = serviceString.split(': ');
              if (parts.length == 2) {
                String serviceId = parts[0];
                String serviceName = parts[1];
                if (serviceId != null) {
                  serviceNameToId[serviceName] = serviceId;
                }
              }
            });
          },
        ));
    _mechanicRepo.getoneBooking(widget.id).then((value) => setState(
          () {  
            bookingModel = value;
            log(bookingModel!.user!.id!);
            isLoadings = false;
          },
        ));
    
  }

  addServiceToSelectedServices(String serviceName, int serviceCost) {
    selectedServices[serviceName] = serviceCost;
  }

  addService() {
    showDialog(
        context: context,
        builder: (context) => AlertDialogue(
              title: 'Add new service',
              subtitle: 'Add a new service and its cost to your service list',
              service: serv,
              cost: price,
              content:
                  'This service is added to your already existing list of services',
              action: 'Add service',
              fction: () {
                setState(() {
                  addServiceToSelectedServices(
                      serv.text, int.parse(price.text));
                  addPersonalService();
                });
                // updateBusinessProfile();
              },
            ));
  }

  void _showMultiSelect() async {
    final Map<String, int>? results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelect(items: serviceNames, func: addService);
        });

    if (results != null) {
      results.forEach((serviceName, cost) {
        if (serviceName.isNotEmpty && cost != null) {
          selectedServices[serviceName] = cost;
        } // Add the entry to the new Map
      });
    } else {
      log(results.toString());
    }
  }

  String isOnlyAmount = 'true';

  BookingModel? bookingModel;

  

  sendQuote() async {

    selectedServices.forEach((serviceName, cost) {
    final serviceId = serviceNameToId[serviceName];
    if (serviceId != null) {
      final serviceMap = {
        "serviceId": serviceId, // Convert the ID to string
        "cost": cost,
      };
      servicesItems.add(serviceMap.toString());
    }
  });

    var data = {};
    if (selectedServices.isNotEmpty) {
      data = {"isOnlyAmount": 'false', "services": servicesItems};
    } else {
      data = {"isOnlyAmount": 'true', "amount": subtotal};
    }
    bool result =
        await mechanicRepo.sendQuoteForBooking(data, widget.id);
    if (result) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => SuccessDialogue(
                  title: 'Quote sent',
                  subtitle:
                      'Your quote has been sent successfully to ${bookingModel!.user!.username!}',
                  action: () {
                    context.go(AppRoutes.pendingQuoteApproval);
                  },
                ));
        Future.delayed(const Duration(seconds: 1), () {
          context.push(AppRoutes.pendingQuoteApproval);
        });
      }
    }
  }

  addPersonalService() async {
    var data = {
      "name": '${serv.text}',
      "imageUrl": "some url",
      "description": "the description"
    };

    bool result = await mechanicRepo.addPersonalizedService(data);
    if (result) {
      if (context.mounted) {
        context.pop();
      }
    }

    log(data.toString());
  }

  rejectBooking() async {
    var body = {
      "action": "rejected",
    };
    bool result = await _mechanicRepo.acceptOrRejectBooking(body, widget.id);
    if (result) {
      if (context.mounted) {
        context.go(AppRoutes.bookingAlert);
        return;
      }
    }
  }

  reject() {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: Container(
                // padding: EdgeInsets.all(10.0),
                width: 700, // Set the desired width
                height: 200,
                child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        16.0), // Adjust the radius as needed
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      heightSpace(1),
                      customText(
                          text: 'Confirm that you want to reject this booking',
                          fontSize: 12,
                          textColor: AppColors.black),
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
                                onPressed: rejectBooking,
                                child: customText(
                                    text: 'Yes',
                                    fontSize: 16,
                                    textColor: AppColors.darkOrange))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  int subtotal = 0;
  @override
  Widget build(BuildContext context) {
    selectedServices.forEach((service, cost) {
      subtotal += cost;
    });
    double serviceFee = subtotal * 0.01;

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
                  onTap: () => context.pop(),
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
      body: isLoadings
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpace(2),
                  customText(
                      text: "Select from your services",
                      fontSize: 14,
                      textColor: AppColors.black),
                  heightSpace(1),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 8.0),
                    width: double.infinity,
                    // height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(
                            color: AppColors.black,
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20)),
                    child: selectedServices.isEmpty
                        ? GestureDetector(
                            onTap: _showMultiSelect,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.serviceIcon,
                                      width: 20,
                                    ),
                                    widthSpace(3),
                                    customText(
                                        text: 'Select services and price',
                                        fontSize: 14,
                                        textColor: AppColors.textGrey)
                                  ],
                                ),
                                const Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 2,
                                direction: Axis.vertical,
                                children: selectedServices.keys
                                    .map((e) => Chip(
                                          backgroundColor:
                                              AppColors.orange.withOpacity(0.1),
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 0.5,
                                                  color: AppColors.orange),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          label: customText(
                                              text:
                                                  '$e - ₦${selectedServices[e]}',
                                              fontSize: 13,
                                              textColor: AppColors.orange),
                                          deleteIcon: const Icon(
                                            Icons.close,
                                            color: AppColors.red,
                                          ),
                                          onDeleted: () {
                                            setState(() {
                                              selectedServices.remove(e);
                                            });
                                          },
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                  ),
                  // heightSpace(1),
                  // GestureDetector(
                  //   onTap: _showMultiSelect,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       customText(
                  //           text: "click to select service",
                  //           fontSize: 15,
                  //           textColor: AppColors.orange),
                  //     ],
                  //   ),
                  // ),
                  heightSpace(2),
                  GestureDetector(
                    onTap: addService,
                    child: customText(
                        text: "Not listed?",
                        fontSize: 15,
                        textColor: AppColors.orange), 
                  ),
                  heightSpace(2),
                  CustomTextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textEditingController: costOnly,
                    label: "Enter amount (N)",
                    hintText: "e.g 1,000",
                    hasMaxline: true,
                    keyboardType: TextInputType.number,
                    validator: numericValidation,
                    onChanged: (value) {
                      setState(() {
                        subtotal = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  heightSpace(2),
                  heightSpace(8),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: AppColors.containerGrey,
                  ),
                  heightSpace(2),
                  heightSpace(2),
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
                              text: '$subtotal',
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
                              text: '${subtotal + serviceFee}',
                              fontSize: 13,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.w600)
                        ],
                      )
                    ],
                  ),
                  heightSpace(3),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: AppColors.containerGrey,
                  ),
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
                        child: AppButton(
                          onTap: sendQuote,
                          hasIcon: false,
                          buttonText: "Send",
                          isOrange: true,
                        ),
                      ),
                    ],
                  ),
                  heightSpace(2),
                ],
              ),
            )),
    );
  }
}

class MultiSelect extends StatefulWidget {
  final List<String> items;
  final VoidCallback func;
  const MultiSelect({
    super.key,
    required this.items,
    required this.func,
  });

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedServices = [];
  Map<String, int> selectedServices2 = {};
  var serviced = TextEditingController();
  static var cost = TextEditingController();
  var serves = TextEditingController();
  var prices = TextEditingController();

  String serviceName = "";
  int serviceCost = 0;

  addCost(BuildContext context, String ed) {
    int costs = selectedServices2[ed] ?? 0;
    serves.text = ed;
    prices.text = costs.toString();
    showDialog(
        context: context,
        builder: (context) => AlertDialogue(
              title: 'Cost',
              subtitle: 'Attach servicing cost to this service',
              service: serves,
              cost: prices,
              content:
                  'You are adding a cost to this service for only this booking',
              action: 'Done',
              fction: () {
                int newCost = int.tryParse(prices.text) ?? 0;
                log(newCost.toString());
                setState(() {
                  selectedServices2[ed] = newCost; // Update the cost in the map
                });
                context.pop(newCost);
              },
            ));
  }

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedServices.add(itemValue);
      } else {
        _selectedServices.remove(itemValue);
      }
    });
  }

  void submit() {
    _selectedServices.forEach((service) {
      selectedServices2[service] = 0;
    });
    
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius as needed
              ),
              backgroundColor: const Color.fromARGB(255, 244, 244, 245),
              content: Container(
                width: 300, // Set the width to an appropriate value
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () => context.pop(),
                              child: SvgPicture.asset(AppImages.cancelModal))
                        ],
                      ),
                      customText(
                          text: 'Select services and cost',
                          fontSize: 18,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.w700),
                      heightSpace(1),
                      customText(
                          text: 'What will you be doing?',
                          fontSize: 12,
                          textColor: AppColors.black),
                      heightSpace(2),
                      ListBody(
                          children: selectedServices2.keys.map((item) {
                        final dynamic costValue = selectedServices2[item];
                        log(costValue.toString());
                        // final int cost = costValue is int ? costValue : 0;

                        return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: ListTile(
                              tileColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Text(item),
                              subtitle: customText(
                                  text: '$costValue',
                                  fontSize: 14,
                                  textColor: AppColors.orange),
                              trailing: GestureDetector(
                                  onTap: () {
                                    addCost(context, item);
                                  },
                                  child: SvgPicture.asset(
                                    AppImages.editIcon,
                                    width: 30,
                                  )),
                            ));
                      }).toList()),
                      heightSpace(3),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              onTap: () {
                                Navigator.pop(context, selectedServices2);
                              },
                              hasIcon: false,
                              buttonText: "Done",
                              isOrange: true,
                            ),
                          ),
                          widthSpace(2),
                          GestureDetector(
                            onTap: () {
                              context.pop();
                              widget.func();
                            },
                            child: Container(
                              width: 30.w,
                              height: 7.h,
                              decoration: BoxDecoration(
                                  color: AppColors.containerGrey,
                                  borderRadius: BorderRadius.circular(25)),
                              child: const Center(
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  addService() {
    showDialog(
        context: context,
        builder: (context) => AlertDialogue(
              title: 'Add new service',
              subtitle: 'Add a new service and its cost to your service list',
              service: serviced,
              cost: cost,
              content:
                  'This service is added to your already existing list of services',
              action: 'Add service',
              fction: () {},
            ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      backgroundColor: const Color.fromARGB(255, 244, 244, 245),
      content: Container(
        width: 300, // Set the width to an appropriate value
        height: 500,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () => context.pop(),
                      child: SvgPicture.asset(AppImages.cancelModal))
                ],
              ),
              customText(
                  text: 'Select services and cost',
                  fontSize: 18,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w700),
              heightSpace(1),
              customText(
                  text: 'What will you be doing?',
                  fontSize: 12,
                  textColor: AppColors.black),
              heightSpace(2),
              ListBody(
                  children: widget.items
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: CheckboxListTile(
                              value: _selectedServices.contains(item),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Adjust the radius as needed
                              ),
                              tileColor: AppColors.white,
                              title: Text(item),
                              controlAffinity: ListTileControlAffinity.leading,
                              // subtitle: const Text(
                              //   "₦ 300",
                              //   style: TextStyle(color: AppColors.orange),
                              // ),
                              onChanged: (isChecked) =>
                                  _itemChange(item, isChecked!),
                            ),
                          ))
                      .toList()),
              heightSpace(3),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      onTap: () {
                        submit();
                      },
                      hasIcon: false,
                      buttonText: "Done",
                      isOrange: true,
                    ),
                  ),
                  widthSpace(2),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                      widget.func();
                    },
                    child: Container(
                      width: 30.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                          color: AppColors.containerGrey,
                          borderRadius: BorderRadius.circular(25)),
                      child: const Center(
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
