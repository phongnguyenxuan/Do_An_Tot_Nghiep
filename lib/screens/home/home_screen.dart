import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:do_an_tot_nghiep/screens/home/rank_screen.dart';
import 'package:do_an_tot_nghiep/screens/home/setting_screen.dart';
import 'package:do_an_tot_nghiep/screens/result/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../configs/basic_config.dart';
import '../../configs/style_config.dart';
import '../../provider/app_state.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import 'games_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Selector<AppState, String>(
      selector: (ctx, state) => state.appLanguage,
      builder: (context, language, child) {
        return body(language);
      },
    );
  }

  Scaffold body(String language) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //setting
                  GestureDetector(
                    onTap: () {
                      context.read<AppState>().playSound(clickSound);
                          navigatorKey.currentState
                              ?.pushNamed(SettingScreen.id);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: kColorBlack, width: 2),
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        width: 44.w,
                        height: 44.h,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset("assets/images/gear.png"),
                        )),
                  ),
                  DropdownButton<String>(
                    value: language,
                    underline: Container(),
                    borderRadius: BorderRadius.circular(15),
                    elevation: 2,
                    items: supportedLanguage
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: 70.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                child: Text(value.toUpperCase()),
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/$value.png"))),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        context.read<AppState>().appLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            //Logo
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: 120.w,
                      height: 120.h,
                    ),
                  ),
                  CustomText(
                    title: "Memo Improve",
                    fontSize: 25.sp,
                    strokeWidth: 3,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    buttonBorder: Border.all(color: kColorBlack, width: 2),
                    shadowColor: kShadowColor2,
                    color: Colors.white,
                    width: 250.w,
                    height: 60.h,
                    onPress: () {
                      navigatorKey.currentState?.pushNamed(GamesScreen.id);
                    },
                    child: Text(translate.play, style: k18BlackTextStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomButton(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      buttonBorder: Border.all(color: kColorBlack, width: 2),
                      shadowColor: kShadowColor2,
                      color: Colors.white,
                      width: 250.w,
                      height: 60.h,
                      onPress: () {
                        navigatorKey.currentState?.pushNamed(StatusScreen.id);
                      },
                      child: Text(translate.history, style: k18BlackTextStyle),
                    ),
                  ),
                  CustomButton(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    buttonBorder: Border.all(color: kColorBlack, width: 2),
                    shadowColor: kShadowColor2,
                    color: Colors.white,
                    width: 250.w,
                    height: 60.h,
                    onPress: () {
                      navigatorKey.currentState?.pushNamed(RankScreen.id);
                    },
                    child: Text(translate.rank, style: k18BlackTextStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomButton(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      buttonBorder: Border.all(color: kColorBlack, width: 2),
                      shadowColor: kShadowRed,
                      color: kColorRed,
                      width: 250.w,
                      height: 60.h,
                      onPress: () {
                        SystemNavigator.pop();
                      },
                      child: Text(
                        translate.quit,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: kfontFamily,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
