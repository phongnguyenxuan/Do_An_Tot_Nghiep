import 'package:confetti/confetti.dart';
import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:do_an_tot_nghiep/provider/app_state.dart';
import 'package:do_an_tot_nghiep/screens/result/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
  final ConfettiController _controllerCenter =
      ConfettiController(duration: const Duration(seconds: 4));
  @override
  void initState() {
    super.initState();
    if (widget.newRecord) {
      _controllerCenter.play();
      context.read<AppState>().playExtraSound(highScoreSound);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: CustomAppBar(
        title: widget.title,
      ),
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Column(
                    children: [
                      CustomText(
                          title: (widget.newRecord && widget.grade != 0)
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
                            "assets/images/${(widget.newRecord && widget.grade != 0) ? "highscore" : "results"}.png",
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
                        Navigator.of(context)
                            .pushReplacementNamed(StatusScreen.id);
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
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
