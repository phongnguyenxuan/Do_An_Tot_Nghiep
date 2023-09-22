import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../configs/style_config.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_text.dart';

class ExplainScreen extends StatefulWidget {
  const ExplainScreen({super.key});

  @override
  State<ExplainScreen> createState() => _ExplainScreen();
}

class _ExplainScreen extends State<ExplainScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _timeCount = 3;
  late Animation<double> animation;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart);
    animation.addListener(() {
      _animationListener();
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      _controller.forward();
    });
  }

  void _animationListener() {
    if (animation.isCompleted && _timeCount >= 1) {
      setState(() {
        _timeCount--;
      });
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_animationListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: ""),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/explain.png",
              width: 130.w,
              height: 130.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text("findPairMessage",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.sp, color: kColorBlack)),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 60.h,
              child: ScaleTransition(
                  scale: animation,
                  alignment: Alignment.center,
                  child: CustomText(
                      color: Colors.black,
                      strokeWidth: 5,
                      title: _timeCount == 0 ? "" : _timeCount.toString(),
                      fontSize: 40.sp)),
            ),
            CustomText(
              color: kColorOrange,
              fontSize: 27.sp,
              strokeWidth: 3,
              title: _timeCount == 0 ? "Start" : "Get ready !!",
            )
          ],
        ),
      ),
    );
  }
}
