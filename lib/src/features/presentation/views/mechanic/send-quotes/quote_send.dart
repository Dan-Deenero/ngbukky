import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/user_model.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/dialogue.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

import '../success_modal.dart';

class MultiSelect extends StatefulWidget {
  final List<String> items;
  final VoidCallback func;
  final VoidCallback func2;
  const MultiSelect(
      {super.key,
      required this.items,
      required this.func,
      required this.func2});

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class QuoteSend extends StatefulWidget {
  final String id;
  const QuoteSend({super.key, required this.id});

  @override
  State<QuoteSend> createState() => _QuoteSendState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedServices = [];
  // Map<String, int> selectedServices2 = {};
  var serviced = TextEditingController();
  var serves = TextEditingController();
  var prices = TextEditingController();
  int serviceCost = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      backgroundColor: const Color.fromARGB(255, 244, 244, 245),
      content: SizedBox(
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
                        _submit();
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

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedServices.add(itemValue);
      } else {
        _selectedServices.remove(itemValue);
      }
    });
  }

  void _submit() {
    Navigator.pop(context, _selectedServices);
    widget.func2();
  }
}

class _QuoteSendState extends State<QuoteSend> {
  static final AuthRepo _authRepo = AuthRepo();
  static final MechanicRepo mechanicRepo = MechanicRepo();
  static final costOnly = TextEditingController();
  static var serv = TextEditingController();
  static var price = TextEditingController();
  static var serves = TextEditingController();

  static var prices = TextEditingController();
  Map<String, int> selectedServices = {};
  Map<String, int> selectedServices2 = {};
  bool isLoading = true;
  List<String> serviceNames = [];
  List<String> _serviceItems = [];
  Map<String, String> serviceNameToId = {};
  List<String> serviceList = [];
  List<String> otherList = [];
  List<Services> otherServiceList = [];
  List<Services> service = [];

  List<Map<String, dynamic>> servicesItems = [];

  BookingModel? bookingModel;

  int subtotal = 0;

  double serviceFee = 0;

  addCost(BuildContext context, String ed) {
    int costs = selectedServices[ed] ?? 0;
    serves.text = ed;
    prices.text = costs.toString();
    showDialog(
        context: context,
        builder: (context) => AlertDialogue(
              cancel: () {
                selectedServices.clear();
                context.pop();
              },
              title: 'Cost',
              subtitle: 'Attach servicing cost to this service',
              service: serves,
              cost: prices,
              content:
                  'You are adding a cost to this service for only this booking',
              action: 'Done',
              fction: () {
                int newCost = int.tryParse(prices.text) ?? 0;
                setState(() {
                  selectedServices[ed] = newCost; // Update the cost in the map
                });
                // updateCostValue(ed, newCost);
                context.pop();
                submit();
              },
            ));
  }

