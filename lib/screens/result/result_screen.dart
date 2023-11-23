import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:do_an_tot_nghiep/screens/result/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../configs/basic_config.dart';
import '../../configs/style_config.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';

// ignore: must_be_immutable
class ResultScreen extends StatefulWidget {
  ResultScreen({
    super.key,
    required this.title,
    this.grade = 0,
    this.newRecord = false,
    required this.highscore,
  });
  final String title;
  int grade;
  bool newRecord;
  final int highscore;

  static const String id = "ResultScreen";

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool newRecord = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: CustomAppBar(
        title: widget.title,
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            Column(
              children: [
                CustomText(
                    title: widget.newRecord
                        ? translate.highScore
                        : translate.score,
                    fontSize: 25.sp,
                    strokeWidth: 2,
                    color: Colors.black),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/star.png",
                        height: 30.w,
                        width: 30.w,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        widget.grade.toString(),
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: kfontFamily,
                          color: kColorBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !widget.newRecord,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "${translate.highScore} : ${widget.highscore}",
                      style: TextStyle(
                          fontFamily: kfontFamily,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Image.asset(
                      "assets/images/${widget.newRecord ? "highscore" : "results"}.png",
                      height: 150.h,
                      width: 150.w),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButton(
                onPress: () {
                  navigatorKey.currentState
                      ?.pushReplacementNamed(StatusScreen.id);
                },
                color: Colors.white,
                shadowColor: kShadowColor2,
                minWidth: double.maxFinite,
                borderRadius: BorderRadius.circular(16),
                minHeight: 60.h,
                buttonBorder: Border.all(color: kBorderColor, width: 2),
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      translate.continuew,
                      style: k18BlackTextStyle,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      "assets/images/arrow-right.png",
                      width: 20.w,
                      height: 20.h,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
