import 'package:do_an_tot_nghiep/screens/auth/auth_state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      Future.delayed(const Duration(milliseconds: 2500)).then((value) {
        Navigator.of(context).pushReplacementNamed(AuthState.id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a243a),
      body: SafeArea(
        child: AnimatedOpacity(
          opacity: _shouldShowAnimation ? 1 : 0,
          duration: const Duration(milliseconds: 1500),
          curve: Curves.elasticInOut,
          child: AnimatedScale(
            scale: _shouldShowAnimation ? 1 : 0.3,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.elasticInOut,
            child: Center(
              child: Image.asset(
                "assets/images/splash_icon.png",
                width: 200.w,
                height: 200.h,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
