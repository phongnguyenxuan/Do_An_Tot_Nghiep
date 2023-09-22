import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../configs/style_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.toolBarHeight = kToolbarHeight,
    required this.title,
    this.onBackButtonPress,
    this.shouldShowMoreApp = false,
    this.actions = const <Widget>[],
  });
  final double toolBarHeight;
  final String title;
  final bool shouldShowMoreApp;
  final Future<bool> Function()? onBackButtonPress;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      shadowColor: kColorPrimary,

      toolbarHeight: toolBarHeight.h,
      leadingWidth: 70,
      leading: GestureDetector(
        onTap: () async {
          if (await onBackButtonPress?.call() ?? true)
            Navigator.of(context).pop();
        },
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: kColorPrimary,
                shape: BoxShape.circle,
                border: Border.all(color: kColorBlack, width: 2)),
            child: Center(
              child: Icon(
                Icons.arrow_back,
                size: 24.sp,
                color: kColorBlack,
              ),
            ),
          ),
        ),
      ),
      title: Stack(
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                foreground: Paint()
                  ..color = kColorStroke
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp),
          ),
        ],
      ),
      centerTitle: true,
      actions: actions
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight.h);
}
