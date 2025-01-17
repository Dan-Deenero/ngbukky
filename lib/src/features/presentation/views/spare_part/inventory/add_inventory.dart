import 'dart:io';
import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/price_markup.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/weight_field.dart';
import 'package:ngbuka/src/features/providers/work_hours.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

class AddInventory extends HookWidget {
  const AddInventory({super.key});
  static final productName = TextEditingController();
  static final description = TextEditingController();
  static final length = TextEditingController();
  static final width = TextEditingController();
  static final height = TextEditingController();
  static final weight = TextEditingController();
  static final volume = TextEditingController();
  static final color = TextEditingController();
  static final modelNumber = TextEditingController();
  static final inStock = TextEditingController();
  static final country = TextEditingController();
  static final price = TextEditingController();
  static final discount = TextEditingController();
  static final MechanicRepo mechanicRepo = MechanicRepo();
  static final _addInventoryKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final expanded = useState<bool>(false);
    final expanded2 = useState<bool>(false);
    final isValidated = useState<bool>(false);
    final profileImage = useState<String>(
        'https://www.shutterstock.com/image-vector/image-upload-icon-260nw-1157424790.jpg');
    final photo = useState<File?>(File(AppImages.usericon));
    final ImagePicker picker = ImagePicker();
    final FirebaseStorage storage = FirebaseStorage.instance;

    Future<void> updateProfilePicture() async {
      // Select image
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        photo.value = File(pickedFile.path);
      }

      // Upload to Firebase
      final ref = storage.ref('uploads/${DateTime.now()}.png');
      await ref.putFile(photo.value!);

