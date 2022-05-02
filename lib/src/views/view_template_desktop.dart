import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/controllers/controller_auth.dart';

class ViewTemplateDesktop extends StatelessWidget {
  const ViewTemplateDesktop({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: GetBuilder<ControllerAuth>(builder: (ctl) {
                return ButtonBar(
                  children: [
                    ctl.isLoggedIn
                        ? TextButton(
                            onPressed: () => ctl.signOut(),
                            child: const Text('로그아웃'),
                          )
                        : TextButton(
                            onPressed: () => ctl.goSignIn(),
                            child: const Text('로그인'),
                          ),
                  ],
                );
              }),
            ),
          ),
          Expanded(child: child),
          const SizedBox(
            height: 100,
            child: Center(
              child: Text('Footer'),
            ),
          ),
        ],
      ),
    );
  }
}
