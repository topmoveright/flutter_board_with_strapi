import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/core/services/service_auth.dart';
import 'package:yuonsoft/src/core/services/service_board.dart';
import 'package:yuonsoft/src/core/utils/util_dialog.dart';
import 'package:yuonsoft/src/core/utils/util_http.dart';
import 'package:yuonsoft/src/models/model_board_attachment.dart';
import 'package:yuonsoft/src/models/model_board_post.dart';

class ControllerPostCreate extends GetxController {
  final ServiceBoard _serviceBoard = Get.find<ServiceBoard>();
  final ServiceAuth _serviceAuth = Get.find<ServiceAuth>();

  String? get _userToken => _serviceAuth.user?.token;

  bool get isGuestBoard => _serviceBoard.isGuestBoard;

  int get boardAttachmentSize => _serviceBoard.boardType!.attachmentSize;

  final bool? isOwner = Get.arguments?['isOwner'] as bool?;
  final ModelBoardPost? post = Get.arguments?['post'] as ModelBoardPost?;

  bool get isUpdate => isOwner == true && post != null;

  final formKey = GlobalKey<FormState>();
  bool private = false;
  final tecPassword = TextEditingController();
  final tecSubject = TextEditingController();
  final tecName = TextEditingController();
  final tecPhone = TextEditingController();
  final tecEmail = TextEditingController();
  final tecContent = TextEditingController();

  late List<PlatformFile?> files;
  late int tempBoardAttachmentSize = boardAttachmentSize;
  List<ModelBoardAttachment?> tempAttachments = [];

  // TODO : 변수 이름 정리 (attachments..)

  _init() {
    if (isUpdate) {
      private = post!.private;
      tecSubject.text = post!.subject;
      tecName.text = post!.name;
      tecPhone.text = post!.phone ?? '';
      tecEmail.text = post!.email ?? '';
      tecContent.text = post!.content;
      tempAttachments = [...post!.attachments ?? []];
    }
    _setAttachments();
  }

  _dispose() {
    tecPassword.dispose();
    tecSubject.dispose();
    tecName.dispose();
    tecPhone.dispose();
    tecEmail.dispose();
    tecContent.dispose();
  }

  _setAttachments() {
    tempBoardAttachmentSize = boardAttachmentSize - tempAttachments.length;
    files = List.generate(tempBoardAttachmentSize, (index) => null);
  }

  removeTempAttachment(ModelBoardAttachment file) {
    tempAttachments.removeWhere((e) => e?.id == file.id);
    _setAttachments();
    update();
  }

  Future<void> actCreate() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    var body = {
      'private': private.toString(),
      'password': tecPassword.text,
      'subject': tecSubject.text,
      'content': tecContent.text,
      'name': tecName.text,
      'phone': tecPhone.text,
      'email': tecEmail.text,
      'board_type': _serviceBoard.boardType?.id.toString() ?? '',
    };
    if (isUpdate) {
      body['tempAttachments'] =
          jsonEncode(tempAttachments.map((e) => e!.id).toList());
    }

    var result = await _serviceBoard.create(
      body,
      files,
      _userToken,
      isUpdate,
      post?.id,
    );
    if (result.statusCode == 200) {
      Get.offAndToNamed('/board/${_serviceBoard.boardType!.name}');
    } else {
      UtilDialog.snackBar(message: UtilHttp.statusMsg(result.statusCode));
    }
  }

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  @override
  void onClose() {
    _dispose();
    super.onClose();
  }
}
