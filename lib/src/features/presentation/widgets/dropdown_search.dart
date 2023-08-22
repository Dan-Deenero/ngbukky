import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ngbuka/src/core/shared/colors.dart';

class AppDropdDownSearch extends StatelessWidget {
  final String? Function(List<String>?)? onChanged;
  final Widget? prefixIcon;
  final String? hintText;
  final List<String> selectedItems;
  const AppDropdDownSearch(
      {super.key,
      this.hintText,
      this.onChanged,
      required this.selectedItems,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>.multiSelection(
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: hintText,
            fillColor: AppColors.white,
            filled: true,
            prefixIcon: prefixIcon,
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textformGrey),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textformGrey),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            contentPadding: const EdgeInsets.only(left: 10, top: 10),
          ),
        ),
        items: selectedItems,
        popupProps: const PopupPropsMultiSelection.menu(
          showSelectedItems: true,
        ),
        selectedItems: const [],
        validator: (value) => (value!.isEmpty) ? 'Required' : null,
        onChanged: onChanged);
  }
}
