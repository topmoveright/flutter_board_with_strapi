import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/controllers/controller_post.dart';

class MiddlewareBindingPost extends GetMiddleware {
  MiddlewareBindingPost({required int priority}) : super(priority: priority);

  @override
  RouteSettings? redirect(String? route) {
    // ∴ uniqueKey 값을 가지는 parameter 확인 후 없으면 생성 후 redirect
    var uri = Uri.parse(route ?? '');
    return uri.queryParameters.containsKey('tag')
        ? null
        : RouteSettings(name: '${uri.path}?${uri.query}&tag=${UniqueKey()}');
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    // 컨트롤러 바인딩(중복생성, tag 로 식별)
    bindings?.add(BindingsBuilder.put(() => ControllerPost(), tag: '_${Get.currentRoute}'));
    return bindings;
  }
}
