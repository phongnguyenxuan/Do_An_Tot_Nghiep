import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../../../configs/style_config.dart';
import '../../../provider/app_state.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/timer_widget.dart';
import '../explain_screen.dart';
import '../score_overlay.dart';
import 'play_widget.dart';

class FindPairScreen extends StatefulWidget {
  const FindPairScreen({super.key});
  static const String id = "FindPair Screen";

  @override
  State<FindPairScreen> createState() => _FindPairScreenState();
}

class _FindPairScreenState extends State<FindPairScreen> {
  int _currentIndex = -1;
  void delay() {
    Future.delayed(const Duration(milliseconds: 4300), () {
      setState(() {
        _currentIndex = 1;
      });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<AppState, Tuple2<int, int>>(
        selector: (ctx, state) => Tuple2(state.level, state.findPairScore),
        builder: (context, value, _) {
          int grade = value.item2;
          return Builder(
            builder: (context) {
              if (_currentIndex == -1)
                return ExplainScreen(title: translate.findPairMessage);
              return Scaffold(
                backgroundColor: kColorWhite,
                appBar: CustomAppBar(
                  title: "Level ${value.item1}",
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
                              Text(
                                "$grade",
                                style: TextStyle(
                                  fontSize: 16.sp,
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
                    Column(
                      children: [
                        Selector<AppState, Tuple2<int, bool>>(
                            selector: (ctx, state) =>
                                Tuple2(state.levelTime, state.isShowingCard),
                            builder: (context, val, child) {
                              return val.item2
                                  ? TimerWidget(
                                      isSubmit: false,
                                      onTimerEnd: () async {
                                        Future.delayed(const Duration(seconds: 2),
                                            () {
                                          context
                                              .read<AppState>()
                                              .showResultFindPair(context);
                                        });
                                      },
                                      reBuild: false,
                                      countTime: val.item1,
                                    )
                                  : const SizedBox(
                                      height: 4,
                                    );
                            }),
                        const Expanded(child: PlayWidget()),
                      ],
                    ),
                    Selector<AppState, Tuple2<int, int>>(
                      selector: (ctx, state) =>
                          Tuple2(state.score, state.streak),
                      builder: (context, value, child) => ScoreOverlay(
                          bonus: 0, score: value.item1, streak: value.item2),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
