
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/app.dart';
import 'package:yuonsoft/src/core/services/service_auth.dart';
import 'package:yuonsoft/src/core/services/service_board.dart';
import 'package:yuonsoft/src/core/services/service_setting.dart';
import 'package:yuonsoft/src/settings/settings_controller.dart';
import 'package:yuonsoft/src/settings/settings_service.dart';


void main() async {
  Future<void> initServices() async {
    Get.lazyPut(() => ServiceAuth());
    await Get.putAsync(() => ServiceBoard().init());
    await Get.putAsync(() => ServiceSetting().init());
  }
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  await initServices();
  runApp(MyApp(settingsController: settingsController));
}
