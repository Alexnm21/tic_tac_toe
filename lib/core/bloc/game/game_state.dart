part of 'game_bloc.dart';

class GameState {
  final Scoreboard scoreboard;
  final bool xTurn;
  final Board board;

  final List<Box>? winnerBoxes;
  GameState(
      {required this.scoreboard,
      required this.board,
      this.xTurn = true,
      this.winnerBoxes});

  GameState copyWith({
    Scoreboard? scoreboard,
    bool? xTurn,
    Board? board,
    List<Box>? winnerBoxes,
  }) {
    return GameState(
      scoreboard: scoreboard ?? this.scoreboard,
      xTurn: xTurn ?? this.xTurn,
      board: board ?? this.board,
      winnerBoxes: winnerBoxes ?? this.winnerBoxes,
    );
  }
}
