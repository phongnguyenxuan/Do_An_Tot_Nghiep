import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hive/hive.dart';

import '../configs/constants.dart';

class TranslatePreferences implements ITranslatePreferences {
   @override
  Future<Locale?> getPreferredLocale() async {
    final  boxAppData = Hive.box(boxAppSettingName);
    if(!boxAppData.containsKey("language")) return null;
    return localeFromString(boxAppData.get("language", defaultValue: null));
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    final  boxAppData = Hive.box(boxAppSettingName);
    boxAppData.put("language", localeToString(locale));
  }
}