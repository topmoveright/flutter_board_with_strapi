import 'package:flutter/material.dart';

class ViewTemplateError extends StatelessWidget {
  const ViewTemplateError({Key? key, required this.msg}) : super(key: key);

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert'),
      ),
      body: Center(
        child: Text(msg),
      ),
    );
  }
}
