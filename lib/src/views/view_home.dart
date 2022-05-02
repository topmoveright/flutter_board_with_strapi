import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/core/services/service_board.dart';
import 'package:yuonsoft/src/views/view_layout.dart';

class ViewHome extends StatelessWidget {
  ViewHome({Key? key}) : super(key: key);

  final ServiceBoard serviceBoard = Get.find<ServiceBoard>();

  @override
  Widget build(BuildContext context) {
    return ViewLayout(
      child: serviceBoard.boardTypeList.isEmpty
          ? const Center(child: Text('게시판 목록이 비었습니다.'))
          : ListView.builder(
              itemCount: serviceBoard.boardTypeList.length,
              itemBuilder: (context, index) {
                var boardItem = serviceBoard.boardTypeList[index];
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Get.toNamed('/board/${boardItem.name}'),
                    child: ListTile(
                      title: Text(boardItem.nameKr),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
