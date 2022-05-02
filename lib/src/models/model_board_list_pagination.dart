class ModelBoardListPagination {
  final int page; // 현재 페이지
  final int pageSize; // 페이지당 목록 갯수
  final int pageCount; // 총 페이지 갯수 (마지막 페이지)
  final int total; // 총 목록 갯수

  ModelBoardListPagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  ModelBoardListPagination.fromJson(Map<String, Object?> json)
      : this(
          page: json['page'] as int,
          pageSize: json['pageSize'] as int,
          pageCount: json['pageCount'] as int,
          total: json['total'] as int,
        );
}
