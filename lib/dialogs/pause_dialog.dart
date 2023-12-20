import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:do_an_tot_nghiep/provider/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../widget/custom_button.dart';

Future<bool?> showPauseDialog(BuildContext context,
    {String title = "title",
    String cancelTitle = "cancel",
    String confirmTitle = "ok"}) async {
  context.read<AppState>().onPause();
  return showDialog<bool?>(
      barrierDismissible: false,
      context: context,
      builder: (_) => const PauseDialog());
}

class PauseDialog extends StatelessWidget {
  const PauseDialog({
    super.key,
  });
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
                      onPress: () {
                        Navigator.of(context).pop(false);
                        context.read<AppState>().onResume();
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
                        Navigator.of(context).pop(true);
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
