import 'package:flutter/material.dart';

class ViewTemplatePhoneBoard extends StatelessWidget {
  const ViewTemplatePhoneBoard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('mobile'),
      ),
      body: child,
    );
  }
}
