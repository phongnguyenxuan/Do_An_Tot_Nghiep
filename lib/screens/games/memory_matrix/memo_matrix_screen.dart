import 'dart:async';

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
import '../../home/home_screen.dart';
import '../../result/result_screen.dart';
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

  Future<bool> _onWillPop() async {
    return true;
  }

  // Future<bool> _onGoBack() async {
  //   if (_currentIndex == -1) return true;
  //   final result = await showConfirmDialog(context, title: "stopPlayMessage", confirmTitle: "yes") ?? true;
  //   return result;
  // }

  // void _showCorrectBlock() async {
  //   setState(() {
  //     _isAnimatedGrid = true;
  //     _isPrepareGrid = true;
  //   });
  //   await Future.delayed(const Duration(milliseconds: 100));
  //   setState(() {
  //     _isPrepareGrid = false;
  //   });

  //   await Future.delayed(const Duration(milliseconds: 1500));
  //   setState(() {
  //     _isShowCorrect = true;
  //   });
  //   _timer = Timer(const Duration(milliseconds: 2000), () {
  //     if (!mounted) return;
  //     setState(() {
  //       _isShowCorrect = false;
  //       _isAnimatedGrid = false;
  //     });
  //   });
  // }

  // void _onPickBlock(int index) {
  //   if (_isShowCorrect) return;

  //   if (listPickBlockCorrect.contains(index)) return;

  //   if (context.read<AppState>().listCorrectBlock.contains(index)) {
  //     setState(() {
  //       listPickBlockCorrect.add(index);
  //       listScore.add(1);
  //       score += 10;
  //     });
  //     if (listPickBlockCorrect.length ==
  //         context.read<AppState>().listCorrectBlock.length) {
  //       setState(() {
  //         listScore.clear();
  //         listScore.add(1);
  //         canPickBlock = false;
  //         cancelTimer = true;
  //         bonus = 50;
  //         score += bonus;
  //       });
  //       _timer = Timer(const Duration(milliseconds: 1500), () {
  //         if (!mounted) return;
  //         setState(() {
  //           indexBlockPickWrong = -1;
  //           listPickBlockCorrect.clear();
  //           _currentPlayingIndex = _currentPlayingIndex + 1;
  //           context.read<AppState>().generateBlock(level: _currentPlayingIndex);
  //           _showCorrectBlock();
  //           canPickBlock = true;
  //           cancelTimer = false;
  //           bonus = 0;
  //         });
  //       });
  //     }
  //   } else {
  //     canPickBlock = false;
  //     setState(() {
  //       indexBlockPickWrong = index;
  //       cancelTimer = true;
  //       _isShowCorrect = true;
  //     });
  //     _timer = Timer(const Duration(milliseconds: 2000), () {
  //       canPickBlock = true;
  //       _isShowCorrect = false;
  //       _showResult();
  //     });
  //   }
  // }

  // Future<void> _showResult() async {
  //   await Navigator.of(context)
  //       .push(MaterialPageRoute(
  //           builder: (_) => ResultScreen(
  //                 title: "Memory Matrix",
  //                 grade: score,
  //                 highscore: context.read<AppState>().memoHighScore,
  //                 newRecord: (score > context.read<AppState>().memoHighScore),
  //               ),
  //           settings: const RouteSettings(name: ResultScreen.id)))
  //       .then((value) async {
  //     await _onWillPop();
  //     if (!mounted) return;
  //     if (value == false) {
  //       Navigator.of(context).popUntil(ModalRoute.withName(HomeScreen.id));
  //     } else if (value == null) {
  //       Navigator.of(context).pop();
  //     } else {
  //       setState(() {
  //         context.read<AppState>().generateBlock();
  //         _currentIndex = -1;
  //         cancelTimer = false;
  //         indexBlockPickWrong = -1;
  //         listPickBlockCorrect.clear();
  //         _currentPlayingIndex = 1;
  //       });
  //       delay();
  //     }
  //   });
  //   if (!mounted) return;
  //   if (score > context.read<AppState>().memoHighScore) {
  //     context.read<AppState>().record = score;
  //   }
  // }

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
      child: Container(
        decoration: const BoxDecoration(
            color: kColorWhite,
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/bg.png",
                ),
                fit: BoxFit.cover)),
        child: Builder(builder: (c) {
          if (_currentIndex == -1)
            return ExplainScreen(
              title: "MemoMatrix message",
            );
          return Scaffold(
            appBar: CustomAppBar(
              title: "",
              onBackButtonPress: () async {
                return true;
              },
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
      ),
    );
  }
}
