import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:do_an_tot_nghiep/widget/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../configs/style_config.dart';
import '../widget/custom_button.dart';

Future<bool?> showContactDialog(BuildContext context) async {
  return showDialog<bool?>(
      barrierDismissible: true,
      context: context,
      builder: (_) => const ContactDialog());
}

class ContactDialog extends StatelessWidget {
  const ContactDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: kColorLightPrimary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(width: 2, color: kBorderColor)),
        title: Center(
          child: Text(
            translate.contact_,
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
                      onPress: () async {
                        final Uri url =
                            Uri.parse("https://www.facebook.com/Anhphongggg");
                        final bool nativeAppLaunchSucceeded = await launchUrl(
                          url,
                          mode: LaunchMode.externalNonBrowserApplication,
                        );
                        if (nativeAppLaunchSucceeded) {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        } else {
                          showError(translate.error, "Something went wrong !!");
                        }
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
                        final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'nxphong2210@gmail.com',
                            queryParameters: {'subject': 'Memo_Improve'});
                        final bool nativeAppLaunchSucceeded = await launchUrl(
                          emailLaunchUri,
                          mode: LaunchMode.externalNonBrowserApplication,
                        );
                        if (nativeAppLaunchSucceeded) {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        } else {
                          showError(translate.error, "Something went wrong !!");
                        }
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
                            image: AssetImage("assets/icons/gmail.png"),
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
