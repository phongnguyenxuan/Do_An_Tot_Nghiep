import 'package:do_an_tot_nghiep/custom_icon_icons.dart';
import 'package:do_an_tot_nghiep/services/auth_services.dart';
import 'package:do_an_tot_nghiep/widget/custom_appbar.dart';
import 'package:do_an_tot_nghiep/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../configs/style_config.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  static const String id = "setting screen";
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool enableSound = true;
  final AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.idTokenChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          User user = snapshot.data!;
          return Container(
            decoration: const BoxDecoration(
              color: kColorWhite,
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/bg.png",
                  ),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              appBar: const CustomAppBar(title: "Settings"),
              body: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  user.isAnonymous
                      ? secondHeader(context, user)
                      : mainHeader(user, context),
                  Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    color: kBorderColor,
                  ),
                  // feature
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        //sound
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Sound",
                              style: k25SizeBlackColorStyle,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Icon(
                              enableSound
                                  ? CustomIcon.volume
                                  : CustomIcon.volume_slash,
                            ),
                            const Spacer(),
                            FlutterSwitch(
                              activeColor: primaryMaterialColor.shade300,
                              activeToggleColor: kColorPrimary,
                              switchBorder:
                                  Border.all(width: 2, color: kBorderColor),
                              value: enableSound,
                              onToggle: (value) {
                                setState(() {
                                  enableSound = value;
                                });
                              },
                            )
                          ],
                        ),
                        // language
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Language",
                                style: k25SizeBlackColorStyle,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        // contactus
                        CustomButton(
                            borderRadius: BorderRadius.circular(20),
                            color: kButtonColor,
                            shadowColor: kShadowColor2,
                            buttonBorder:
                                Border.all(width: 2, color: kColorBlack),
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Contact us",
                              style: k17SizeW500BlackColorStyle,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        //Terms and privacy
                        CustomButton(
                            borderRadius: BorderRadius.circular(20),
                            color: kButtonColor,
                            shadowColor: kShadowColor2,
                            buttonBorder:
                                Border.all(width: 2, color: kColorBlack),
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Terms and privacy",
                              style: k17SizeW500BlackColorStyle,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Row secondHeader(BuildContext context, User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 25.w,
        ),
        //avatar
        Container(
          width: 80.w,
          height: 80.w,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: kColorPrimary,
              border: Border.all(width: 2, color: kBorderColor),
              shape: BoxShape.circle,
              image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/anonymous.png",
                  ),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          width: 15.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Anonymous\n",
              style: k17SizeW500BlackColorStyle,
            ),
            //logout
            CustomButton(
                onPress: () async {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                          backgroundColor: kColorLightPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                  width: 2, color: kBorderColor)),
                          title: Center(
                            child: Text(
                              "Sign in with",
                              style: k17SizeW500BlackColorStyle,
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //facebook
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: CustomButton(
                                        onPress: () async {
                                          await authServices
                                              .linkAccount(false, context)
                                              .then((value) {
                                            Navigator.of(context).pop(true);
                                          });
                                        },
                                        color: kColorWhite,
                                        buttonBorder: Border.all(
                                            width: 2, color: kColorBlack),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        borderRadius: BorderRadius.circular(27),
                                        child: Container(
                                          width: 29.w,
                                          height: 29.w,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/icons/facebook.png"),
                                            ),
                                          ),
                                        )),
                                  ),
                                  //google
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: CustomButton(
                                        onPress: () async {
                                          await authServices
                                              .linkAccount(true, context)
                                              .then((value) {
                                            Navigator.of(context).pop(true);
                                          });
                                        },
                                        color: kColorWhite,
                                        buttonBorder: Border.all(
                                            width: 2, color: kColorBlack),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        borderRadius: BorderRadius.circular(27),
                                        child: Container(
                                          width: 29.w,
                                          height: 29.w,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/icons/google.png"),
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ));
                    },
                  );
                },
                borderRadius: BorderRadius.circular(15),
                buttonBorder: Border.all(width: 2, color: kColorBlack),
                color: kColorPrimary,
                shadowColor: kShadowColor,
                elevation: 5,
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Log in",
                  style: knormalTextStyle,
                ))
          ],
        )
      ],
    );
  }

  Row mainHeader(User user, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 25.w,
        ),
        //avatar
        Container(
          width: 80.w,
          height: 80.w,
          //  padding: const EdgeInsets.all(100),
          decoration: BoxDecoration(
              color: kColorPrimary,
              border: Border.all(width: 2, color: kBorderColor),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                    user.photoURL!,
                  ),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          width: 15.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: "${user.displayName}\n",
                    style: k17SizeW500BlackColorStyle,
                    children: [
                  TextSpan(
                      text: "${user.email}", style: k13SizeW200BlackColorStyle)
                ])),
            const SizedBox(
              height: 5,
            ),
            //logout
            CustomButton(
                onPress: () async {
                  await authServices
                      .signOut()
                      .then((value) => Navigator.of(context).pop());
                },
                borderRadius: BorderRadius.circular(15),
                buttonBorder: Border.all(width: 2, color: kColorBlack),
                color: kColorPrimary,
                shadowColor: kShadowColor,
                elevation: 5,
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Log out",
                  style: knormalTextStyle,
                ))
          ],
        )
      ],
    );
  }
}
