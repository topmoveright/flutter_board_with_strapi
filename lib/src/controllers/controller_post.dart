import 'package:get/get.dart';
import 'package:yuonsoft/src/core/extensions/extension_string.dart';
import 'package:yuonsoft/src/core/services/service_auth.dart';
import 'package:yuonsoft/src/core/services/service_board.dart';
import 'package:yuonsoft/src/core/utils/util_dialog.dart';
import 'package:yuonsoft/src/core/utils/util_http.dart';
import 'package:yuonsoft/src/models/model_board_list_item.dart';
import 'package:yuonsoft/src/models/model_board_post.dart';
import 'package:yuonsoft/src/models/model_http_result.dart';

class ControllerPost extends GetxController with StateMixin<ModelBoardPost> {
  final ServiceBoard _serviceBoard = Get.find<ServiceBoard>();
  final ServiceAuth _serviceAuth = Get.find<ServiceAuth>();

  late final Map? _arguments = Get.arguments as Map?;
  late final ModelBoardListItem? _listItem = _arguments?['listItem'];
  late final int _id = (Get.parameters['id'] ?? '').sanitizePositiveInt;
  late final ModelBoardPost _post;
  late final bool _isGuestPrivate = _serviceBoard.isGuestPrivate(_listItem);

  String? get _userToken => _serviceAuth.user?.token;

  Future<ModelHttpResult> _fetchPost({
    required bool needPassword,
    required String? password,
    required String? userToken,
  }) async {
    var _result = ModelHttpResult(400, null);
    if (needPassword) {
      _result = password == null
          ? ModelHttpResult(401, null)
          : await _serviceBoard.findOneByPassword(_id, password);
    } else {
      _result = await _serviceBoard.findOne(_id, userToken);
    }
    return _result;
  }

  _init() async {
    try {
      change(null, status: RxStatus.loading());

      // 서버 요청
      var _password = _arguments?['password'];
      var _result = await _fetchPost(
          needPassword: _isGuestPrivate,
          password: _password,
          userToken: _userToken);

      // 결과 처리
      if (_result.statusCode == 200) {
        _post = ModelBoardPost.fromJson(
            _result.value!['data'] as Map<String, Object?>);
        change(_post, status: RxStatus.success());
      } else {
        change(
          null,
          status: RxStatus.error(UtilHttp.statusMsg(_result.statusCode)),
        );
      }
    } catch (e) {
      change(null, status: RxStatus.error('오류가 발생하였습니다.'));
    }
  }

  Future<bool> _checkAuth() async {
    String? _password;

    // 본인인증 미완료시
    if (!_post.isOwner) {
      if (_serviceBoard.isGuestBoard) {
        _password = await UtilDialog.getPassword();
        if (_password == null) {
          return false;
        }
      }
      var result = await _fetchPost(
        needPassword: _serviceBoard.isGuestBoard,
        password: _password,
        userToken: _userToken,
      );

      var _post = ModelBoardPost.fromJson(
          result.value!['data'] as Map<String, Object?>);

      if (result.statusCode != 200 || !_post.isOwner) {
        UtilDialog.snackBar(message: UtilHttp.statusMsg(401));
        return false;
      }
    }
    return true;
  }

  void goPostUpdate() async {
    if (await _checkAuth()) {
      Get.toNamed(
        '/post-update/${_serviceBoard.boardType!.name}',
        arguments: {
          'isOwner': true,
          'post': _post,
        },
      );
    }
  }

  void actPostDelete() async {
    ModelHttpResult? result;
    if (_serviceBoard.isGuestBoard) {
      String? _password = await UtilDialog.getPassword();
      if (_password == null) {
        return;
      }
      result = await _serviceBoard.deleteByPassword(_post.id, _password);
    } else {
      result = await _serviceBoard.delete(_post.id, _userToken);
    }

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
}
