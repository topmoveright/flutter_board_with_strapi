import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/core/bindings/binding_default.dart';
import 'package:yuonsoft/src/core/pages/page_default.dart';
import 'package:yuonsoft/src/core/routes/route_default.dart';

import 'settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          unknownRoute: PageDefault.notFound,
          initialRoute: RouteDefault.home,
          getPages: PageDefault.list,
          initialBinding: BindingDefault(),
          defaultTransition: Transition.noTransition,
        );
      },
    );
  }
}
