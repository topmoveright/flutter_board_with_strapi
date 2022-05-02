import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/views/view_template_desktop.dart';
import 'package:yuonsoft/src/views/view_template_error.dart';
import 'package:yuonsoft/src/views/view_template_phone.dart';
import 'package:yuonsoft/src/views/view_template_tablet.dart';

class ViewLayout extends GetResponsiveView {
  ViewLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget? desktop() => ViewTemplateDesktop(child: child);

  @override
  Widget? tablet() => ViewTemplateTablet(child: child);

  @override
  Widget? phone() => ViewTemplatePhone(child: child);

  @override
  Widget? watch() => const ViewTemplateError(msg: '지원하지 않는 디바이스 입니다.');
}
