part of 'game_bloc.dart';

abstract class GameEvent {}

class XWins extends GameEvent {}

class OWins extends GameEvent {}

class Draw extends GameEvent {}

class Reset extends GameEvent {}

class SwapTurn extends GameEvent {}

class BoxTap extends GameEvent {
  final int row;
  final int col;
  final String value;
  BoxTap({required this.row, required this.col, required this.value});
}

class SetWinnerBoxes extends GameEvent {
  final List<Box> boxes;
  SetWinnerBoxes({required this.boxes});
}
