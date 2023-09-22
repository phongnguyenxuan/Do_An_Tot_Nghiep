
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../configs/style_config.dart';
import '../widget/custom_button.dart';
import '../widget/custom_elevated_widget.dart';

class ResultDialog extends StatelessWidget {
  const ResultDialog({super.key, required this.process});
  final int process;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 40),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor)
        ),
        child: CustomElevatedWidget(
          backGroundColor: Colors.white, 
          shadowColor: kShadowColor2,
          borderRadius: BorderRadius.circular(20),
          elevation: 5, 
          child: Container(
            padding: const EdgeInsets.fromLTRB(25, 22, 25, 26),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                 "resultLearnAlertTitle",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kColorBlack,
                    fontSize: 22.sp,
                    height: 1.36
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 198.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 153.h,
                        width: 169.h,
                        child: Image.asset(
                          "assets/images/result.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Visibility(
                          visible: process > 0,
                          child: Transform.rotate(
                            angle: 0.35,
                            child: Container(
                              width: 60.w,
                              height: 45.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration( 
                                border: Border.all(
                                  color: kColorGreen,
                                  width: 2
                                ),
                                borderRadius: BorderRadius.all(Radius.elliptical(60.w, 45.h))
                              ),
                              child: Text(
                                "+${process.toInt()}%",
                                style: TextStyle(
                                  color: kColorGreen,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                CustomButton(
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                  minWidth: double.maxFinite,
                  buttonBorder: Border.all(
                    color: kBorderColor
                  ),
                  shadowColor: kShadowColor,
                  minHeight: 56.sp,
                  borderRadius: BorderRadius.circular(16),
                  child: Text(
                    "great",
                    style: TextStyle(
                      color: kColorBlack,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500
                    ),
                  )
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}