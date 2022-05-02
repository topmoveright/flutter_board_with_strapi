import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceSetting extends GetxService {
  Future<ServiceSetting> init() async {
    debugPrint('$runtimeType delays 1 sec');
    await 1.delay();
    debugPrint('$runtimeType ready!');
    return this;
  }
}