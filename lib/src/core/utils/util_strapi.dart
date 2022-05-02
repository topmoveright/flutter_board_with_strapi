import 'package:yuonsoft/src/core/constants/constant_strapi.dart';

class UtilStrapi {
  UtilStrapi._();

  static _isStrapiEntity(Map<String, Object?> entity) {
    return entity.containsKey('id') && entity.containsKey('attributes');
  }

  static Map<String, Object?> mergeId(Map<String, Object?> entity) {
    try {
      assert(_isStrapiEntity(entity), 'This is not strapi response');
      return {
        'id': entity['id'],
        ...entity['attributes'] as Map<String, Object?>,
      };
    } catch (e) {
      // ignore: avoid_print
      // print(e);
      return {};
    }
  }

  static String makeLink(String path) {
    return '${ConstantStrapi.host}$path';
  }
}
