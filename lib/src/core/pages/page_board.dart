import 'package:get/get.dart';
import 'package:yuonsoft/src/controllers/controller_post_create.dart';
import 'package:yuonsoft/src/core/middlewares/middleware_policy_auth.dart';
import 'package:yuonsoft/src/core/middlewares/middleware_policy_board.dart';
import 'package:yuonsoft/src/core/middlewares/middleware_policy_post_update.dart';
import 'package:yuonsoft/src/core/middlewares/milddleware_binding_board.dart';
import 'package:yuonsoft/src/core/middlewares/milddleware_binding_post.dart';
import 'package:yuonsoft/src/core/routes/route_board.dart';
import 'package:yuonsoft/src/views/view_board.dart';
import 'package:yuonsoft/src/views/view_post.dart';
import 'package:yuonsoft/src/views/view_post_create.dart';

abstract class PageBoard {
  static final List<GetPage> list = [
    GetPage(
      name: RouteBoard.board,
      page: () => ViewBoard(),
      middlewares: [
        MiddlewarePolicyBoard(priority: 1),
        MiddlewarePolicyAuth(priority: 2),
        MiddlewareBindingBoard(priority: 3),
      ],
    ),
    GetPage(
      name: RouteBoard.post,
      page: () => ViewPost(),
      middlewares: [
        MiddlewarePolicyBoard(priority: 1),
        MiddlewareBindingPost(priority: 2),
      ],
    ),
    GetPage(
      name: RouteBoard.postCreate,
      page: () => const ViewPostCreate(),
      binding: BindingsBuilder.put(() => ControllerPostCreate()),
      middlewares: [
        MiddlewarePolicyBoard(priority: 1),
      ],
    ),
    GetPage(
      name: RouteBoard.postUpdate,
      page: () => const ViewPostCreate(),
      binding: BindingsBuilder.put(() => ControllerPostCreate()),
      middlewares: [
        MiddlewarePolicyBoard(priority: 1),
        MiddlewarePolicyPostUpdate(priority: 2),
      ],
    ),
  ];
}
