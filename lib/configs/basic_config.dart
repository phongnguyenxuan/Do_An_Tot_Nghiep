import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'constants.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future setupHive() async {
  Directory documents = await getApplicationDocumentsDirectory();
  Hive.init(documents.path);
  await Hive.openBox(boxAppSettingName);
  await Hive.openBox(boxPlayDataName);
}
