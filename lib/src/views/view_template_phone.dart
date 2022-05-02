import 'package:flutter/material.dart';

class ViewTemplatePhone extends StatelessWidget {
  const ViewTemplatePhone({Key? key, required this.child}) : super(key: key);

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
