import 'package:flutter/material.dart';

class ViewTemplateTablet extends StatelessWidget {
  const ViewTemplateTablet({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tablet'),
      ),
      body: child,
    );
  }
}
