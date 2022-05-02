import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/core/utils/util_http.dart';

class UtilDialog {
  static Future<String?> getPassword() async {
    var textController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return await Get.defaultDialog(
      title: '비밀번호 입력',
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: textController,
          autocorrect: false,
          obscureText: true,
          enableSuggestions: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '비밀번호를 입력해 주세요.';
            }
            return null;
          },
        ),
      ),
      confirm: TextButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            var password = textController.text.trim();
            Get.back(result: password);
          }
        },
        child: const Text('확인'),
      ),
    );
  }

  static snackBar({
    required String message,
    String title = '알림',
    Widget icon = const Icon(Icons.info),
  }) {
    Get.snackbar(
      title,
      message,
      margin: const EdgeInsets.only(top: 40.0),
      maxWidth: 600.0,
      icon: icon,
    );
  }
}
