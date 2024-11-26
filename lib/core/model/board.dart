import 'package:collection/collection.dart';

import 'package:tic_tac_toe/core/model/box.dart';

class Board {
  List<Box> boxes;

  Board({List<Box>? boxes})
      : boxes = boxes ??
            [
              Box(row: 0, col: 0, value: ''),
              Box(row: 0, col: 1, value: ''),
              Box(row: 0, col: 2, value: ''),
              Box(row: 1, col: 0, value: ''),
              Box(row: 1, col: 1, value: ''),
              Box(row: 1, col: 2, value: ''),
              Box(row: 2, col: 0, value: ''),
              Box(row: 2, col: 1, value: ''),
              Box(row: 2, col: 2, value: ''),
            ];

  markBox(int row, int col, String value) {
    boxes[row * 3 + col] = Box(row: row, col: col, value: value);
  }

  Box getBox({required int row, required int col}) {
    return boxes[row * 3 + col];
  }

  List<Box> getEmptyBoxes() {
    return boxes.where((box) => box.value == '').toList();
  }

  List<Box> getRow(int row) {
    return boxes.where((box) => box.row == row).toList();
  }

  List<Box> getColumn(int col) {
    return boxes.where((box) => box.col == col).toList();
  }

  List<Box> getLeftDiagonal() {
    return boxes.where((box) => box.row == box.col).toList();
  }

  List<Box> getRightDiagonal() {
    return boxes.where((box) => box.row + box.col == 2).toList();
  }

  Box? getWinnerBox(List<Box> boxes, String value) {
    if (boxes.length != 3) return null;
    int count = boxes.where((box) => box.value == value).length;
    if (count == 2) {
      Box? emptyBox = boxes.firstWhereOrNull((box) => box.value == '');
      return emptyBox;
    }
    return null;
  }

  bool isWinner(List<Box> boxes, String value) {
    if (boxes.length != 3) return false;
    int count = boxes.where((box) => box.value == value).length;
    return count == 3;
  }

  List<List<String>> toList() {
    return List<List<String>>.generate(3, (row) {
      return List<String>.generate(3, (col) {
        return getBox(row: row, col: col).value;
      });
    });
  }

  factory Board.fromList(List<List<String>> boxList) {
    return Board(
      boxes: List<Box>.generate(9, (index) {
        int row = index ~/ 3;
        int col = index % 3;
        return Box(row: row, col: col, value: boxList[row][col]);
      }),
    );
  }
}
