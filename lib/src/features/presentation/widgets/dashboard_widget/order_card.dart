import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class OrderCard extends StatelessWidget {
  final String? image;
  final int? price;
  final String? item;
  final int? quantity;
  final String? id;
  final String? length;
  const OrderCard({
    super.key,
    this.image = AppImages.engineoil,
    this.price = 6000,
    this.item = 'Spark plug',
    this.quantity = 3,
    this.length = '14mm',
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          SizedBox(
            height: 150,
            width: 50.w - 20,
            child: Image.network(
              image!,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: 50.w - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(
                  text: item!,
                  fontSize: 12,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
                heightSpace(2),
                customText(
                  text: 'Quantity: $quantity',
                  fontSize: 12,
                  textColor: AppColors.textGrey,
                  fontWeight: FontWeight.w600,
                ),
                heightSpace(1),
                SizedBox(
                  width: 40.w,
                  child: RichText(
                    text: TextSpan(
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
                heightSpace(1),
                customText(
                  text: 'N${quantity! * price!}',
                  fontSize: 12,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
