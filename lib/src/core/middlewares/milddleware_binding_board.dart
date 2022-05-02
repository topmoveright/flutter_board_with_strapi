import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/controllers/controller_board.dart';

class MiddlewareBindingBoard extends GetMiddleware {
  MiddlewareBindingBoard({required int priority}) : super(priority: priority);

  @override
  RouteSettings? redirect(String? route) {
    // ! Get.currentRoute 값으로 controller 중복 생성을 위한 tag 로 사용 (중복생성:init 이 안되면 최신데이터 fetch 안됨)
    // 동일 페이지 호출시 tag 도 동일하기때문에 해당 controller 삭제(페이지 닫기, 뒤로가기) 전까지 생성안됨

    // ∵ Get.to(testPage(tag), binding...put(testController(), tag: tag) 와 같이 직접 라우트 호출 하는 경우가 아니면
    // naming route 에선 tag 공유가 복잡하고 지저분해짐
    // ( 22.01.25 기분 깔끔하게 공유 방법 없음.. 별도 tag 전용 controller 생성 유일)

    // ∴ uniqueKey 값을 가지는 parameter 확인 후 없으면 생성 후 redirect

    var uri = Uri.parse(route ?? '');
    return uri.queryParameters.containsKey('tag')
        ? null
        : RouteSettings(name: '${uri.path}?${uri.query}&tag=${UniqueKey()}');
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    // 컨트롤러 바인딩(중복생성, tag 로 식별)
    bindings?.add(BindingsBuilder.put(() => ControllerBoard(),
        tag: '_${Get.currentRoute}'));
    return bindings;
  }
}
