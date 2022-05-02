import 'package:flutter/material.dart';

class ViewTemplateNotFound extends StatelessWidget {
  const ViewTemplateNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert'),
      ),
      body: const Center(
        child: Text('404 Not Found!'),
      ),
    );
  }
}
