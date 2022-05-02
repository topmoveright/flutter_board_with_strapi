import 'package:yuonsoft/src/models/model_board_list_pagination.dart';

class ModelPageData extends ModelBoardListPagination {
  late final List<int>? pageSetList; // 페이지 목록 리스트

  ModelPageData({
    required ModelBoardListPagination pagination,
    required int pageSetSize,
  }) : super(
          page: pagination.page,
          pageSize: pagination.pageSize,
          pageCount: pagination.pageCount,
          total: pagination.total,
        ) {
    var setList = List.generate(pageSetSize, (index) {
      var factor = page ~/ (pageSetSize + 1);
      return index + 1 + (factor * pageSetSize);
    }).where((e) => e <= pageCount).toList();

    pageSetList = setList.isEmpty ? null : setList;
  }

  bool get _isFirstPage => page == 1;

  bool get _isLastPage => page == pageCount;

  bool get _canPreStepPage =>
      (pageSetList?.length ?? 0) < (pageSetList?.first ?? 1);

  bool get _canNextStepPage => (pageSetList?.last ?? 1) != pageCount;

  int? get nextPage => _isLastPage ? null : page + 1;

  int? get prePage => _isFirstPage ? null : page - 1;

  int? get nextStepPage => _canNextStepPage
      ? (pageSetList?.first ?? 1) + (pageSetList?.length ?? 0)
      : null;

  int? get preStepPage =>
      _canPreStepPage ? (pageSetList?.first ?? 1) - 1 : null;

  int postNum(int listIndex) => total - (page - 1) * pageSize - listIndex;
}
