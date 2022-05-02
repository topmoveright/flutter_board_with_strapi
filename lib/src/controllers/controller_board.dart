import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/core/extensions/extension_string.dart';
import 'package:yuonsoft/src/core/routes/route_board.dart';
import 'package:yuonsoft/src/core/services/service_auth.dart';
import 'package:yuonsoft/src/core/services/service_board.dart';
import 'package:yuonsoft/src/core/utils/util_dialog.dart';
import 'package:yuonsoft/src/models/model_board_list.dart';
import 'package:yuonsoft/src/models/model_board_list_item.dart';
import 'package:yuonsoft/src/models/model_board_post.dart';

const int pageSetSize = 5;

class ControllerBoard extends GetxController with StateMixin<ModelBoardList> {
  int _pageSize = 10;

  int get pageSize => _pageSize;

  void setPageSize(int pageSize) => _pageSize = pageSize;

  // -----------------------------------------------------------
  final ServiceAuth _serviceAuth = Get.find<ServiceAuth>();

  String? get _userToken => _serviceAuth.user?.token;
  final ServiceBoard _serviceBoard = Get.find<ServiceBoard>();

  _init() async {
    try {
      change(null, status: RxStatus.loading());
      var page = (Get.parameters.containsKey('page')
              ? Get.parameters['page'] as String
              : '1')
          .sanitizePositiveInt;
      ModelBoardList? list;
      if (_serviceBoard.isGuestBoard) {
        list = await _serviceBoard.list(page: page, pageSize: pageSize);
      } else {
        list = await _serviceBoard.list(
            page: page, pageSize: _pageSize, token: _userToken);
      }

      if (list == null) {
        change(null, status: RxStatus.error('오류가 발생하였습니다.'));
      } else {
        if (list.list.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(list, status: RxStatus.success());
        }
      }
    } catch (e) {
      change(null, status: RxStatus.error('오류가 발생하였습니다.'));
    }
  }

  void goBoard(int page, [String? boardName]) async {
    var _boardName = boardName ?? _serviceBoard.boardType!.name;
    Get.toNamed('/board/$_boardName?page=$page&tag=${UniqueKey()}');
  }

  void goPost(ModelBoardListItem listItem) async {
    Map<String, dynamic> arguments = {'listItem': listItem};

    if (_serviceBoard.isGuestPrivate(listItem)) {
      var password = await UtilDialog.getPassword();
      if (password == null) {
        return;
      }
      arguments['password'] = password;
    }

    Get.toNamed(
      '/board/${_serviceBoard.boardType!.name}/${listItem.id}?tag=${UniqueKey()}',
      arguments: arguments,
    );
  }

  void goPostCreate({String? boardName}) {
    var _boardName = boardName ?? _serviceBoard.boardType!.name;
    Get.toNamed('/post-create/$_boardName');
  }

  @override
  void onInit() {
    _init();
    super.onInit();
  }
}
