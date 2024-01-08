import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/shared/colors.dart';
import 'app_spacer.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final bool isAddress;
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool hasMaxline;
  final bool? isEnabled;
  final bool? hasWidg;
  final bool? isDropdown;
  final bool? hasLabel;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final String? error;
  final Widget? widg;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  const CustomTextFormField({
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
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.textEditingController,
    this.isPassword = false,
    this.hasWidg = false,
    this.validator,
    this.isEnabled,
    this.isDropdown,
    this.hasLabel,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isPasswordShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText(
              text: '${widget.label}',
              fontSize: 14,
              textColor: AppColors.primary,
            ),
            widget.hasWidg! ? 
            widget.widg! : const SizedBox.shrink()
          ],
        ),
        heightSpace(1),
        TextFormField(
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
                        border: Border.all(color: AppColors.textformGrey),
                        shape: BoxShape.circle),
                    child: const Icon(Icons.location_on_outlined),
                  ),
                );
              }
              if (widget.isDropdown != null || widget.isDropdown == true) {
                return const Icon(Icons.keyboard_arrow_down);
              }
            }()),
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontSize: 14, color: AppColors.textGrey.withOpacity(0.3)),
            prefixIcon: widget.prefixIcon,
            fillColor: AppColors.white,
            filled: true,
            enabledBorder: AppColors.emptyBorder,
            errorBorder: AppColors.errorBorder,
            focusedBorder: AppColors.normalBorder,
            focusedErrorBorder: AppColors.normalBorder,
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
