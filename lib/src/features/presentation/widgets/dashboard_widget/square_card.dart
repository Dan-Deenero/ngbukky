import 'package:flutter/material.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class SquareCard extends StatelessWidget {
  final double sw;
  final double sh;
  final String? image;
  final int? price;
  final String? item;
  final int? quantity;
  final String? length;
  final String? time;
  final String? date;
  final String? status;
  final String? deliveryMethod;
  final VoidCallback? ontap;
  const SquareCard({
    super.key,
    required this.sw,
    required this.sh,
    this.image = 'https://www-konga-com-res.cloudinary.com/w_400,f_auto,fl_lossy,dpr_3.0,q_auto/media/catalog/product/5/W/5W-30-Synthetic-Engine-Oil---4-73-Litres-7109544.jpg',
    this.price = 6000,
    this.item = 'Spark plug',
    this.quantity = 3,
    this.length = '14mm',
    this.time = '12:20pm',
    this.date = '12 Jun 2023',
    this.status = 'new',
    this.deliveryMethod = 'Out of state delivery',
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
     bool runningOut;
    if(quantity! >= 5){
      runningOut = true;
    }else{
      runningOut = false;
    }
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: sh,
            width: sw,
            decoration:  BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(
                  image!,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: item!,
                  fontSize: 12,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
                heightSpace(2),
                customText(
                  text: 'N$price',
                  fontSize: 12,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
                
                heightSpace(2),
                runningOut
                    ? customText(
                        text: '$quantity',
                        fontSize: 10,
                        textColor: AppColors.red,
                      )
                    : SizedBox(
                        width: sw * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText(
                              text: '31 orders',
                              fontSize: 10,
                              textColor: AppColors.black,
                            ),
                            customText(
                              text: '$quantity in stock',
                              fontSize: 10,
                              textColor: AppColors.black,
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
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
