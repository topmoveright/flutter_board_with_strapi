import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/core/routes/route_default.dart';
import 'package:yuonsoft/src/core/services/service_auth.dart';
import 'package:yuonsoft/src/core/services/service_board.dart';
import 'package:yuonsoft/src/models/model_board_type.dart';

class MiddlewarePolicyAuth extends GetMiddleware {
  MiddlewarePolicyAuth({int? priority}) : super(priority: priority);

  final _serviceAuth = Get.find<ServiceAuth>();
  final _serviceBoard = Get.find<ServiceBoard>();

  /// board 인증(authentication) 확인
  bool _authCheck() {
    if (_serviceBoard.boardType!.authentication == BoardAuth.user &&
        _serviceAuth.user == null) {
      return false;
    }
    return true;
  }

  // board 접근 권한 확인 후 redirect
  @override
  redirect(String? route) {
    return !_authCheck()
        ? const RouteSettings(name: RouteDefault.unauthorized)
        : null;
  }
}
