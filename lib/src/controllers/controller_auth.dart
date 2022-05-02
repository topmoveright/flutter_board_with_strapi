import 'dart:async';

import 'package:get/get.dart';
import 'package:yuonsoft/src/core/routes/route_default.dart';
import 'package:yuonsoft/src/core/services/service_auth.dart';
import 'package:yuonsoft/src/models/model_user.dart';

class ControllerAuth extends GetxController {
  final _serviceAuth = Get.find<ServiceAuth>();

  ModelUser? get user => _serviceAuth.user;

  bool get isLoggedIn => user != null;

  Future<void> goSignIn() async {
    if (!isLoggedIn) {
      Get.toNamed(RouteDefault.login);
    }
  }

  Future<void> signIn(String email, String password) async {
    if (!isLoggedIn) {
      await _serviceAuth.login(email, password);
      if (isLoggedIn) {
        Get.offAllNamed(RouteDefault.home);
      }
    }
  }

  void signOut() {
    if (isLoggedIn) {
      _serviceAuth.logout();
      Get.offAllNamed(RouteDefault.home);
    }
  }
}
