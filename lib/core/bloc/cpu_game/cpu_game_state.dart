part of 'cpu_game_bloc.dart';

class CpuGameState extends GameState {
  final CpuDifficulty difficulty;

  CpuGameState(
      {required super.scoreboard,
      required super.board,
      super.xTurn,
      super.winnerBoxes,
      required this.difficulty});

  @override
  CpuGameState copyWith({
    Scoreboard? scoreboard,
    bool? xTurn,
    Board? board,
    List<Box>? winnerBoxes,
  }) {
    return CpuGameState(
      scoreboard: scoreboard ?? this.scoreboard,
      xTurn: xTurn ?? this.xTurn,
      board: board ?? this.board,
      winnerBoxes: winnerBoxes ?? this.winnerBoxes,
      difficulty: difficulty,
    );
  }
}
