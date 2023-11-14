import 'package:do_an_tot_nghiep/provider/user_provider.dart';
import 'package:do_an_tot_nghiep/screens/auth/auth_state_screen.dart';
import 'package:do_an_tot_nghiep/screens/auth/login_screen.dart';
import 'package:do_an_tot_nghiep/screens/games/math_game/math_screen.dart';
import 'package:do_an_tot_nghiep/screens/home/rank_screen.dart';
import 'package:do_an_tot_nghiep/screens/home/setting_screen.dart';
import 'package:do_an_tot_nghiep/screens/result/status_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'configs/basic_config.dart';
import 'configs/style_config.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'provider/app_state.dart';
import 'screens/games/find_pair/find_pair_screen.dart';
import 'screens/games/memory_matrix/memo_matrix_screen.dart';
import 'screens/games/speed_match/speed_match_screen.dart';
import 'screens/home/games_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));
  //setup hive
  await setupHive();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      builder: (context, child) {
        return child!;
      },
      child: const MainApp(),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 3)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.transparent
    ..indicatorColor = kColorPrimary
    ..textColor = Colors.transparent
    ..boxShadow = <BoxShadow>[]
    ..maskColor = Colors.transparent
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.custom
    ..dismissOnTap = false;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return Consumer<AppState>(
            builder: (context, value, child) {
              return MaterialApp(
                builder: EasyLoading.init(),
                debugShowCheckedModeBanner: false,
                navigatorKey: navigatorKey,
                title: 'Test Memory',
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: Locale(value.appLanguage),
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
                  StatusScreen.id: (_) => const StatusScreen(),
                  LoginScreen.id: (_) => const LoginScreen(),
                  AuthState.id: (_) => const AuthState(),
                  SettingScreen.id: (_) => const SettingScreen(),
                  RankScreen.id: (_) => const RankScreen(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
