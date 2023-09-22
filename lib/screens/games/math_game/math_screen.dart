import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../configs/style_config.dart';
import '../../../widget/custom_appbar.dart';
import '../explain_screen.dart';

class MathScreen extends StatefulWidget {
  const MathScreen({super.key});
  static const String id = "Math Screen";

  @override
  State<MathScreen> createState() => _MathScreenState();
}

class _MathScreenState extends State<MathScreen> {

  int _currentIndex = -1;
  void delay() {
    Future.delayed(const Duration(milliseconds: 4300), () {
      setState(() {
        _currentIndex = 1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      delay();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/bg.png",
                  ),
                  fit: BoxFit.cover),
            ),
            child: Builder(
              builder: (context) {
                if (_currentIndex == -1) return const ExplainScreen();
                return Scaffold(
                  appBar: CustomAppBar(
                    title: "",
                    actions: [
                      Visibility(
                        visible: _currentIndex != -1,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/star.png",
                                  height: 30.w,
                                  width: 30.h,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  "",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kColorBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  body: Container(
                    color: Colors.blue,
                  )
                );
              },
            ),
          )
    );
  }
}