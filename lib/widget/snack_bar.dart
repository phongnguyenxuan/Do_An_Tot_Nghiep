import 'package:do_an_tot_nghiep/configs/basic_config.dart';
import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snack_bar/custom_snack_bar.dart';
import 'package:top_snack_bar/snack_bar.dart';

import '../configs/constants.dart';

void showError(String title, String content) {
  showTopSnackBar(
    Overlay.of(navigatorKey.currentState!.context),
    CustomSnackBar.error(
      title: title,
      message: content,
      backgroundColor: kColorRed,
      titleStyle: TextStyle(
          fontFamily: kfontFamily, color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
      textStyle: TextStyle(
          fontFamily: kfontFamily, color: Colors.white, fontSize: 14.sp,height: 1.25),
    ),
  );
}

void showNotifi(String title, String content) {
  showTopSnackBar(
    Overlay.of(navigatorKey.currentState!.context),
    CustomSnackBar.info(
      message: content,
      title: title,
      titleStyle: TextStyle(
          fontFamily: kfontFamily, color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
      textStyle: TextStyle(
          fontFamily: kfontFamily, color: Colors.white, fontSize: 14.sp,height: 1.25),
    ),
  );
}

void showSuccess(String title, String content) {
  showTopSnackBar(
    Overlay.of(navigatorKey.currentState!.context),
    CustomSnackBar.success(
      message: content,
      title: title,
      backgroundColor: kColorGreen,
      titleStyle: TextStyle(
          fontFamily: kfontFamily, color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
      textStyle: TextStyle(
          fontFamily: kfontFamily, color: Colors.white, fontSize: 14.sp,height: 1.25),
    ),
  );
}
