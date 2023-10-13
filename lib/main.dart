import 'package:do_an_tot_nghiep/screens/games/math_game/math_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'configs/basic_config.dart';
import 'configs/style_config.dart';
import 'provider/app_state.dart';
import 'screens/games/find_pair/find_pair_screen.dart';
import 'screens/games/memory_matrix/memo_matrix_screen.dart';
import 'screens/games/speed_match/speed_match_screen.dart';
import 'screens/home/games_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //setup hive
  await setupHive();
  //setup multi language
  // final delegate = await setupAppLanguage();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      builder: (context, child) {
        return child!;
      },
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //var localizationDelegate = LocalizedApp.of(context).delegate;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      // ScreenUtilInit init responsive for app
      child: ScreenUtilInit(
        //default sized for app is iphone 13
        designSize: const Size(375, 812),
        minTextAdapt: getDeviceType() == 'phone'
            ? false
            : true, // if phone, will not use min text so it will not be so small on device
        builder: (context, child) {
          return GlobalLoaderOverlay(
            closeOnBackButton: false,
            overlayWidget: const Center(
              child: CircularProgressIndicator(),
            ),
            overlayColor: Colors.white24,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              title: 'Test Memory',
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: ThemeData(
                primarySwatch: primaryMaterialColor,
                scaffoldBackgroundColor: Colors.transparent,
              ),
              initialRoute: SplashScreen.id,
              routes: {
                HomeScreen.id: (_) => const HomeScreen(),
                SplashScreen.id: (_) => const SplashScreen(),
                GamesScreen.id: (_) => const GamesScreen(),
                MemoMatrixScreen.id: (_) => const MemoMatrixScreen(),
                FindPairScreen.id: (_) => const FindPairScreen(),
                MathScreen.id: (_) => const MathScreen(),
                SpeedMatchScreen.id: (_) => const SpeedMatchScreen(),
              },
            ),
          );
        },
      ),
    );
  }
}
