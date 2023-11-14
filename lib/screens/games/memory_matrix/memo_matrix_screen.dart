import 'dart:async';

import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../configs/style_config.dart';
import '../../../provider/app_state.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_elevated_widget.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/timer_widget.dart';
import '../explain_screen.dart';
import '../score_overlay.dart';

class MemoMatrixScreen extends StatefulWidget {
  const MemoMatrixScreen({super.key});
  static const String id = "MemoMatrixScreen";

  @override
  State<MemoMatrixScreen> createState() => _MemoMatrixScreenState();
}

class _MemoMatrixScreenState extends State<MemoMatrixScreen> {
  int _currentIndex = -1;
  Timer? _timer;
  int indexBlockPickWrong = -1;
  bool cancelTimer = false;
  List<int>listPickBlockCorrect = [];

  void delay() {
    Future.delayed(const Duration(milliseconds: 4300), () {
      setState(() {
        _currentIndex = 1;
      });
      context.read<AppState>().showCorrectBlock();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      delay();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Builder(builder: (c) {
        if (_currentIndex == -1) {
          return ExplainScreen(
            title: translate.memoMessage,
          );
        }
        return Scaffold(
          backgroundColor: kColorWhite,
          appBar: CustomAppBar(
            title: "",
            actions: [
              Visibility(
                visible: _currentIndex != -1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/star.png",
                          height: 30.w,
                          width: 30.h,
                        ),
                        const SizedBox(width: 7),
                        //score
                        Text(
                          "${context.read<AppState>().memoScore}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: kColorBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Selector<AppState, Tuple3<bool, bool, bool>>(
                selector: (_, state) => Tuple3(state.isShowCorrect,
                    state.isAnimatedGrid, state.isPrepareGrid),
                builder: (context, val, child) {
                  bool isShowCorrect = val.item1;
                  bool isAnimatedGrid = val.item2;
                  bool isPrepareGrid = val.item3;
                  return Column(
                    children: [
                      isShowCorrect || isAnimatedGrid
                          ? const SizedBox(height: 4)
                          : TimerWidget(
                              isSubmit: !context.read<AppState>().canPickBlock,
                              onTimerEnd: () {
                                if (!context.read<AppState>().cancelTimer) {
                                  context.read<AppState>().showResult(context);
                                }
                              },
                              reBuild: false,
                              countTime: 15,
                            ),
                      Expanded(
                        child: Selector<AppState, int>(
                            selector: (_, state) => state.levelModel.total,
                            builder: (context, value, _) {
                              return Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 40.sp),
                                      child: Stack(
                                        children: <Widget>[
                                          CustomText(
                                            title: "Level ${context.read<AppState>().currentPlayingIndex}",
                                            fontSize: 32.sp,
                                            strokeWidth: 2,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Builder(builder: (context) {
                                          if (isPrepareGrid) {
                                            return const SizedBox();
                                          }
                                          return SizedBox(
                                            width: context.read<AppState>().levelModel.row * 42 +
                                                ((context.read<AppState>().levelModel.row -1) * 7),
                                            child: AnimationLimiter(
                                              child: GridView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: context.read<AppState>().levelModel.row,
                                                  crossAxisSpacing: 7,
                                                  mainAxisSpacing: 7,
                                                  childAspectRatio: 1,
                                                  mainAxisExtent: 42,
                                                ),
                                                itemCount: value,
                                                itemBuilder: (BuildContext context, index) {
                                                  return AnimationConfiguration.staggeredGrid(
                                                    columnCount: context.read<AppState>().levelModel.row,
                                                    position: index,
                                                    duration: Duration(
                                                        milliseconds: (1000 / value).floor()),
                                                    child: ScaleAnimation(
                                                      duration:
                                                          const Duration(
                                                              milliseconds:
                                                                  700),
                                                      child: FadeInAnimation(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    700),
                                                        child: GestureDetector(
                                                          onTap: context.read<AppState>().canPickBlock
                                                              ? () {
                                                                setState(() {
                                                                  listPickBlockCorrect = context.read<AppState>().listPickBlockCorrect;
                                                                });
                                                                  context.read<AppState>().onPickBlock(index,context);
                                                                }
                                                              : null,
                                                          child: CustomElevatedWidget(
                                                            shadowColor: ((context.read<AppState>().listCorrectBlock.contains(index)
                                                                          && isShowCorrect) ||
                                                                    context.read<AppState>()
                                                                        .listPickBlockCorrect
                                                                        .contains(index))
                                                                ? kShadowBrightCyan
                                                                : context.read<AppState>().indexBlockPickWrong ==
                                                                        index
                                                                    ? kShadowRed
                                                                    : kShadowColor,
                                                            backGroundColor: ((context.read<AppState>().listCorrectBlock.contains(
                                                                            index) &&
                                                                        isShowCorrect) ||
                                                                        listPickBlockCorrect
                                                                        .contains(index))
                                                                ? kColorBrightCyan
                                                                : context.read<AppState>().indexBlockPickWrong == index
                                                                    ? kColorRed
                                                                    : kColorOrangeLight,
                                                            elevation: 3,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            border: Border.all(
                                                                color:
                                                                    kColorStroke,
                                                                width: 0.5),
                                                            child:
                                                                const SizedBox(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                },
              ),
              Stack(
                children: List<Widget>.generate(
                    context.read<AppState>().listScore.length,
                    (indx) => ScoreOverlay(
                          score:  context.read<AppState>().memoScore,
                          bonus:  context.read<AppState>().bonus,
                          streak: 0,
                        )),
              ),
                ScoreOverlay(score: context.read<AppState>().memoScore, streak: 1, bonus: context.read<AppState>().bonus,)
            ],
          ),
        );
      }),
    );
  }
}
