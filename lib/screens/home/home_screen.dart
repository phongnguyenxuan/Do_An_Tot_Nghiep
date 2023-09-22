import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../configs/style_config.dart';
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
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/bg.png",
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        body: SafeArea(
            bottom: false,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
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
                              child: Image.asset(
                                "assets/images/gear.png"
                              ),
                            )
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
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
                              child: Image.asset(
                                "assets/images/en.png",
                                width: 36.w,
                                height: 36.h,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container();
                                },
                              ),
                            ),
                          ),
                        )
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
                          fontSize: 30.sp,
                          strokeWidth: 3,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomButton(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          buttonBorder:
                              Border.all(color: kColorBlack, width: 2),
                          shadowColor: kShadowColor2,
                          color: Colors.white,
                          width: 250.w,
                          height: 60.h,
                          onPress: () {
                            Navigator.pushNamed(context, GamesScreen.id);
                          },
                          child: Text(
                            "Play",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CustomButton(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            buttonBorder:
                                Border.all(color: kColorBlack, width: 2),
                            shadowColor: kShadowColor2,
                            color: Colors.white,
                            width: 250.w,
                            height: 60.h,
                            onPress: () {},
                            child: Text(
                              "Status",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        CustomButton(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          buttonBorder:
                              Border.all(color: kColorBlack, width: 2),
                          shadowColor: kShadowColor2,
                          color: Colors.white,
                          width: 250.w,
                          height: 60.h,
                          onPress: () {},
                          child: Text(
                            "Rank",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CustomButton(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            buttonBorder:
                                Border.all(color: kColorBlack, width: 2),
                            shadowColor: kShadowRed,
                            color: kColorRed,
                            width: 250.w,
                            height: 60.h,
                            onPress: () {},
                            child: Text(
                              "Quit",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
