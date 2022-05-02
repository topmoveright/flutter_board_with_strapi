import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:yuonsoft/src/models/model_http_result.dart';

enum MethodType { get, post, put, delete }

class UtilHttp {
  UtilHttp._();

  static Map<String, Object?> _responseToJson(Uint8List bytes) {
    return jsonDecode(utf8.decode(bytes));
  }

  static ModelHttpResult _makeResult(http.Response response) {
    if (response.statusCode == 200) {
      return ModelHttpResult(
          response.statusCode, _responseToJson(response.bodyBytes));
    } else {
      return ModelHttpResult(response.statusCode, null);
    }
  }

  static Future<ModelHttpResult> _makeResultFromStream(
      http.StreamedResponse response) async {
    if (response.statusCode == 200) {
      var bodyBytes = await response.stream.toBytes();
      return ModelHttpResult(response.statusCode, _responseToJson(bodyBytes));
    } else {
      return ModelHttpResult(response.statusCode, null);
    }
  }

  static Future<ModelHttpResult> request({
    required MethodType methodType,
    required String path,
    Object? body,
    Map<String, String>? headers,
  }) async {
    late final http.Response response;
    try {
      switch (methodType) {
        case MethodType.get:
          response = await http.get(
            Uri.parse(path),
            headers: headers,
          );
          break;
        case MethodType.post:
          response = await http.post(
            Uri.parse(path),
            body: body,
            headers: headers,
          );
          break;
        case MethodType.put:
          response = await http.put(
            Uri.parse(path),
            body: body,
            headers: headers,
          );
          break;
        case MethodType.delete:
          response = await http.delete(
            Uri.parse(path),
            body: body,
            headers: headers,
          );
          break;
      }
    } catch (e) {
      // ignore: avoid_print
      // print(e);
    }
    return _makeResult(response);
  }

  static Future<ModelHttpResult> createWithFiles({
    required String path,
    required String fileParamName,
    required Map<String, String> body,
    required Map<String, String> headers,
    List<PlatformFile?> attachments = const [],
    bool isUpdate = false,
  }) async {
    late final http.StreamedResponse response;
    try {
      var request =
          http.MultipartRequest(isUpdate ? 'PUT' : 'POST', Uri.parse(path));
      request.fields.putIfAbsent('data', () => jsonEncode(body));
      request.headers.addAll(headers);
      for (var file in attachments) {
        if (file != null) {
          request.files.add(http.MultipartFile.fromBytes(
            fileParamName,
            List.from(file.bytes!),
            filename: file.name,
            contentType: MediaType('application', 'octet-stream'),
          ));
        }
      }
      response = await request.send();
    } catch (e) {
      // ignore: avoid_print
      // print(e);
    }
    return await _makeResultFromStream(response);
  }

  static String statusMsg(int code) {
    late final String msg;
    switch (code) {
      case 400:
        msg = '잘못된 요청입니다.';
        break;
      case 401:
        msg = '인증정보가 유효하지 않습니다.';
        break;
      case 403:
        msg = '권한이 없습니다.';
        break;
      case 404:
        msg = '페이지를 찾을 수 없습니다.';
        break;
      case 405:
        msg = '허용되지 않은 요청 방법입니다.';
        break;
      case 408:
        msg = '서버 응답시간이 초과되었습니다.';
        break;
      case 500:
        msg = '서버에 오류가 발생하였습니다.';
        break;
      case 502:
        msg = 'Bad Gateway';
        break;
      default:
        msg = '오류가 발생하였습니다.';
    }
    return msg;
  }
}
