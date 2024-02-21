import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/controller/Helpers.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class InventoryTile extends StatelessWidget {
  final String? image;
  final dynamic price;
  final String? name;
  final int? inStock;
  final dynamic id;
  final String length;

  const InventoryTile({super.key, this.image, this.price, this.name, this.inStock, required this.length, this.id});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final sw = mediaQueryData.size.width;

    return Column(
      children: [
        Container(
          height: 18.h,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: sw * 0.30 - 24,
                      height: 12.h,
                      child: Image.network(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  widthSpace(sw * 0.01),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: name!,
                        fontSize: 14,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      heightSpace(1),
                      SizedBox(
                        width: sw * 0.60 - 24,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 53.w,
                              child: RichText(
                                text:  TextSpan(
                                  text: 'ID Number: ',
                                  style: const TextStyle(color: AppColors.textGrey),
                                  children: [
                                    TextSpan(
                                      text: id,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      heightSpace(.5),
                      SizedBox(
                        width: sw * 0.60 - 24,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText(
                                text: '₦${Helpers.formatBalance(price!.toInt())}',
                                fontSize: 14,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w600),
                            customText(
                              text: '$inStock in stock',
                              fontSize: 10,
                              textColor: AppColors.textGrey,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        heightSpace(2),
        AppButton(
          onTap: () => context.push(AppRoutes.viewInventoryDetails, extra: id),
          buttonText: 'View details',
          hasIcon: false,
          isOrange: true,
        )
      ],
    );
  }

  Container dot() {
    return Container(
      width: 3,
      height: 3,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.black),
    );
  }
}
