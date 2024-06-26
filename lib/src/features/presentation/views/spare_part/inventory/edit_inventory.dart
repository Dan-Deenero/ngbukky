import 'dart:io';
import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/weight_field.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';

class EditInventory extends HookWidget {
  final String id;
  EditInventory({
    super.key,
    required this.id,
  });
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
  static final price = TextEditingController();
  static final discount = TextEditingController();
  static final country = TextEditingController();

  final MechanicRepo _mechanicRepo = MechanicRepo();
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final expanded = useState<bool>(false);
    final expanded2 = useState<bool>(false);
    final isValidated = useState<bool>(false);
    final profileImage = useState<String?>(null);
    final isLoading = useState<bool>(true);
    String image = '';
    final photo = useState<File?>(File(AppImages.usericon));
    final ImagePicker picker = ImagePicker();
    final FirebaseStorage storage = FirebaseStorage.instance;

    getInventory() {
      _mechanicRepo.getOneInventory(id).then(
        (value) {
          productName.text = value.name!;
          description.text =
              value.description == null ? "" : value.description!;
          inStock.text = value.quantityInStock!.toString();
          price.text = value.price!.toString();
          discount.text = value.discount!.toString();
          length.text = value.specifications!.length == null
              ? ""
              : value.specifications!.length!;
          width.text = value.specifications!.width == null
              ? ""
              : value.specifications!.width!;
          height.text = value.specifications!.height == null
              ? ""
              : value.specifications!.height!;
        value.specifications!.weight!.toString();
          volume.text = value.specifications!.volume == null
              ? ""
              : value.specifications!.volume!;
          color.text = value.specifications!.color!;
          modelNumber.text = value.specifications!.modelNumber == null
              ? ""
              : value.specifications!.modelNumber!;
          country.text = value.specifications!.countryOfProducton == null
              ? ""
              : value.specifications!.countryOfProducton!;
          profileImage.value = value.imageUrl!;
          // image = value.imageUrl!;

          log(image.toString());
          isLoading.value = false;
        },
      );
    }

    final selectedUnit = useState<String>('kg');
    final convertedWeight = useState<String>('');

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

    updateInventory() async {
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

      log(data.toString());

      bool result = await _mechanicRepo.updateInventory(data, id);
      log(result.toString());

      if (result) {
        if (context.mounted) {
          context.pop(result);
        }
      }
    }

    useEffect(() {
      getInventory();
      return null;
    }, []);
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
                text: "Edit Product Info",
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
      body: isLoading.value
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
                          image: NetworkImage(profileImage.value!),
                        ),
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
                      onChanged: () =>
                          isValidated.value = _formKey.currentState!.validate(),
                      key: _formKey,
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
                              label: 'Product Name',
                              textEditingController: productName,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextFormField(
                                              label: 'Length (L)',
                                              textEditingController: length,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          widthSpace(3),
                                          Expanded(
                                            child: CustomTextFormField(
                                              label: 'Width (W)',
                                              textEditingController: width,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          widthSpace(3),
                                          Expanded(
                                            child: CustomTextFormField(
                                              label: 'Height (H)',
                                              textEditingController: height,
                                              keyboardType:
                                                  TextInputType.number,
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
                                              keyboardType:
                                                  TextInputType.number,
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
                                        label: 'Weight (e.g., 1 kg, 500g etc)',
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
                                        label: 'In stock',
                                        textEditingController: inStock,
                                      ),
                                      heightSpace(2),
                                      CustomTextFormField(
                                        validator: numericValidation,
                                        label: 'Price',
                                        textEditingController: price,
                                      ),
                                      heightSpace(2),
                                      CustomTextFormField(
                                        validator: numericValidation,
                                        label: 'Discount (₦)',
                                        textEditingController: discount,
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
                    AppButton(
                      buttonText: 'Save changes',
                      hasIcon: false,
                      isOrange: true,
                      onTap: updateInventory,
                    ),
                    heightSpace(3),
                    GestureDetector(
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
