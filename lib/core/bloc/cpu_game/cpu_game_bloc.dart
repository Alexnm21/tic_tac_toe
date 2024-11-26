import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/core/bloc/game/game_bloc.dart';

import '../../model/board.dart';
import '../../model/box.dart';
import '../../model/scoreboard.dart';

part 'cpu_game_event.dart';
part 'cpu_game_state.dart';

enum CpuDifficulty { easy, medium, hard }

class CpuGameBloc extends Bloc<GameEvent, CpuGameState> {
  final String cpuValue;
  final CpuDifficulty difficulty;

  CpuGameBloc({required this.cpuValue, required this.difficulty})
      : super(CpuGameState(
          scoreboard: Scoreboard(),
          board: Board(),
          difficulty: difficulty,
        )) {
    on<XWins>((event, emit) {
      emit(state.copyWith(scoreboard: state.scoreboard..xWins()));
    });
    on<OWins>((event, emit) {
      emit(state.copyWith(scoreboard: state.scoreboard..oWins()));
    });
    on<Draw>((event, emit) {
      emit(state.copyWith(scoreboard: state.scoreboard..draw()));
    });
    on<Reset>((event, emit) {
      emit(
        CpuGameState(
          scoreboard: state.scoreboard,
          board: Board(),
          difficulty: difficulty,
          xTurn: !state.xTurn,
        ),
      );
      if (_isCpuTurn()) {
        cpuMakeMove();
      }
    });
    on<SwapTurn>((event, emit) {
      emit(state.copyWith(xTurn: !state.xTurn));
      if (_isCpuTurn()) {
        Future.delayed(
            Duration(
                milliseconds: difficulty == CpuDifficulty.hard
                    ? (9 - state.board.getEmptyBoxes().length) * 100
                    : 500), () {
          cpuMakeMove();
        });
      }
    });
    on<BoxTap>((event, emit) {
      Board newBoard = state.board..markBox(event.row, event.col, event.value);
      emit(state.copyWith(board: newBoard));
      checkIfGameContinues();
    });
    on<SetWinnerBoxes>((event, emit) {
      emit(state.copyWith(winnerBoxes: event.boxes));
    });
  }

  onBoxTap({required int row, required int col}) {
    if (state.winnerBoxes != null) return;
    if (state.board.getEmptyBoxes().isEmpty) return;
    if (_isCpuTurn()) return;
    if (state.xTurn) {
      add(BoxTap(row: row, col: col, value: 'X'));
    } else {
      add(BoxTap(row: row, col: col, value: 'O'));
    }
  }

  checkIfGameContinues() {
    List<Box>? winnerBoxes = _didWin(state.xTurn ? 'X' : 'O', state.board);
    if (winnerBoxes != null) {
      add(SetWinnerBoxes(boxes: winnerBoxes));
      if (state.xTurn) {
        add(XWins());
      } else {
        add(OWins());
      }
      return;
    }

    if (state.board.getEmptyBoxes().isEmpty) {
      add(Draw());
    } else {
      add(SwapTurn());
    }
  }

  bool _isCpuTurn() {
    if (cpuValue == 'X') {
      return state.xTurn;
    } else {
      return !state.xTurn;
    }
  }

  // Returns the positions of the boxes that won
  List<Box>? _didWin(String value, Board board) {
    // Horizontal
    for (int i = 0; i < 3; i++) {
      if (board.isWinner(board.getRow(i), value)) {
        return board.getRow(i);
      }
    }

    // Vertical
    for (int i = 0; i < 3; i++) {
      if (board.isWinner(board.getColumn(i), value)) {
        return board.getColumn(i);
      }
    }

    // Diagonal left to right
    if (board.isWinner(board.getLeftDiagonal(), value)) {
      return board.getLeftDiagonal();
    }

    // Diagonal right to left
    if (board.isWinner(board.getRightDiagonal(), value)) {
      return board.getRightDiagonal();
    }

    return null;
  }

  // * CPU LOGIC

  cpuMakeMove() {
    Box box;

    switch (difficulty) {
      case CpuDifficulty.easy:
        box = _easyMove();
        break;
      case CpuDifficulty.medium:
        box = _mediumMove();
        break;
      case CpuDifficulty.hard:
        box = _hardMove();
    }

    add(BoxTap(row: box.row, col: box.col, value: cpuValue));
  }

