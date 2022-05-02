import 'package:flutter/material.dart';

class ViewTemplateDesktopBoard extends StatelessWidget {
  const ViewTemplateDesktopBoard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
