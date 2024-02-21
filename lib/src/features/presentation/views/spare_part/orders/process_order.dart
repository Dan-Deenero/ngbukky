import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/orders_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

class ProcessOrder extends HookWidget {
  static final MechanicRepo mechanicRepo = MechanicRepo();
  final String id;
  const ProcessOrder({super.key, required this.id});

  final bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final ordersModel = useState<OrdersModel?>(null);
    final isChecked = useState(false);
    final isLoading = useState(true);

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return AppColors.checkBoxColor;
      }
      return AppColors.checkBoxColor;
    }

     processOrder() async {
      var body = {
        "status": "processed",
      };
      bool result = await mechanicRepo.processOrder(body, id);
      if (result) {
        if (context.mounted) {
          context.push(AppRoutes.ordersInfo, extra: id);
          return;
        }
      }
    }

    getOneOrder() {
      mechanicRepo.getOneOrder(id).then(
        (value) {
          ordersModel.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getOneOrder();
      return null;
    }, [id]);
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(21.h),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    color: AppColors.white.withOpacity(.5),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => context.push(AppRoutes.bottomNav),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
              customText(
                text: "Order info",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black,
              ),
              heightSpace(1),
              bodyText("View and keep track of your orders here")
            ],
          ),
        ),
      ),
      body: isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                      text: 'No of items ordered: 4',
                      fontSize: 14,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    heightSpace(2),
                    customText(
                      text: 'Availability',
                      fontSize: 16,
                      textColor: AppColors.black,
                    ),
                    heightSpace(3),
                    Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 80,
                                // width: 40.w - 20,
                                child: Image.network(
                                  ordersModel.value!.product!.imageUrl!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    customText(
                                      text:
                                          '${ordersModel.value!.product!.name}',
                                      fontSize: 12,
                                      textColor: AppColors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    heightSpace(1),
                                    // customText(
                                    //   text: 'Type: Iridium',
                                    //   fontSize: 12,
                                    //   textColor: AppColors.textGrey,
                                    //   fontWeight: FontWeight.w600,
                                    // ),
                                    heightSpace(1),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        heightSpace(2),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'In order: ',
                                style:
                                    const TextStyle(color: AppColors.textGrey),
                                children: [
                                  TextSpan(
                                    text: '${ordersModel.value!.quantity}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            widthSpace(8),
                            RichText(
                              text: const TextSpan(
                                text: 'In stock: ',
                                style: TextStyle(color: AppColors.textGrey),
                                children: [
                                  TextSpan(
                                    text: '10',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked.value,
                          onChanged: (val) => isChecked.value = val!,
                        ),
                        widthSpace(2),
                        customText(
                          text: "Confirm items have been packed",
                          fontSize: 14,
                          textColor: AppColors.primary,
                        )
                      ],
                    ),
                    heightSpace(3),
                    AppButton(
                      isActive: isChecked.value,
                      onTap: processOrder,
                      buttonText: 'Process',
                      hasIcon: false,
                      isOrange: true,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
