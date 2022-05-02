import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/controllers/controller_auth.dart';

class ViewLogin extends GetView<ControllerAuth> {
  ViewLogin({Key? key}) : super(key: key);
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailCtrl.text = 'user_1@localhost.com';
    passwordCtrl.text = '12341234';
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailCtrl,
            obscureText: false,
            enableSuggestions: false,
            autocorrect: false,
          ),
          TextField(
            controller: passwordCtrl,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          ElevatedButton(
            onPressed: () => Get.find<ControllerAuth>().signIn(emailCtrl.text, passwordCtrl.text),
            child: const Text('Sign in'),
          ),
        ],
      ),
    );
  }
}
