import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:do_an_tot_nghiep/screens/games/math_game/math_screen.dart';
import 'package:do_an_tot_nghiep/screens/games/speed_match/speed_match_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../configs/basic_config.dart';
import '../../configs/style_config.dart';
import '../../provider/app_state.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_button.dart';
import '../games/find_pair/find_pair_screen.dart';
import '../games/memory_matrix/memo_matrix_screen.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});
  static const String id = "GamesScreen";

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: CustomAppBar(title: translate.games),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: CustomButton(
                    elevation: 5,
                    color: Colors.white,
                    shadowColor: kShadowColor2,
                    buttonBorder: Border.all(color: kColorBlack, width: 2),
                    borderRadius: BorderRadius.circular(16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 19, horizontal: 10),
                    onPress: () {
                      navigatorKey.currentState?.pushNamed(MemoMatrixScreen.id);
                      context.read<AppState>().clearMemoState();
                      context.read<AppState>().generateBlock();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            "assets/images/memo_matrix.png",
                            width: 55.w,
                            height: 55.h,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          "Memory Matrix",
                          style: k16BlackTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Flexible(
                  child: CustomButton(
                    elevation: 5,
                    color: Colors.white,
                    shadowColor: kShadowColor2,
                    buttonBorder: Border.all(color: kColorBlack, width: 2),
                    borderRadius: BorderRadius.circular(16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 19, horizontal: 10),
                    onPress: () {
                      navigatorKey.currentState?.pushNamed(FindPairScreen.id);
                      context.read<AppState>().clearPlayState();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            "assets/images/find_pair.png",
                            width: 55.w,
                            height: 55.h,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          "Find Pair",
                          style: k16BlackTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Flexible(
                  child: CustomButton(
                    elevation: 5,
                    color: Colors.white,
                    shadowColor: kShadowColor2,
                    buttonBorder: Border.all(color: kColorBlack, width: 2),
                    borderRadius: BorderRadius.circular(16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 19, horizontal: 10),
                    onPress: () {
                      context.read<AppState>().generatePlayData();
                      navigatorKey.currentState?.pushNamed(MathScreen.id);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            "assets/images/math.png",
                            width: 55.w,
                            height: 55.h,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          "Math",
                          style: k16BlackTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Flexible(
                  child: CustomButton(
                    elevation: 5,
                    color: Colors.white,
                    shadowColor: kShadowColor2,
                    buttonBorder: Border.all(color: kColorBlack, width: 2),
                    borderRadius: BorderRadius.circular(16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 19, horizontal: 10),
                    onPress: () {
                      context.read<AppState>().resetSpeedMatchState();
                      navigatorKey.currentState
                          ?.pushNamed(SpeedMatchScreen.id);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            "assets/images/shapes.png",
                            width: 55.w,
                            height: 55.h,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          "Speed Match",
                          style: k16BlackTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
