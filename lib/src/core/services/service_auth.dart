import 'package:get/get.dart';
import 'package:yuonsoft/src/core/constants/constant_strapi.dart';
import 'package:yuonsoft/src/core/utils/util_http.dart';
import 'package:yuonsoft/src/models/model_user.dart';

class ServiceAuth extends GetxService {
  ModelUser? _user;

  ModelUser? get user => _user;

  Future<void> registration(
    String name,
    String email,
    String password,
  ) async {
    var body = {
      'username': name,
      'email': email,
      'password': password,
    };
    var path = '${ConstantStrapi.host}/api/auth/local/register';
    var result = await UtilHttp.request(
      methodType: MethodType.post,
      path: path,
      body: body,
    );
    if (result.value != null) {
      _user = ModelUser.fromJson(result.value!);
    }
  }

  Future<void> login(String email, String password) async {
    var body = {
      'identifier': email,
      'password': password,
    };
    var path = '${ConstantStrapi.host}/api/auth/local';
    var result = await UtilHttp.request(
      methodType: MethodType.post,
      path: path,
      body: body,
    );
    if (result.value != null) {
      _user = ModelUser.fromJson(result.value!);
    }
  }

  Future<void> logout() async {
    _user = null;
  }
}
