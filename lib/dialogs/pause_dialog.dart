import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/custom_button.dart';

class PauseDialog extends StatefulWidget {
  const PauseDialog({super.key,});
  @override
  State<PauseDialog> createState() => _PauseDialogState();
}

class _PauseDialogState extends State<PauseDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: kColorLightPrimary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(width: 2, color: kBorderColor)),
        title: Center(
          child: Text(
            "Pause",
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
                            image: AssetImage("assets/icons/resume.png"),
                          ),
                        ),
                      )),
                ),
                //google
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                      onPress: () async {
                        
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
                            image: AssetImage("assets/icons/home.png"),
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
