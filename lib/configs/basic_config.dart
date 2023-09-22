import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../extensions/localication_extensions.dart';
import 'constants.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future setupHive() async {
  Directory documents = await getApplicationDocumentsDirectory();
  Hive.init(documents.path);
  await Hive.openBox(boxAppSettingName);
  await Hive.openBox(boxPlayDataName);
}

Future<LocalizationDelegate> setupAppLanguage() async {
  late final Box boxAppSetting = Hive.box(boxAppSettingName);
  if (boxAppSetting.get(
        "language",
      ) ==
      null) {
    final currentLanguage = (window.locale).toString().split(RegExp('[-_]'))[0];
    if (supportedLanguage.contains(currentLanguage)) {
      boxAppSetting.put("language", currentLanguage);
    } else {
      boxAppSetting.put("language", defaultLanguage);
    }
  }

  return await LocalizationDelegate.create(
      fallbackLocale: defaultLanguage,
      supportedLocales: supportedLanguage,
      preferences: TranslatePreferences(),
      basePath: 'assets/langs/');
}

String getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  String shortestSize = data.size.shortestSide < 600 ? 'phone' : 'tablet';
  return shortestSize;
}
