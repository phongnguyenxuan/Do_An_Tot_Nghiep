import 'package:do_an_tot_nghiep/provider/app_state.dart';
import 'package:do_an_tot_nghiep/screens/games/math_game/math_play.dart';
import 'package:do_an_tot_nghiep/widget/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../configs/basic_config.dart';
import '../../../configs/constants.dart';
import '../../../configs/style_config.dart';
import '../../../widget/custom_appbar.dart';
import '../../result/result_screen.dart';
import '../explain_screen.dart';
import '../score_overlay.dart';

class MathScreen extends StatefulWidget {
  const MathScreen({super.key});
  static const String id = "Math Screen";

  @override
  State<MathScreen> createState() => _MathScreenState();
}

class _MathScreenState extends State<MathScreen> {
  int _currentIndex = -1;
  int _currentPlayingIndex = 0;
  int streak = 0;
  int score = 0;
  int mathScore = 0;
  void _onPlayCorrect(bool isCorrect, int answer) {
    setState(() {
      if (isCorrect) {
        streak++;
        score = 10 + 5 * (streak - 1);
        mathScore = mathScore + score;
      } else {
        streak = 0;
      }
      _currentPlayingIndex++;
    });
  }

  Future<void> _showResult() async {
    debugPrint("asfdsdafsa $mathScore");
    await boxPlayData.put("math", mathScore);
    if (mounted) {
      context.read<AppState>().setTotalScore();
      await navigatorKey.currentState
        ?.pushReplacement(MaterialPageRoute(
              builder: (_) => ResultScreen(
                    title: "Math",
                    grade: mathScore,
                    highscore: context.read<AppState>().mathHighScore,
                    newRecord:
                        (mathScore > context.read<AppState>().mathHighScore),
                  ),
              settings: const RouteSettings(name: ResultScreen.id)))
          .then((value) {
        if (!mounted) return;
        if (mathScore > context.read<AppState>().mathHighScore) {
          context.read<AppState>().mathHighScore = mathScore;
        }
      });
    }
  }

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
    mathScore = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (_currentIndex == -1) {
          return ExplainScreen(
            title: translate.mathMessage,
          );
        }
        return Scaffold(
          backgroundColor: kColorWhite,
            appBar: CustomAppBar(
              title: "Question ${_currentPlayingIndex + 1}",
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
                            mathScore.toString(),
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
                    TimerWidget(
                      onTimerEnd: () {
                        _showResult();
                      },
                      isSubmit: false,
                      reBuild: false,
                      countTime: 45,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: MathPlayWidget(
                          index: _currentPlayingIndex,
                          question: context
                              .read<AppState>()
                              .playList[_currentPlayingIndex],
                          onPlayCorrect: _onPlayCorrect,
                        ),
                      ),
                    ),
                  ],
                ),
                ScoreOverlay(
                  score: score,
                  bonus: 0,
                  streak: streak,
                )
              ],
            ));
      },
    );
  }
}
