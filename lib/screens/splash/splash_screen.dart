import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:do_an_tot_nghiep/screens/auth/auth_state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../configs/basic_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = "SplashScreen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _shouldShowAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _shouldShowAnimation = true;
      });
      Future.delayed(const Duration(milliseconds: 3000)).then((value) {
        navigatorKey.currentState?.pushReplacementNamed(AuthState.id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent
      ),
      child: Scaffold(
        backgroundColor: kColorWhite,
        body: AnimatedOpacity(
          opacity: _shouldShowAnimation ? 1 : 0,
          duration: const Duration(milliseconds: 2000),
          curve: Curves.bounceInOut,
          child: Center(
            child: Image.asset(
              "assets/images/splash_icon.png",
              width: MediaQuery.of(context).size.width * 0.75,
             // height: 700.h,
            ),
          ),
        ),
      ),
    );
  }
}
