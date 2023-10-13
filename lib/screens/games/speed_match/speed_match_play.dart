import 'dart:math';

import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:do_an_tot_nghiep/provider/app_state.dart';
import 'package:do_an_tot_nghiep/screens/games/speed_match/card_animation.dart';
import 'package:do_an_tot_nghiep/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../widget/custom_elevated_widget.dart';

class SpeedMatchPlay extends StatefulWidget {
  const SpeedMatchPlay({super.key});

  @override
  State<SpeedMatchPlay> createState() => _SpeedMatchPlayState();
}

class _SpeedMatchPlayState extends State<SpeedMatchPlay> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppState>().delay();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dose the CURRENT card match the card that came IMEDIATELY BEFORE it ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: CustomElevatedWidget(
                                backGroundColor: kShadowColor2,
                                shadowColor: kShadowColor,
                                elevation: 5,
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(width: 2, color: kColorBlack),
                                child: Container(),
                              ),
                            ),
                          ),
                          AnimatedCard(
                            duration: const Duration(milliseconds: 400),
                            radians: pi / 2,
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: CustomElevatedWidget(
                                  backGroundColor: Colors.white,
                                  shadowColor: kShadowColor,
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(width: 2, color: kColorBlack),
                                  child: Container(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Selector<AppState, String>(
                                selector: (ctx, state) => state.currentType,
                                builder: (context, value, child) => Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    backgroundBlendMode: BlendMode.multiply,
                                    borderRadius: BorderRadius.circular(15),
                                    color: kShadowColor2,
                                    border: Border.all(
                                        color: kColorStroke, width: 2),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: value != ""
                                          ? DecorationImage(
                                              image: AssetImage(
                                                "assets/images/shape/$value.png",
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AnimatedCard(
                            duration: const Duration(milliseconds: 300),
                            radians: pi / 2,
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: kColorStroke, width: 2),
                                  ),
                                  child: Selector<AppState, String>(
                                    selector: (ctx, state) => state.type,
                                    builder: (context, value, child) =>
                                        value != ""
                                            ? Image.asset(
                                                "assets/images/shape/$value.png",
                                              )
                                            : Container(),
                                  ),
                                  // child: Image.asset("assets/images/shape/${context.read<AppState>().type}.png"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: CustomElevatedWidget(
                                backGroundColor: kShadowColor2,
                                shadowColor: kShadowColor,
                                elevation: 5,
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(width: 2, color: kColorBlack),
                                child: Container(),
                              ),
                            ),
                          ),
                          AnimatedCard(
                            duration: const Duration(milliseconds: 200),
                            radians: pi / 2,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: CustomElevatedWidget(
                                  backGroundColor: Colors.white,
                                  shadowColor: kShadowColor,
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(width: 2, color: kColorBlack),
                                  child: Container(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Selector<AppState, bool>(
            selector: (_, myType) => myType.canPick,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: 150.w,
                    height: 50.h,
                    borderRadius: BorderRadius.circular(10),
                    buttonBorder: Border.all(width: 2, color: kColorBlack),
                    color: kColorRed,
                    shadowColor: kShadowRed,
                    onPress: value ? () async {
                      context.read<AppState>().onPickAnswer(false);
                    } : null,
                    child: Text(
                      "No",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  CustomButton(
                    width: 150.w,
                    height: 50.h,
                    borderRadius: BorderRadius.circular(10),
                    buttonBorder: Border.all(width: 2, color: kColorBlack),
                    color: kColorGreen,
                    shadowColor: kShadowGreen,
                    onPress: value ? () {
                      context.read<AppState>().onPickAnswer(true);
                    }: null,
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}