  Box _getRandomEmptyBox() {
    List<Box> emptyBoxes = state.board.getEmptyBoxes();
    return emptyBoxes[Random().nextInt(emptyBoxes.length)];
  }

  Box? _getWinningMove(String value) {
    Board board = state.board;

    // Check rows
    for (int i = 0; i < 3; i++) {
      Box? winnerBox = board.getWinnerBox(board.getRow(i), value);
      if (winnerBox != null) return winnerBox;
    }

    // Check columns
    for (int j = 0; j < 3; j++) {
      Box? winnerBox = board.getWinnerBox(board.getColumn(j), value);
      if (winnerBox != null) return winnerBox;
    }

    // Check diagonals
    Box? winnerBox = board.getWinnerBox(board.getLeftDiagonal(), value);
    if (winnerBox != null) return winnerBox;

    winnerBox = board.getWinnerBox(board.getRightDiagonal(), value);
    if (winnerBox != null) return winnerBox;

    return null;
  }

  Box _easyMove() {
    return _getRandomEmptyBox();
  }

  Box _mediumMove() {
    Box? winnerBox = _getWinningMove(cpuValue);
    if (winnerBox != null) return winnerBox;
    winnerBox = _getWinningMove(cpuValue == 'X' ? 'O' : 'X');
    return winnerBox ?? _getRandomEmptyBox();
  }

  Box _hardMove() {
    // if (state.board.getBox(row: 1, col: 1).value.isEmpty) {
    //   return state.board.getBox(row: 1, col: 1);
    // }

    int bestScore = -999;
    Box? bestMove;

    for (Box box in state.board.getEmptyBoxes()) {
      // Create a copy of the board
      Board simulatedBoard = _copyBoard(state.board);
      // Simulate the move
      simulatedBoard.markBox(box.row, box.col, cpuValue);

      // Calculate the score of the simulated move
      int score = minimax(simulatedBoard, 0, false);
      print('PUNTUACION CASILLA ${box.row} - ${box.col}: $score');
      // Update the best score and best move if applicable
      if (score > bestScore) {
        print(
            'SE HA SUPERADO EL MEJOR PUNTAJE \n CASILLA: ${box.row} - ${box.col}');
        bestScore = score;
        bestMove = box;
      }
    }
    print('MEJOR CASILLA: ${bestMove?.row} - ${bestMove?.col}');
    return bestMove!;
  }

  // Method to copy the board state
  Board _copyBoard(Board originalBoard) {
    Board newBoard = Board();
    for (Box box in originalBoard.boxes) {
      newBoard.markBox(box.row, box.col, box.value);
    }
    return newBoard;
  }

  int minimax(Board board, int depth, bool isMaximizing) {
    // Check if the CPU has won, and prioritize faster wins by subtracting the depth
    if (_didWin(cpuValue, board) != null) {
      return 10 - depth;
    }

    // Check if the player has won, and prefer delaying the loss by adding the depth
    if (_didWin(cpuValue == 'X' ? 'O' : 'X', board) != null) {
      return depth - 10;
    }

    // If no moves are left, it's a tie
    if (board.getEmptyBoxes().isEmpty) {
      return 0;
    }

    // Maximizing player's turn (CPU)
    if (isMaximizing) {
      int bestScore = -999;
      for (Box box in board.getEmptyBoxes()) {
        board.markBox(box.row, box.col, cpuValue);
        int score = minimax(board, depth + 1, false);
        board.markBox(box.row, box.col, '');

        // Choose the maximum score among all possible moves
        bestScore = max(score, bestScore);
      }
      return bestScore;
    } else {
      // Minimizing player's turn (Opponent)
      int bestScore = 999;
      for (Box box in board.getEmptyBoxes()) {
        // Simulate the move for the player
        board.markBox(box.row, box.col, cpuValue == 'X' ? 'O' : 'X');

        int score = minimax(board, depth + 1, true);

        // Undo the move
        board.markBox(box.row, box.col, '');

        // Choose the minimum score among all possible moves
        bestScore = min(score, bestScore);
      }
      return bestScore;
    }
  }
}
