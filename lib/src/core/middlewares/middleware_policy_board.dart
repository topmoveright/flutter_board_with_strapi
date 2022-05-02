import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/core/pages/page_default.dart';
import 'package:yuonsoft/src/core/routes/route_default.dart';
import 'package:yuonsoft/src/core/services/service_board.dart';

/// 주소창에 boardName 직접입력 연동
class MiddlewarePolicyBoard extends GetMiddleware {
  MiddlewarePolicyBoard({int? priority}) : super(priority: priority);

  final _serviceBoard = Get.find<ServiceBoard>();

  bool _setBoardType() {
    var boardName = '';
    if (Get.parameters.containsKey('boardName')) {
      boardName = Get.parameters['boardName'] ?? '';
    }
    return _serviceBoard.setBoardType(boardName);
  }

  /// boarType 존재 확인
  bool _boardTypeCheck() {
    if (_serviceBoard.boardType == null) {
      return false;
    }
    return true;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    var isFineBoardType = _setBoardType();
    if (isFineBoardType) {
      return page;
    } else {
      return PageDefault.badRequest;
    }
  }

  @override
  redirect(String? route) {
    return !_boardTypeCheck()
        ? const RouteSettings(name: RouteDefault.badRequest)
        : null;
  }

  /*
  /// 라우트 바뀌면 목록 다시 로드
  @override
  Widget onPageBuilt(Widget page) {
    return page;
  }
  */
}