      // Get URL
      final url = await ref.getDownloadURL();
      profileImage.value = url;
    }

    void clearFields() {
      productName.clear();
      description.clear();
      length.clear();
      width.clear();
      height.clear();
      weight.clear();
      volume.clear();
      color.clear();
      modelNumber.clear();
      inStock.clear();
      country.clear();
      price.clear();
      discount.clear();
    }

    final selectedUnit = useState<String>('kg');
    final convertedWeight = useState<String>('');

    addInventory() async {
      final weighty = double.parse(weight.text);
      if (selectedUnit.value == 'g') {
        convertedWeight.value = (weighty / 1000).toString();
      } else {
        convertedWeight.value = weighty.toString();
      }
      var data = {
        "name": productName.text,
        "price": price.text,
        "description": description.text,
        "imageUrl": profileImage.value,
        "quantityInStock": inStock.text,
        "discount": discount.text,
        "specifications": {
          "color": color.text,
          "width": width.text,
          "length": length.text,
          "height": height.text,
          "weight": convertedWeight.value,
          "volume": volume.text,
          "countryOfProducton": country.text,
          "modelNumber": modelNumber.text
        }
      };

      bool result = await mechanicRepo.addInventory(data);
      log(result.toString());

      if (result) {
        clearFields();
        if (context.mounted) {
          context.pop();
        }
      }
    }

    final markup = useState<List<PriceMarkup>>([]);
    final isLoading = useState<bool>(true);

    getMarkup() async {
      await mechanicRepo.getPriceMarkups().then(
        (value) {
          markup.value = value;
          isLoading.value = false;
          log(markup.value.toString());
        },
      );
    }

    showInfoModal() {
      getMarkup();
      showDialog(context: context, builder: (context) => const MyModal());
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(19.h),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 8.h,
                width: 10.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    color: AppColors.white.withOpacity(.5),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Center(
                    child: InkWell(
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
                  text: "Enter Product Info",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.black),
              heightSpace(1),
              bodyText("Edit and update product info")
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundGrey,
      body: SingleChildScrollView(
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
                      image: NetworkImage(profileImage.value)),
                ),
              ),
              heightSpace(3),
              button(true, AppColors.darkOrange, AppColors.white,
                  'Upload image', updateProfilePicture),
              heightSpace(2),
              heightSpace(3),
              customText(
                text: 'Product Details',
                fontSize: 14,
                textColor: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
              heightSpace(2),
              Form(
                onChanged: () => isValidated.value =
                    _addInventoryKey.currentState!.validate(),
                key: _addInventoryKey,
                child: Container(
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
                      CustomTextFormField(
                        isNeeded: true,
                        label: 'Product Name',
                        textEditingController: productName,
                        validator: stringValidation,
                        keyboardType: TextInputType.multiline,
                      ),
                      heightSpace(3),
                      customText(
                        text: 'Product Description',
                        fontSize: 14,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      heightSpace(2),
                      CustomTextFormField(
                        label: 'Write a brief description of the product',
                        hasMaxline: true,
                        textEditingController: description,
                      ),
                      heightSpace(3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            text: 'Product Dimensions',
                            fontSize: 14,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          IconButton(
                            icon: Icon(
                              expanded.value
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                            onPressed: () {
                              expanded.value = !expanded.value;
                            },
                          ),
                        ],
                      ),
                      heightSpace(2),
                      Column(
                        children: [
                          if (expanded.value)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        label: 'Length (L)',
                                        textEditingController: length,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    widthSpace(3),
                                    Expanded(
                                      child: CustomTextFormField(
                                        label: 'Width (W)',
                                        textEditingController: width,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    widthSpace(3),
                                    Expanded(
                                      child: CustomTextFormField(
                                        label: 'Height (H)',
                                        textEditingController: height,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                heightSpace(3),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        label: 'Volume (V)',
                                        textEditingController: volume,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    widthSpace(3),
                                    Expanded(
                                      child: CustomTextFormField(
                                        label: 'Colour',
                                        textEditingController: color,
                                      ),
                                    ),
                                  ],
                                ),
                                heightSpace(2),
                                WeightField(
                                  validator: doubleValidation,
                                  label: 'Weight(e.g, 2kg, 500g etc)',
                                  hintText:
                                      'Enter weight After Packaging(e.g., 1 kg, 500g etc)',
                                  textEditingController: weight,
                                  keyboardType: TextInputType.number,
                                  dropdown: DropdownButton<String>(
                                    value: selectedUnit.value,
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      selectedUnit.value = newValue!;
                                    },
                                    items: <String>['kg', 'g']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                heightSpace(2),
                                CustomTextFormField(
                                  label: 'Country of production',
                                  textEditingController: country,
                                ),
                                heightSpace(2),
                                CustomTextFormField(
                                  label: 'Model Number',
                                  textEditingController: modelNumber,
                                ),
                                heightSpace(3),
                              ],
                            )
                          else
                            const SizedBox.shrink()
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            text: 'Pricing and stats',
                            fontSize: 14,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          IconButton(
                            icon: Icon(
                              expanded2.value
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                            onPressed: () {
                              expanded2.value = !expanded2.value;
                            },
                          ),
                        ],
                      ),
                      heightSpace(3),
                      Column(
                        children: [
                          if (expanded2.value)
                            Column(
                              children: [
                                CustomTextFormField(
                                  isNeeded: true,
                                  label: 'In stock',
                                  textEditingController: inStock,
                                  keyboardType: TextInputType.number,
                                  validator: numericValidation,
                                ),
                                heightSpace(2),
                                CustomTextFormField(
                                  hasWidg: true,
                                  isNeeded: true,
                                  validator: numericValidation,
                                  label: 'Price',
                                  widg: GestureDetector(
                                    onTap: showInfoModal,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AppImages.warning,
                                        width: 15,
                                        height: 15,
                                      ),
                                    ),
                                  ),
                                  textEditingController: price,
                                  keyboardType: TextInputType.number,
                                ),
                                heightSpace(2),
                                CustomTextFormField(
                                  isNeeded: true,
                                  validator: numericValidation,
                                  label: 'Discount (₦)',
                                  textEditingController: discount,
                                  keyboardType: TextInputType.number,
                                ),
                                heightSpace(2),
                              ],
                            )
                          else
                            const SizedBox.shrink()
                        ],
                      )
                    ],
                  ),
                ),
              ),
              heightSpace(5),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      isActive: isValidated.value,
                      buttonText: 'Save',
                      hasIcon: false,
                      isOrange: true,
                      onTap: addInventory,
                    ),
                  ),
                ],
              ),
              heightSpace(3),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector button(
      bool hasIcon, Color bgcolor, txtColor, String text, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 7.h,
        decoration: BoxDecoration(
          color: bgcolor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1.0, color: AppColors.darkOrange),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText(
                text: text,
                textColor: txtColor,
                fontSize: 14,
              ),
              widthSpace(2),
              hasIcon
                  ? const Icon(
                      Icons.photo_camera_outlined,
                      color: AppColors.white,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

class MyModal extends HookWidget {
  const MyModal({super.key});

  @override
  Widget build(BuildContext context) {
    final markup = useState<List<PriceMarkup>>([]);
    final isLoading = useState<bool>(true);

    getMarkup() async {
      await mechanicRepo.getPriceMarkups().then(
        (value) {
          markup.value = value;
          isLoading.value = false;
          log(markup.value.toString());
        },
      );
    }

    useEffect(() {
      getMarkup();
      return null;
    }, [markup.value.length]);
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      contentPadding: const EdgeInsets.all(16.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () => context.pop(),
                child: SvgPicture.asset(AppImages.cancelModal))
          ],
        ),
        customText(
          text: 'About Markup',
          fontSize: 24,
          textColor: AppColors.black,
          fontWeight: FontWeight.w600,
          textAlignment: TextAlign.center,
        ),
        heightSpace(1),
        isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  ...markup.value.map((e) {
                    if (e.slug == 'product_price_markup') {
                      final mks = e.value * 100;
                      return customText(
                        text:
                            'A ${mks.toInt()}% markup will be included in your product price for enhanced platform services. Appreciate your understanding!',
                        fontSize: 12,
                        textColor: AppColors.black,
                        textAlignment: TextAlign.center,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                ],
              ),
        heightSpace(4)
      ],
    );
  }
}
