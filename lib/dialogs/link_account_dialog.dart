import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:do_an_tot_nghiep/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/custom_button.dart';

class LinkAccountDialog extends StatefulWidget {
  const LinkAccountDialog({super.key, required this.authServices, required this.mainKey});
  final AuthServices authServices;
  final GlobalKey mainKey;

  @override
  State<LinkAccountDialog> createState() => _LinkAccountDialogState();
}

class _LinkAccountDialogState extends State<LinkAccountDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: kColorLightPrimary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(width: 2, color: kBorderColor)),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                      color: kColorWhite,
                      buttonBorder: Border.all(width: 2, color: kColorBlack),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      borderRadius: BorderRadius.circular(27),
                      child: Container(
                        width: 29.w,
                        height: 29.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/facebook.png"),
                          ),
                        ),
                      )),
                ),
                //google
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                      onPress: () async {
                        await widget.authServices.linkAccount(true, context);
                      },
                      color: kColorWhite,
                      buttonBorder: Border.all(width: 2, color: kColorBlack),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      borderRadius: BorderRadius.circular(27),
                      child: Container(
                        width: 29.w,
                        height: 29.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/google.png"),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ],
        ));
  }
}
