import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/core/constants/constant_strapi.dart';
import 'package:yuonsoft/src/core/utils/util_http.dart';
import 'package:yuonsoft/src/core/utils/util_strapi.dart';
import 'package:yuonsoft/src/models/model_board_list.dart';
import 'package:yuonsoft/src/models/model_board_list_item.dart';
import 'package:yuonsoft/src/models/model_board_list_pagination.dart';
import 'package:yuonsoft/src/models/model_board_type.dart';
import 'package:yuonsoft/src/models/model_http_result.dart';

class ServiceBoard extends GetxService {
  ModelBoardType? _boardType;

  ModelBoardType? get boardType => _boardType;

  bool get isGuestBoard => boardType?.authentication == BoardAuth.guest;

  bool isGuestPrivate(ModelBoardListItem? listItem) =>
      isGuestBoard && (listItem?.private ?? false);

  List<ModelBoardType> boardTypeList = [];

  Map<String, String> _makeBearer(String? token) {
    return token == null ? {} : {'Authorization': 'Bearer $token'};
  }

  bool setBoardType(String boardName) {
    if (boardTypeList.any((e) => e.name == boardName)) {
      _boardType = boardTypeList.singleWhere((e) => e.name == boardName);
      return true;
    } else {
      return false;
    }
  }

  Future<ServiceBoard> init() async {
    // debugPrint('$runtimeType wait for board list');
    await setBoards();
    // debugPrint('$runtimeType ready!');
    return this;
  }

  Future<void> setBoards() async {
    var path = '${ConstantStrapi.host}/api/board-types';
    var result = await UtilHttp.request(methodType: MethodType.get, path: path);
    if (result.value != null) {
      var list = (result.value!['data'] as List)
          .map((e) => ModelBoardType.fromJson(UtilStrapi.mergeId(e)))
          .toList();
      if (list.isNotEmpty) {
        boardTypeList = list;
      }
    }
  }

  Future<ModelBoardList?> list({
    required int page,
    required int pageSize,
    String? token,
  }) async {
    var headers = _makeBearer(token);
    var filters = 'filters[board_type][id][\$eq]=${_boardType?.id}';
    var pagination =
        'sort=id:desc&pagination[page]=$page&pagination[pageSize]=$pageSize';
    var path = '${ConstantStrapi.host}/api/boards?$filters&$pagination';
    var result = await UtilHttp.request(
        methodType: MethodType.get, path: path, headers: headers);

    if (result.value != null) {
      var list = (result.value!['data'] as List)
          .map((e) => ModelBoardListItem.fromJson(UtilStrapi.mergeId(e)))
          .toList();
      var pagination = ModelBoardListPagination.fromJson(
          (result.value!['meta'] as Map)['pagination']);
      return ModelBoardList(list, pagination);
    }
    return null;
  }

  Future<ModelHttpResult> findOne(int id, [String? token]) async {
    var headers = _makeBearer(token);
    var pathBoard = 'boards';
    var path = '${ConstantStrapi.host}/api/$pathBoard/$id';
    return await UtilHttp.request(
      methodType: MethodType.get,
      path: path,
      headers: headers,
    );
  }

  Future<ModelHttpResult> findOneByPassword(int id, String password) async {
    var body = {'password': password};
    var pathBoard = 'boards-guest';
    var path = '${ConstantStrapi.host}/api/$pathBoard/$id';
    return await UtilHttp.request(
      methodType: MethodType.post,
      path: path,
      body: body,
    );
  }

  Future<ModelHttpResult> create(
      Map<String, String> body, List<PlatformFile?> attachments, String? token,
      [bool isUpdate = false, int? postId]) async {
    var path = '${ConstantStrapi.host}/api/boards${isUpdate ? '/$postId' : ''}';
    var headers = _makeBearer(token);
    return await UtilHttp.createWithFiles(
      path: path,
      headers: headers,
      body: body,
      fileParamName: 'files.attachment',
      attachments: attachments,
      isUpdate: isUpdate,
    );
  }

  Future<ModelHttpResult> update(
    Map<String, String> body,
    List<PlatformFile?> attachments,
    String? token,
  ) async {
    var path = '${ConstantStrapi.host}/api/boards';
    var headers = _makeBearer(token);
    return await UtilHttp.createWithFiles(
      path: path,
      headers: headers,
      body: body,
      fileParamName: 'files.attachment',
      attachments: attachments,
    );
  }

  Future<ModelHttpResult> delete(int id, String? token) async {
    var headers = _makeBearer(token);
    var pathBoard = 'boards';
    var path = '${ConstantStrapi.host}/api/$pathBoard/$id';
    return await UtilHttp.request(
      methodType: MethodType.delete,
      path: path,
      headers: headers,
    );
  }

  Future<ModelHttpResult> deleteByPassword(int id, String password) async {
    var body = {'password': password};
    var pathBoard = 'boards-guest';
    var path = '${ConstantStrapi.host}/api/$pathBoard/$id';
    return await UtilHttp.request(
      methodType: MethodType.put,
      path: path,
      body: body,
    );
  }
}
