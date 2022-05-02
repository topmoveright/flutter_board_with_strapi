import 'package:get/get.dart';
import 'package:yuonsoft/src/core/pages/page_board.dart';
import 'package:yuonsoft/src/core/routes/route_default.dart';
import 'package:yuonsoft/src/core/utils/util_http.dart';
import 'package:yuonsoft/src/views/view_home.dart';
import 'package:yuonsoft/src/views/view_login.dart';
import 'package:yuonsoft/src/views/view_template_error.dart';

abstract class PageDefault {
  static final List<GetPage> list = [
    GetPage(
      name: RouteDefault.home,
      page: () => ViewHome(),
    ),
    GetPage(
      name: RouteDefault.login,
      page: () => ViewLogin(),
    ),
    badRequest,
    forbidden,
    notFound,
    unauthorized,
    ...PageBoard.list,
  ];

  static final badRequest = GetPage(
    name: RouteDefault.badRequest,
    page: () => ViewTemplateError(msg: UtilHttp.statusMsg(400)),
  );

  static final unauthorized = GetPage(
    name: RouteDefault.unauthorized,
    page: () => ViewTemplateError(msg: UtilHttp.statusMsg(401)),
  );

  static final forbidden = GetPage(
    name: RouteDefault.forbidden,
    page: () => ViewTemplateError(msg: UtilHttp.statusMsg(403)),
  );

  static final notFound = GetPage(
    name: RouteDefault.notFound,
    page: () => ViewTemplateError(msg: UtilHttp.statusMsg(404)),
  );
}
