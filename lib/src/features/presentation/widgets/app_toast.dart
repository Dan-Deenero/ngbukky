import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ngbuka/src/core/shared/colors.dart';

class ToastResp {
  static toastMsgError({String? resp}) {
    return Fluttertoast.showToast(
        timeInSecForIosWeb: 4,
        msg: resp.toString(),
        backgroundColor: AppColors.red,
        textColor: Colors.white,
        fontSize: 11.sp);
  }

  static toastMsgInfo({String? resp}) {
    return Fluttertoast.showToast(
        msg: resp.toString(),
        timeInSecForIosWeb: 4,
        backgroundColor: AppColors.normalBlue,
        textColor: Colors.white,
        fontSize: 11.sp);
  }

  static toastMsgSuccess({String? resp}) {
    return Fluttertoast.showToast(
        timeInSecForIosWeb: 4,
        msg: resp.toString(),
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 11.sp);
  }
}
