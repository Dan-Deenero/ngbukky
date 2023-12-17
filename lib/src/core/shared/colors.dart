import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff0D0D3D);
  static const Color boardingBlue = Color(0xffE0E1FF);
  static const Color scaffoldColor = Color(0xffF8F8FF);
  static const Color red = Colors.red;
  static const Color orange = Color(0xffD47604);
  static const Color textColor = Color(0xff585865);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color lightBlue = Color(0xffAFB6FD);
  static const Color veryLightOrange = Color(0xffFFF8EF);
  static const Color lightOrange = Color(0xffED6150);
  static const Color darkOrange = Color(0xffAA5F03);
  static const Color normalBlue = Color(0xff1A1A7A);
  static const Color textformGrey = Color(0xffdddce1);
  static const Color containerOrange = Color(0xffFFEDED);
  static const borderGrey = Color(0xFFE2E8F0);
  static const backgroundGrey = Color(0xFFF1F5F9);
  static const checkBoxColor = Color(0xfffaa5f03);
  static const containerGrey = Color(0xFFE2E8F0);
  static const green = Color(0xff2BAF29);
  static const lightgreen = Color(0xffECFFF1);
  static const textGrey = Color(0xFF64748B);
  static OutlineInputBorder errorBorder = const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)));
  static OutlineInputBorder normalBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.all(Radius.circular(20)));

  static OutlineInputBorder emptyBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textformGrey),
      borderRadius: BorderRadius.all(Radius.circular(20)));
}
