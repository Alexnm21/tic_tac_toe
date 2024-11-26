import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/core/model/box.dart';

import '../../model/board.dart';
import '../../model/scoreboard.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState(scoreboard: Scoreboard(), board: Board())) {
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
        GameState(
            scoreboard: state.scoreboard, board: Board(), xTurn: !state.xTurn),
      );
    });
    on<SwapTurn>((event, emit) {
      emit(state.copyWith(xTurn: !state.xTurn));
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
    if (state.board.getBox(row: row, col: col).value.isNotEmpty) return;
    if (state.xTurn) {
      add(BoxTap(row: row, col: col, value: 'X'));
    } else {
      add(BoxTap(row: row, col: col, value: 'O'));
    }
  }

  checkIfGameContinues() {
    List<Box>? winnerBoxes = _didWin(state.xTurn ? 'X' : 'O');
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

  // Returns the positions of the boxes that won
  List<Box>? _didWin(String value) {
    Board board = state.board;
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
}