  addPersonalService(String serv) async {
    log(serv);
    var data = {
      "name": serv,
      "imageUrl": "some url",
      "description": "the description"
    };

    bool result = await mechanicRepo.addPersonalizedService(data);

    if (result) {
      getUpdatedProfile();
      if (context.mounted) {
        context.pop();
      }
    }
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
              fction: () async {
                addPersonalService(serv.text);
                setState(() {
                  addServiceToSelectedServices(
                      serv.text, int.parse(price.text));

                  // context.pop();
                });
              },
            ));
  }

  addServiceToSelectedServices(String serviceName, int serviceCost) {
    setState(() {
      selectedServices2[serviceName] = serviceCost;

      subtotal += serviceCost;
    });
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
                text: "Send Quote",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black),
            // heightSpace(1),
            bodyText("Let the client know what it will cost")
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
                onTap: () => context.push(AppRoutes.bottomNav),
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
                    child: selectedServices2.isEmpty
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
                                children: selectedServices2.keys
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
                                                  '$e - ₦${selectedServices2[e]}',
                                              fontSize: 13,
                                              textColor: AppColors.orange),
                                          deleteIcon: const Icon(
                                            Icons.close,
                                            color: AppColors.red,
                                          ),
                                          onDeleted: () {
                                            selectedServices.remove(e);
                                            selectedServices2.remove(e);
                                            setState(() {
                                              int newSubtotal = 0;
                                              selectedServices2
                                                  .forEach((service, cost) {
                                                newSubtotal += cost;
                                                log(selectedServices
                                                    .toString());
                                              });
                                              subtotal = newSubtotal;
                                              serviceFee = subtotal * 0.01;
                                            });
                                          },
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                  ),
                  heightSpace(2),
                  GestureDetector(
                    onTap: () {
                      addService();
                    },
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
                        subtotal = int.tryParse(costOnly.text) ?? 0;
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

  getOneBooking() {
    mechanicRepo.getoneBooking(widget.id).then((value) {
      bookingModel = value;
      log(bookingModel!.user!.id!);
      setState(() {
        isLoading = false;
      });
    });
  }

  getUpdatedProfile() {
    _authRepo.getMechanicProfile().then(
      (value) {
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

        for (var serviceString in serviceList) {
          List<String> parts = serviceString.split(': ');
          if (parts.length == 2) {
            String serviceId = parts[0];
            String serviceName = parts[1];
            serviceNameToId[serviceName] = serviceId;
          }
        }
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUpdatedProfile();
    getOneBooking();
  }

  reject() {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: SizedBox(
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

  rejectBooking() async {
    var body = {
      "action": "rejected",
    };
    bool result = await mechanicRepo.acceptOrRejectBooking(body, widget.id);
    if (result) {
      if (context.mounted) {
        context.go(AppRoutes.bookingAlert);
        return;
      }
    }
  }

  sendQuote() async {
    selectedServices2.forEach((serviceName, cost) {
      final serviceId = serviceNameToId[serviceName];
      servicesItems.add({
        "serviceId": serviceId, // Convert the ID to string
        "cost": cost,
      });
    });
    // log(servicesItems.toString());
    // print(servicesItems.toString());

    var data = {};
    if (selectedServices2.isNotEmpty) {
      data = {
        "isOnlyAmount": 'false',
        "services": [...servicesItems]
      };
    } else {
      data = {"isOnlyAmount": 'true', "amount": subtotal};
    }
    bool result = await mechanicRepo.sendQuoteForBooking(data, widget.id);
    if (result) {
      if (context.mounted) {
        showSuccesModal();
      }
    }
  }

  showSuccesModal() {
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
  }

  void submit() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius as needed
              ),
              backgroundColor: const Color.fromARGB(255, 244, 244, 245),
              content: SizedBox(
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
                              onTap: () {
                                context.pop();
                                selectedServices.clear();
                              },
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
                          children: selectedServices.keys.map((item) {
                        final dynamic costValue = selectedServices[item];
                        log(costValue.toString());
                        final int cost = costValue is int ? costValue : 0;

                        return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: ListTile(
                              tileColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Text(item),
                              subtitle: customText(
                                  text: '$cost',
                                  fontSize: 14,
                                  textColor: AppColors.orange),
                              trailing: GestureDetector(
                                  onTap: () {
                                    context.pop();
                                    addCost(context, item);
                                  },
                                  child: SvgPicture.asset(
                                    AppImages.editIcon,
                                    width: 20,
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
                                setState(() {
                                  selectedServices2.addAll(selectedServices);
                                  selectedServices2.forEach((service, cost) {
                                    subtotal += cost;
                                  });
                                  serviceFee = subtotal * 0.01;
                                });
                                // log(selectedServices2.toString());
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

  void updateCostValue(String serviceName, int newCost) {
    setState(() {
      selectedServices[serviceName] = newCost;
    });
  }

  void _showMultiSelect() async {
    final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelect(
            items: serviceNames,
            func: addService,
            func2: submit,
          );
        });

    if (results != null) {
      setState(() {
        _serviceItems = results;
      });
    }

    for (var service in _serviceItems) {
      setState(() {
        selectedServices[service] = 0;
      });
    }
  }
}
