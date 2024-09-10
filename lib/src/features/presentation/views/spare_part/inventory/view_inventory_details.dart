import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/controller/helpers.dart';
import 'package:ngbuka/src/domain/data/inventory_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class ViewInventoryDetails extends StatefulWidget {
  final String id;
  const ViewInventoryDetails({
    super.key,
    required this.id,
  });

  @override
  State<ViewInventoryDetails> createState() => _ViewInventoryDetailsState();
}

class _ViewInventoryDetailsState extends State<ViewInventoryDetails> {
  final MechanicRepo _mechanicRepo = MechanicRepo();

  InventoryModel? inventoryModel;
  bool isLoading = true;
  String? length;
  String? width;
  String? height;
  String? weight;
  String? volume;
  String? modelNo;
  String? color;
  String? country;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getOneInventory(widget.id).then(
          (value) => setState(
            () {
              inventoryModel = value;
              log(inventoryModel!.toJson().toString());
              if (inventoryModel!.specifications!.length == '' ||
                  inventoryModel!.specifications!.length == null) {
                length = '---';
              } else {
                length = inventoryModel!.specifications!.length;
              }

              if (inventoryModel!.specifications!.width == '' ||
                  inventoryModel!.specifications!.width == null) {
                width = '---';
              } else {
                width = inventoryModel!.specifications!.width;
              }

              if (inventoryModel!.specifications!.height == '' ||
                  inventoryModel!.specifications!.height == null) {
                height = '---';
              } else {
                height = inventoryModel!.specifications!.height;
              }

              if (inventoryModel!.specifications!.weight == '' ||
                  inventoryModel!.specifications!.weight == null) {
                weight = '---';
              } else {
                weight = inventoryModel!.specifications!.weight.toString();
              }

              if (inventoryModel!.specifications!.volume == '' ||
                  inventoryModel!.specifications!.volume == null) {
                volume = '---';
              } else {
                volume = inventoryModel!.specifications!.volume;
              }

              if (inventoryModel!.specifications!.modelNumber == '' ||
                  inventoryModel!.specifications!.modelNumber == null) {
                modelNo = '---';
              } else {
                modelNo = inventoryModel!.specifications!.modelNumber;
              }

              if (inventoryModel!.specifications!.color == '' ||
                  inventoryModel!.specifications!.color == null) {
                color = '---';
              } else {
                color = inventoryModel!.specifications!.color;
              }

              if (inventoryModel!.specifications!.countryOfProducton == '' ||
                  inventoryModel!.specifications!.countryOfProducton == null) {
                country = '---';
              } else {
                country = inventoryModel!.specifications!.countryOfProducton;
              }
              isLoading = false;
            },
          ),
        );
  }

  removeInventory() async {
    bool result = await _mechanicRepo.deleteInventory(inventoryModel!.id);
    log(result.toString());
    if (result) {
      if (context.mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final sw = mediaQueryData.size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 9.h,
                width: 10.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    color: AppColors.white.withOpacity(.5),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
              customText(
                text: "Product Info",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black,
              ),
              heightSpace(1),
              bodyText("View and edit product info")
            ],
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(inventoryModel!.imageUrl!),
                        ),
                      ),
                    ),
                    heightSpace(2),
                    customText(
                      text: 'Product Details',
                      fontSize: 14,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    heightSpace(2),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            text: 'Product Name',
                            fontSize: 12,
                            textColor: AppColors.textGrey,
                          ),
                          heightSpace(1),
                          customText(
                            text: inventoryModel!.name!,
                            fontSize: 14,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          heightSpace(3),
                          customText(
                            text: 'ID Number',
                            fontSize: 12,
                            textColor: AppColors.textGrey,
                          ),
                          heightSpace(1),
                          customText(
                            text: inventoryModel!.id,
                            fontSize: 14,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          heightSpace(3),
                          rowDetails('Colour', color, 'In stock',
                              '${inventoryModel!.quantityInStock!}', sw),
                          heightSpace(3),
                          rowDetails(
                              'Weight',
                              weight,
                              'Product Size (L x W x H x V)',
                              '$length x $width x $height x $volume',
                              sw),
                          heightSpace(3),
                          rowDetails('Model Number', '$modelNo',
                              'Country of production', '$country', sw),
                          heightSpace(3),
                          customText(
                            text: 'Price',
                            fontSize: 12,
                            textColor: AppColors.textGrey,
                          ),
                          heightSpace(1),
                          customText(
                            text:
                                '₦${Helpers.formatBalance(inventoryModel!.finalPrice!)}',
                            fontSize: 14,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          heightSpace(3),
                          customText(
                            text: 'Discount',
                            fontSize: 12,
                            textColor: AppColors.textGrey,
                          ),
                          heightSpace(1),
                          customText(
                            text:
                                '₦${Helpers.formatBalance(inventoryModel!.discount!)}',
                            fontSize: 14,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          heightSpace(3),
                        ],
                      ),
                    ),
                    heightSpace(5),
                    AppButton(
                      onTap: () => context.push(AppRoutes.editInventory,
                          extra: inventoryModel!.id),
                      buttonText: 'Edit details',
                      hasIcon: false,
                      isOrange: true,
                    ),
                    heightSpace(3),
                    GestureDetector(
                      onTap: removeInventory,
                      child: Container(
                        width: double.infinity,
                        height: 7.h,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundGrey,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              width: 1.0, color: AppColors.darkOrange),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customText(
                                text: 'Remove from inventory',
                                textColor: AppColors.darkOrange,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Row rowDetails(String head1, det1, head2, String det2, double sw) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
              text: head1,
              fontSize: 12,
              textColor: AppColors.textGrey,
            ),
            heightSpace(1),
            customText(
              text: det1,
              fontSize: 14,
              textColor: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(
          width: sw * 0.5 - 22,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                text: head2,
                fontSize: 12,
                textColor: AppColors.textGrey,
              ),
              heightSpace(1),
              customText(
                text: det2,
                fontSize: 14,
                textColor: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        )
      ],
    );
  }
}
