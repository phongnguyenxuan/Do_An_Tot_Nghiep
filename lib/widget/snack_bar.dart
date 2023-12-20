import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../configs/constants.dart';

void showError(String content) {
  if(Get.isSnackbarOpen) return;
  Get.snackbar(
    "",
    "",
    backgroundColor: kColorRed,
    titleText: Text(
      "Error",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: kfontFamily, color: Colors.white, fontSize: 15.sp),
    ),
    messageText: Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: kfontFamily, color: Colors.white, fontSize: 14.sp),
    ),
  );
}

void showNotifi(String title, String content) {
  if(Get.isSnackbarOpen) return;
  Get.snackbar(
    "",
    "",
    backgroundColor: kColorPrimary,
    titleText: Text(
      "!!",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: kfontFamily, color: Colors.white, fontSize: 15.sp),
    ),
    messageText: Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: kfontFamily, color: Colors.white, fontSize: 14.sp),
    ),
  );
}

void showSuccess(String title, String content) {
  if(Get.isSnackbarOpen) return;
  Get.snackbar(
    "",
    "",
    backgroundColor: kColorGreen,
    titleText: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: kfontFamily, color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700),
    ),
    messageText: Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: kfontFamily, color: Colors.white, fontSize: 14.sp),
    ),
  );
}
