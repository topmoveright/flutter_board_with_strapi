import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/core/pages/page_default.dart';
import 'package:yuonsoft/src/core/routes/route_default.dart';
import 'package:yuonsoft/src/core/services/service_board.dart';
import 'package:yuonsoft/src/models/model_board_list_item.dart';

/// 주소창에 boardName 직접입력 연동
class MiddlewarePolicyPostUpdate extends GetMiddleware {
  MiddlewarePolicyPostUpdate({int? priority}) : super(priority: priority);

  /// GETX 에서 라우트 이동전까지 Get.arguments 유지됨 (GOING TO ROUTE /post-update/inquiry)
  /// ∵ redirect, onPageCalled 에서 이전 arguments 불러옴
  /// ∴ onPageBuilt 에서 필수값 확인 isOwner, post
  @override
  Widget onPageBuilt(Widget page) {
    if (!(Get.arguments?['isOwner'] ?? false) || Get.arguments?['post'] == null) {
      return PageDefault.badRequest.page();
    }
    return page;
  }
}
