import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:do_an_tot_nghiep/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../configs/style_config.dart';
import '../../widget/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = "login screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 30, right: 25),
              child: CustomButton(
                  onPress: () async {
                    await authServices.anonymouslySigin();
                  },
                  width: 50.w,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  borderRadius: BorderRadius.circular(27),
                  color: kColorPrimary,
                  shadowColor: kShadowColor,
                  elevation: 0,
                  buttonBorder: Border.all(width: 2, color: kColorBlack),
                  child: Text(
                    translate.skip,
                    style: TextStyle(
                        fontFamily: kfontFamily,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: RichText(
              text: TextSpan(
                  text: translate.welcome,
                  style: k45SizeBlackColorStyle,
                  children: [
                    TextSpan(
                        text: "\nMemoImprove", style: k45SizePrimaryColorStyle)
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset(
              "assets/images/happy.png",
              width: 150.w,
              height: 150.h,
            ),
          ),
          //sigin with
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 84.w,
                height: 1,
                color: kColorBlack,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: Text(
                  translate.signInWith,
                  style: TextStyle(
                      color: kColorBlack,
                      fontFamily: kfontFamily,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp),
                ),
              ),
              Container(
                width: 84.w,
                height: 1,
                color: kColorBlack,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          //facebook and google
          Row(
            children: [
              //facebook
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                    onPress: () async {
                      await authServices.logInWithFacebook(context);
                    },
                    color: kColorWhite,
                    buttonBorder: Border.all(width: 2, color: kColorBlack),
                    padding: const EdgeInsets.all(15),
                    borderRadius: BorderRadius.circular(27),
                    child: Row(
                      children: [
                        Container(
                          width: 29.w,
                          height: 29.w,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/icons/facebook.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "FACEBOOK",
                          style: TextStyle(
                              fontFamily: kfontFamily,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )),
              )),
              //google
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                    onPress: () async {
                      await authServices.logInWithGoogle(context);
                    },
                    color: kColorWhite,
                    buttonBorder: Border.all(width: 2, color: kColorBlack),
                    padding: const EdgeInsets.all(15),
                    borderRadius: BorderRadius.circular(27),
                    child: Row(
                      children: [
                        Container(
                          width: 29.w,
                          height: 29.w,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/icons/google.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "GOOGLE",
                          style: TextStyle(
                              fontFamily: kfontFamily,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )),
              )),
            ],
          )
        ],
      ),
    );
  }
}
