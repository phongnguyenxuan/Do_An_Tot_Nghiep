import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:do_an_tot_nghiep/screens/games/speed_match/speed_match_play.dart';
import 'package:do_an_tot_nghiep/widget/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../configs/style_config.dart';
import '../../../provider/app_state.dart';
import '../../../widget/custom_appbar.dart';
import '../explain_screen.dart';
import '../score_overlay.dart';

class SpeedMatchScreen extends StatefulWidget {
  const SpeedMatchScreen({super.key});
  static const String id = "Speed Match Screen";

  @override
  State<SpeedMatchScreen> createState() => _SpeedMatchScreenState();
}

class _SpeedMatchScreenState extends State<SpeedMatchScreen> {
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
    delay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (_currentIndex == -1) {
          return ExplainScreen(title: translate.speedMatchMessage);
        }
        return Selector<AppState, Tuple2<int, bool>>(
          selector: (_, state) =>
              Tuple2(state.speedMatchScore, state.isShowing),
          builder: (context, value, child) {
            return Scaffold(
              backgroundColor: kColorWhite,
              appBar: CustomAppBar(
                title: "Speed Match",
                actions: [
                  Visibility(
                    visible: true,
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
                              value.item1.toString(),
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
                children: [
                  Column(
                    children: [
                      value.item2
                          ? const SizedBox(
                              height: 4,
                            )
                          : TimerWidget(
                              onTimerEnd: () {
                                Future.delayed(const Duration(seconds: 2), () {
                                  context
                                      .read<AppState>()
                                      .showResultSpeedMatch(context);
                                });
                              },
                              reBuild: false,
                              isSubmit: false,
                              countTime: 45,
                            ),
                      const Expanded(child: SpeedMatchPlay()),
                    ],
                  ),
                  Stack(
                    children: List<Widget>.generate(
                        context.read<AppState>().listScore.length,
                        (indx) => Selector<AppState, Tuple2<int, int>>(
                              selector: (ctx, state) =>
                                  Tuple2(state.score, state.streak),
                              builder: (context, value, child) => ScoreOverlay(
                                  bonus: 0,
                                  score: value.item1,
                                  streak: value.item2),
                            )),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
