import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuonsoft/src/controllers/controller_board.dart';
import 'package:yuonsoft/src/core/utils/util_datetime.dart';
import 'package:yuonsoft/src/models/model_board_list_item.dart';
import 'package:yuonsoft/src/models/model_page_data.dart';
import 'package:yuonsoft/src/views/view_layout_board.dart';

const listMinHeight = 500.0;

class ViewBoard extends GetView<ControllerBoard> {
  ViewBoard({Key? key}) : super(key: key);

  @override
  final controller = Get.find<ControllerBoard>(tag: '_${Get.currentRoute}');

  @override
  Widget build(BuildContext context) {
    return ViewLayoutBoard(
      child: controller.obx(
        (status) {
          var boardList = status!;
          var pageData = ModelPageData(
            pagination: boardList.pagination,
            pageSetSize: pageSetSize,
          );
          return Column(
            children: [
              buildList(boardList.list, pageData),
              buildButtonRow(),
              buildPagingRow(pageData),
            ],
          );
        },
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: const Center(child: Text('목록이 없습니다.')),
        onError: (error) => Center(child: Text(error ?? '')),
      ),
    );
  }

  Widget buildList(List<ModelBoardListItem> list, ModelPageData pageData) {
    return Container(
      constraints: const BoxConstraints(minHeight: listMinHeight),
      child: Column(
        children: List.generate(
          list.length,
          (index) {
            var listItem = list[index];
            return ListTile(
              leading: Text(pageData.postNum(index).toString()),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 7,
                    fit: FlexFit.loose,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => controller.goPost(listItem),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24,
                              child: listItem.private
                                  ? const Center(child: Icon(Icons.lock))
                                  : const SizedBox.shrink(),
                            ),
                            Text(listItem.subject),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Center(
                      child: Text(
                        listItem.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: SizedBox(
                width: 100,
                child: Center(
                    child: Text(UtilDataTime.strRegDT(listItem.createdAt))),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildButtonRow() {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
            onPressed: () => controller.goPostCreate(),
            icon: const Icon(Icons.create),
            label: const Text('글쓰기'),
          ),
        ],
      ),
    );
  }

  Widget buildPagingRow(ModelPageData pageData) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildPageNumButton(1, const Icon(Icons.first_page)),
                pageData.preStepPage == null
                    ? emptyButton()
                    : buildPageNumButton(
                        pageData.preStepPage,
                        const Icon(Icons.navigate_before),
                      ),
              ],
            ),
          ),
          const Spacer(),
          ...List.generate(
            pageData.pageSetList?.length ?? 0,
            (index) {
              if ((pageData.pageSetList?.length ?? 0) < index + 1) {
                return emptyButton();
              }

              var pageNum = pageData.pageSetList?[index];
              var isCurrentPage = pageNum == pageData.page;
              return Container(
                constraints: const BoxConstraints(minWidth: 48),
                child: Center(
                  child: buildPageNumButton(
                    pageNum,
                    Text(
                      pageNum.toString(),
                      style: TextStyle(
                        fontWeight:
                            isCurrentPage ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                pageData.nextStepPage == null
                    ? emptyButton()
                    : buildPageNumButton(
                        pageData.nextStepPage,
                        const Icon(Icons.navigate_next),
                      ),
                buildPageNumButton(
                  pageData.pageCount,
                  const Icon(Icons.last_page),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageNumButton(int? pageNum, Widget child) {
    return pageNum == null
        ? const SizedBox.shrink()
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => controller.goBoard(pageNum),
              child: child,
            ),
          );
  }

  Widget emptyButton() {
    return const SizedBox(
      width: 24,
      height: 24,
    );
  }
}
