import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import '../../../core/shared/colors.dart';
import 'app_spacer.dart';
import 'custom_text.dart';

class WeightField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final bool isAddress;
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool hasMaxline;
  final bool? isEnabled;
  final bool? hasWidg;
  final bool? isNeeded;
  final bool? isDropdown;
  final bool? hasLabel;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final String? error;
  final Widget? widg;
  final Widget? dropdown;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  const WeightField({
    super.key,
    this.isAddress = false,
    this.label,
    this.onTap,
    this.hasMaxline = false,
    this.inputFormatters,
    this.onChanged,
    this.hintText,
    this.error,
    this.widg,
    this.dropdown,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.textEditingController,
    this.isPassword = false,
    this.hasWidg = false,
    this.isNeeded = false,
    this.validator,
    this.isEnabled,
    this.isDropdown,
    this.hasLabel,
  });

  @override
  State<WeightField> createState() => _WeightFieldState();
}

class _WeightFieldState extends State<WeightField> {
  bool isPasswordShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: '${widget.label}',
                  fontSize: 14,
                  textColor: AppColors.primary,
                ),
                customText(
                  text: 'weight after packaging',
                  fontSize: 10,
                  textColor: AppColors.primary,
                ),
              ],
            ),
            widget.hasWidg! ? widget.widg! : const SizedBox.shrink(),
            widthSpace(2),
            customText(
              text: '*',
              fontSize: 12,
              textColor: AppColors.red,
            ),
            widthSpace(1),
            Container(
              width: 10.w,
              height: 3.7.h,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppColors.containerGrey,
              ),
              child: Image.asset(
                AppImages.weightPackage,
              ),
            ),
          ],
        ),
        heightSpace(1),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.textformGrey),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: widget.dropdown!,
              ),
              Expanded(
                child: TextFormField(
                  enabled: widget.isEnabled,
                  onTap: widget.onTap,
                  maxLines: widget.hasMaxline ? 8 : 1,
                  cursorColor: AppColors.primary,
                  cursorWidth: 1,
                  onChanged: widget.onChanged,
                  keyboardType: widget.keyboardType,
                  controller: widget.textEditingController,
                  obscureText: isPasswordShow ? false : widget.isPassword,
                  validator: widget.validator,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textformGrey),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    errorText: widget.error,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textformGrey),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    contentPadding: const EdgeInsets.only(left: 10, top: 20),
                    errorStyle: const TextStyle(fontSize: 14),
                    // suffixIcon:  showPasswordIcon(widget.isPassword),

                    suffixIcon: (() {
                      if (widget.isPassword) {
                        return showPasswordIcon(widget.isPassword);
                      }
                      if (widget.isAddress) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.textformGrey),
                                shape: BoxShape.circle),
                            child: const Icon(Icons.location_on_outlined),
                          ),
                        );
                      }
                      if (widget.isDropdown != null ||
                          widget.isDropdown == true) {
                        return const Icon(Icons.keyboard_arrow_down);
                      }
                    }()),
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: AppColors.textGrey.withOpacity(0.3)),
                    prefixIcon: widget.prefixIcon,
                    fillColor: AppColors.white,
                    filled: true,
                    enabledBorder: AppColors.emptyBorder,
                    errorBorder: AppColors.errorBorder,
                    focusedBorder: AppColors.normalBorder,
                    focusedErrorBorder: AppColors.normalBorder,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  showPasswordIcon(bool isPassword) {
    if (isPassword) {
      if (isPasswordShow) {
        return IconButton(
          icon: const Icon(
            Icons.visibility,
            color: AppColors.primary,
          ),
          onPressed: () => setState(() {
            isPasswordShow = !isPasswordShow;
          }),
        );
      }
      return IconButton(
        icon: const Icon(
          Icons.visibility_off,
          size: 18,
          color: AppColors.primary,
        ),
        onPressed: () => setState(() {
          isPasswordShow = !isPasswordShow;
        }),
      );
    }
  }
}
