import 'package:yuonsoft/src/models/model_board_list_item.dart';
import 'package:yuonsoft/src/models/model_board_list_pagination.dart';

class ModelBoardList {
  final List<ModelBoardListItem> list;
  final ModelBoardListPagination pagination;

  ModelBoardList(this.list, this.pagination);
}