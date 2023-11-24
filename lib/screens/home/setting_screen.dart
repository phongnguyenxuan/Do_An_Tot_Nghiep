import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an_tot_nghiep/custom_icon_icons.dart';
import 'package:do_an_tot_nghiep/provider/app_state.dart';
import 'package:do_an_tot_nghiep/services/auth_services.dart';
import 'package:do_an_tot_nghiep/widget/custom_appbar.dart';
import 'package:do_an_tot_nghiep/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../configs/basic_config.dart';
import '../../configs/constants.dart';
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
  Widget build(BuildContext ctx) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.idTokenChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: kColorWhite,
          );
        } else {
          User user = snapshot.data!;
          return Scaffold(
            backgroundColor: kColorWhite,
            appBar: CustomAppBar(
              title: translate.settings,
            ),
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            translate.sound,
                            style: k25SizeBlackColorStyle,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Icon(
                            ctx.read<AppState>().appAudio
                                ? CustomIcon.volume
                                : CustomIcon.volume_slash,
                          ),
                          const Spacer(),
                          FlutterSwitch(
                            activeColor: primaryMaterialColor.shade300,
                            activeToggleColor: kColorPrimary,
                            switchBorder:
                                Border.all(width: 2, color: kBorderColor),
                            value: ctx.read<AppState>().appAudio,
                            onToggle: (value) {
                              setState(() {
                                ctx.read<AppState>().appAudio = value;
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
                              translate.language,
                              style: k25SizeBlackColorStyle,
                            ),
                            const Spacer(),
                            DropdownButton<String>(
                              value: ctx.read<AppState>().appLanguage,
                              underline: Container(),
                              borderRadius: BorderRadius.circular(15),
                              elevation: 2,
                              items: supportedLanguage
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7),
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
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  ctx.read<AppState>().appLanguage = value!;
                                });
                              },
                            ),
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
                            translate.contact,
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
                            translate.termAndPr,
                            style: k17SizeW500BlackColorStyle,
                          )),
                    ],
                  ),
                )
              ],
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
        Image.asset(
          "assets/images/anonymous.png",
          fit: BoxFit.cover,
          width: 80.w,
          height: 80.w,
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
                              translate.signInWith,
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
                                            navigatorKey.currentState
                                                ?.pop(true);
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
                                            navigatorKey.currentState
                                                ?.pop(true);
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
                  translate.logIn,
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
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: kBorderColor),
          ),
          child: CircleAvatar(
            radius: 35,
            child: ClipOval(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CachedNetworkImage(
                  imageUrl: user.photoURL!,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
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
                  context.read<AppState>().totalScore = 0;
                  await authServices
                      .signOut()
                      .then((value) => navigatorKey.currentState?.pop());
                },
                borderRadius: BorderRadius.circular(15),
                buttonBorder: Border.all(width: 2, color: kColorBlack),
                color: kColorPrimary,
                shadowColor: kShadowColor,
                elevation: 5,
                padding: const EdgeInsets.all(8),
                child: Text(
                  translate.logOut,
                  style: knormalTextStyle,
                ))
          ],
        )
      ],
    );
  }
}
