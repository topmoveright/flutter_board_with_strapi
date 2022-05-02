import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/views/view_template_desktop_board.dart';
import 'package:yuonsoft/src/views/view_template_phone_board.dart';
import 'package:yuonsoft/src/views/view_template_tablet_board.dart';

class ViewLayoutBoard extends GetResponsiveView {
  ViewLayoutBoard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget? desktop() => ViewTemplateDesktopBoard(child: child);

  @override
  Widget? tablet() => ViewTemplateTabletBoard(child: child);

  @override
  Widget? phone() => ViewTemplatePhoneBoard(child: child);

  @override
  Widget? watch() => const SizedBox.shrink();
}
