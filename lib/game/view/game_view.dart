import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/core/model/box.dart';
import 'package:tic_tac_toe/core/widgets/cross.dart';
import 'package:tic_tac_toe/core/widgets/custom_button.dart';

import '../../core/bloc/game/game_bloc.dart';
import '../../core/model/board.dart';
import '../../core/model/scoreboard.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/circle.dart';

part '../parts/game_scoreboard.dart';
part '../parts/game_header.dart';
part '../parts/game_board.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GameHeader(
                xTurn: state.xTurn,
                onReset: () => context.read<GameBloc>().add(Reset()),
              ),
              const SizedBox(height: 50),
              GameBoard(
                board: state.board,
                onBoxTap: context.read<GameBloc>().onBoxTap,
                winnerBoxes: state.winnerBoxes,
              ),
              GameScoreboard(scoreboard: state.scoreboard),
            ],
          );
        },
      ),
    );
  }
}
