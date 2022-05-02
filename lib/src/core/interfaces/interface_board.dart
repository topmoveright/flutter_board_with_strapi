import 'package:yuonsoft/src/models/model_board_type.dart';

abstract class InterfaceBoard {
  List<ModelBoardType> boardList = [];

  Future<InterfaceBoard> init() async {
    return this;
  }

  Future<void> setBoardList() async {}

  void totalCount(ModelBoardType board) {}

  void posts({
    required ModelBoardType board,
    required int start,
    required int end,
  }) {}
}
